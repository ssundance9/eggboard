package com.eggtec.eggboard.controller;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.eggtec.eggboard.model.User;
import com.eggtec.eggboard.service.UserService;
import com.eggtec.eggboard.util.Constants;
import com.eggtec.eggboard.util.MailSender;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 회원관련 컨트롤러
 * @author ssundance
 *
 */
@Controller
public class UserController extends BaseController {
    Logger log = Logger.getLogger(this.getClass());
    
    @Inject
    UserService userService;
    
    // 로그인
    @RequestMapping("/user/loginView.do")
    public String loginView(Model model) {
        return getViewPrepix() + "/user/loginView";
    }
    
    @RequestMapping("/user/login.do")
    public String login(Model model, String userId, String userPw, RedirectAttributes rAttributes) {
        User param = new User();
        param.setUserId(userId);
        param.setUserPw(userPw);
        
        User user = userService.getUserById(userId);
        
        // 아이디 오류
        if (user == null) {
            rAttributes.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/user/loginView.do";
        } else {
            // 승인전 로그인 안됨
            if (StringUtils.equals(user.getUserType(), Constants.UserTypeMember) && StringUtils.isEmpty(user.getSerialNo())) {
                rAttributes.addFlashAttribute("errorMsg", "아직 승인받지 않은 회원입니다.");
                return "redirect:/user/loginView.do";
            }
            
            
            if (StringUtils.equals(userPw, user.getUserPw())) {
                HttpSession session = super.getSession();
                
                if (StringUtils.equals(user.getUserType(), Constants.UserTypeMember)) {
                    session.setAttribute("user", user);
                    return "redirect:/frt/eggStatus.do?farmNo=1";
                } else {
                    session.setAttribute("admin", user);
                    return "redirect:/adm/userStatus.do";
                }
            // 비밀번호 오류
            } else {
                rAttributes.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                return "redirect:/user/loginView.do";
            }
        }
    }
    
    // 회원가입 1
    @RequestMapping("/user/createUserView1.do")
    public String createUserView1(Model model) {
        return getViewPrepix() + "/user/createUserView1";
    }
    
    // 회원가입 2
    @RequestMapping("/user/createUserView2.do")
    public String createUserView2(Model model, String agreeYn) {
        if (!StringUtils.equals(agreeYn, "Y")) {
            return "redirect:/user/loginView.do";
        }
        
        return getViewPrepix() + "/user/createUserView2";
    }
    
    // 아이디 체크
    @RequestMapping("/user/checkId.do")
    public View checkId(Model model, String id) {
        boolean result = false;
        
        if (StringUtils.isNotEmpty(id)) {
            result = userService.getIdForDupl(id);
        } else {
            result = true;
        }
        
        model.addAttribute("result", result);
        
        return new MappingJackson2JsonView();
    }
    
    // 이메일 체크
    @RequestMapping("/user/checkEmail.do")
    public View checkEmail(Model model, String email) {
        boolean result = false;
        
        User user = super.getUser();
        if (user == null) {
            if (StringUtils.isNotEmpty(email)) {
                result = userService.getEmailForDupl(email);
            } else {
                result = true;
            }
        } else {
            if (StringUtils.isNotEmpty(email)) {
                
                if (StringUtils.equals(user.getUserEmail(), email)) {
                    result = false;
                } else {
                    result = userService.getEmailForDupl(email);
                }
            } else {
                result = true;
            }
        }
        
        model.addAttribute("result", result);
        
        return new MappingJackson2JsonView();
    }
    
    // 회원가입
    @RequestMapping("/user/registUser.do") 
    public String registUser(Model model, User user, String[] henCount, String[] entDt
            , HttpServletRequest request, RedirectAttributes rAttributes) {
        
        MultipartFile uploadfile = user.getUploadFile();
        if (uploadfile != null && !uploadfile.isEmpty()) {
            String fileName = uploadfile.getOriginalFilename();
            
            user.setPhotoInfo(fileName);
            try {
                String uploadPath = request.getServletContext().getRealPath("/upload");
                String today = new SimpleDateFormat("/yyyyMMdd/").format(new Date());
                uploadPath = uploadPath + today + user.getUserId() + "/";
                File file = new File(uploadPath + fileName);
                if(!file.exists()) {
                    file.mkdirs();
                }
                uploadfile.transferTo(file);
                
                user.setPhotoInfo("/upload" + today + user.getUserId()  + "/" + fileName);
            } catch (IOException e) {
                e.printStackTrace();
            } // try - catch
        } // if

        
        user.setUserType(Constants.UserTypeMember);
        
        User newUser = userService.createUser(user, henCount, entDt);
        rAttributes.addFlashAttribute("user", newUser);
        
        // 가입 메일 발송
        String body = "";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("user", newUser);
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_23);
        cfg.setServletContextForTemplateLoading(request.getServletContext(), "/WEB-INF/freemarker/");
        
        try {
            Writer out = new StringWriter();
            Template tem = cfg.getTemplate("joinMail.ftl");
            tem.process(map, out);
            body = out.toString();
            
            MailSender.send(user.getUserEmail(), "에그보드 가입 메일", body);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "redirect:/user/createUserView3.do";
    }
    
    // 회원가입 3
    @RequestMapping("/user/createUserView3.do")
    public String createUserView3(Model model, RedirectAttributes rAttributes) {
        return getViewPrepix() + "/user/createUserView3";
    }
    
    @RequestMapping("/logout.do")
    public String logout(Model model, RedirectAttributes rAttributes) {
        HttpSession session = super.getSession();
        session.invalidate();
        
        return "redirect:/user/loginView.do";
    }
    
    @RequestMapping("/user/searchId.do")
    public View searchId(Model model, String userName, String userMphone) {
        boolean result = false;
        String id = null;
        
        if (StringUtils.isNotEmpty(userName) && StringUtils.isNotEmpty(userMphone)) {
            User param = new User();
            param.setUserName(userName);
            param.setUserMphone(userMphone);
            List<User> userList = userService.getUserList(param);
            
            if (userList == null || userList.isEmpty()) {
                result = false;
            } else {
                List<String> idList = new ArrayList<String>();
                
                for (User u : userList) {
                    id = StringUtils.substring(u.getUserId(), 0, u.getUserId().length() - 2);
                    id = id + "**";
                    
                    idList.add(id);
                }
                
                result = true;
                model.addAttribute("idList", idList);
            }
        } else {
            result = false;
        }
        
        model.addAttribute("result", result);
        
        return new MappingJackson2JsonView();
    }
    
    @RequestMapping("/user/searchPw.do")
    public View searchPw(Model model, String userId, String userName, String userMphone) {
        boolean result = false;
        
        if (StringUtils.isNotEmpty(userId)
                && StringUtils.isNotEmpty(userName)
                && StringUtils.isNotEmpty(userMphone)) {
            User param = new User();
            param.setUserId(userId);
            param.setUserName(userName);
            param.setUserMphone(userMphone);
            List<User> userList = userService.getUserList(param);
            
            if (userList == null || userList.isEmpty()) {
                result = false;
            } else {
                result = true;
                User user = userList.get(0);
                model.addAttribute("userPw", user.getUserPw());
            }
        } else {
            result = false;
        }
        
        model.addAttribute("result", result);
        
        return new MappingJackson2JsonView();
    }
    
}

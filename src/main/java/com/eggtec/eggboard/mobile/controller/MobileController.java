package com.eggtec.eggboard.mobile.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MobileController {
    
    /*@RequestMapping("/main")
    public String main() {
        return "redirect:/m/loginView.do";
    }*/
    
    @RequestMapping("/m/loginView")
    public String loginView(Model model) {
        return "m/loginView";
    }

}

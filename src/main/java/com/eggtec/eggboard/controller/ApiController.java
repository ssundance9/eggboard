package com.eggtec.eggboard.controller;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.eggtec.eggboard.model.Bin;
import com.eggtec.eggboard.model.Egg;
import com.eggtec.eggboard.model.ErrorCode;
import com.eggtec.eggboard.model.Fan;
import com.eggtec.eggboard.model.Farm;
import com.eggtec.eggboard.model.Light;
import com.eggtec.eggboard.model.Thermometer;
import com.eggtec.eggboard.service.ApiService;
import com.eggtec.eggboard.util.Constants;

@Controller
public class ApiController {
    Logger log = Logger.getLogger(this.getClass());
    
    @Inject
    ApiService apiService;
    
    /*@RequestMapping("/api/test")
    public String test(HttpServletRequest req) {
        return null;
    }*/
    
    @RequestMapping("/api/uploadEggData")
    public String uploadEggData(HttpServletRequest req) {
        String message = "";
        String code = "";
        String resultStr = "";
        
        try{
            InputSource   is = new InputSource(req.getReader());
            Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
            document.getDocumentElement().normalize();
            
            log.debug(convertToString(document));

            // xpath 생성
            XPath  xpath = XPathFactory.newInstance().newXPath();
            
            String serialNo = (String) xpath.evaluate("//*/serialNo", document, XPathConstants.STRING);
            List<Farm> farmList = new ArrayList<Farm>();
            List<Egg> eggList = new ArrayList<Egg>();
            
            // NodeList 가져오기 
            NodeList farms = (NodeList) xpath.evaluate("/farms/farm", document, XPathConstants.NODESET);
            for (int i = 0; i < farms.getLength(); i++){
                Farm farmObj = convertToFarm(farms.item(i), serialNo, "E");
                int farmNo = farmObj.getFarmNo();
                farmList.add(farmObj);
                
                String ex = "/farms/farm[no="+ farmNo +"]/eggs/egg";
                NodeList eggs = (NodeList) xpath.evaluate(ex, document, XPathConstants.NODESET);
                for (int j = 0; j < eggs.getLength(); j++){
                    Egg eggObj = convertToEgg(eggs.item(j), serialNo, farmNo);
                    eggList.add(eggObj);
                }
            }
            
            apiService.createEggInfo(farmList, eggList);
            
            message = "성공";
            code = "00";
            resultStr = "<result>"
                          + "<message>" + message + "</message>"
                          + "<code>" + code + "</code>"
                      + "</result>";
        } catch(Exception e) {
            message = "실패 : " + e.getMessage();
            code = "99";
            resultStr = "<result>"
                    + "<message>" + message + "</message>"
                    + "<code>" + code + "</code>"
                + "</result>";
            e.printStackTrace();
        }

        req.setAttribute("resultStr", resultStr);
        return "/api/result";
    }
    
    @RequestMapping("/api/uploadFarmData")
    public String uploadFarmData(HttpServletRequest req) {
        String message = "";
        String code = "";
        String resultStr = "";
        
        try{
            InputSource   is = new InputSource(req.getReader());
            Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);  
            document.getDocumentElement().normalize();
            
            log.debug(convertToString(document));

            // xpath 생성
            XPath  xpath = XPathFactory.newInstance().newXPath();
            
            String serialNo = (String) xpath.evaluate("//*/serialNo", document, XPathConstants.STRING);
            //String waterQntty = (String) xpath.evaluate("//*/waterQuantity", document, XPathConstants.STRING);
            String connectionStatus = (String) xpath.evaluate("//*/connectionStatus", document, XPathConstants.STRING);
            String status = (String) xpath.evaluate("//*/status", document, XPathConstants.STRING);
            List<Farm> farmList = new ArrayList<Farm>();
            List<Bin> binList = new ArrayList<Bin>();
            List<Thermometer> thermoList = new ArrayList<Thermometer>();
            List<Light> lightList = new ArrayList<Light>();
            List<Fan> fanList = new ArrayList<Fan>();
            
            // NodeList 가져오기 
            //NodeList farms = (NodeList) xpath.evaluate("/farms/farm", document, XPathConstants.NODESET);
            //for (int i = 0; i < farms.getLength(); i++){
                //Farm farmObj = convertToFarm(farms.item(i), serialNo, "F");
                Farm farmObj = new Farm();
                farmObj.setSerialNo(serialNo);
                farmObj.setType("F");
                farmObj.setFarmNo(1); // 시설현황은 계사별로 존재하지 않음 고정번호 부여
                farmObj.setConnectionStatus(connectionStatus);
                farmObj.setStatus(status);
                //farmObj.setWaterQntty(convertToDouble(waterQntty));
                //int farmNo = farmObj.getFarmNo();
                farmList.add(farmObj);
                
                //String ex = "/farms/farm[no="+ farmNo +"]/bins/bin";
                String ex = "/equips/bins/bin";
                NodeList bins = (NodeList) xpath.evaluate(ex, document, XPathConstants.NODESET);
                for (int j = 0; j < bins.getLength(); j++){
                    Bin binObj = convertToBin(bins.item(j), serialNo);
                    binList.add(binObj);
                }
                
                //ex = "/farms/farm[no="+ farmNo +"]/thermometers/thermometer";
                ex = "/equips/thermometers/thermometer";
                NodeList thermos = (NodeList) xpath.evaluate(ex, document, XPathConstants.NODESET);
                for (int k = 0; k < thermos.getLength(); k++){
                    Thermometer thermoObj = convertToThermo(thermos.item(k), serialNo);
                    thermoList.add(thermoObj);
                }
                
                //ex = "/farms/farm[no="+ farmNo +"]/lights/light";
                ex = "/equips/lights/light";
                NodeList lights = (NodeList) xpath.evaluate(ex, document, XPathConstants.NODESET);
                for (int l = 0; l < lights.getLength(); l++){
                    Light lightObj = convertToLight(lights.item(l), serialNo);
                    lightList.add(lightObj);
                }
                
                //ex = "/farms/farm[no="+ farmNo +"]/fans/fan";
                ex = "/equips/fans/fan";
                NodeList fans = (NodeList) xpath.evaluate(ex, document, XPathConstants.NODESET);
                for (int m = 0; m < fans.getLength(); m++){
                    Fan fanObj = convertToFan(fans.item(m), serialNo);
                    fanList.add(fanObj);
                }
            //}
            
            apiService.createFarmInfo(farmList, binList, thermoList, lightList, fanList);
            
            message = "성공";
            code = "00";
            resultStr = "<result>"
                          + "<message>" + message + "</message>"
                          + "<code>" + code + "</code>"
                      + "</result>";
        } catch(Exception e) {
            message = "실패 : " + e.getMessage();
            code = "99";
            resultStr = "<result>"
                    + "<message>" + message + "</message>"
                    + "<code>" + code + "</code>"
                + "</result>";
            e.printStackTrace();
        }

        req.setAttribute("resultStr", resultStr);
        return "/api/result";
    }
    
    @RequestMapping("/api/uploadErrorData")
    public String uploadErrorData(HttpServletRequest req) {
        String message = "";
        String code = "";
        String resultStr = "";
        
        try{
            InputSource is = new InputSource(req.getReader());
            Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
            document.getDocumentElement().normalize();
            
            log.debug(convertToString(document));

            // xpath 생성
            XPath  xpath = XPathFactory.newInstance().newXPath();
            
            String serialNo = (String) xpath.evaluate("//*/serialNo", document, XPathConstants.STRING);
            List<ErrorCode> errorList = new ArrayList<ErrorCode>();
            
            // NodeList 가져오기 
            NodeList packers = (NodeList) xpath.evaluate("/errors/packer", document, XPathConstants.NODESET);
            for (int i = 0; i < packers.getLength(); i++){
                ErrorCode errorObj = convertToError(packers.item(i), serialNo, "P");
                errorList.add(errorObj);
            }
            
            NodeList machines = (NodeList) xpath.evaluate("/errors/machine", document, XPathConstants.NODESET);
            for (int j = 0; j < machines.getLength(); j++){
                ErrorCode errorObj = convertToError(machines.item(j), serialNo, "M");
                errorList.add(errorObj);
            }
            
            apiService.createErrorInfo(errorList);
            
            message = "성공";
            code = "00";
            resultStr = "<result>"
                          + "<message>" + message + "</message>"
                          + "<code>" + code + "</code>"
                      + "</result>";
        } catch(Exception e) {
            message = "실패 : " + e.getMessage();
            code = "99";
            resultStr = "<result>"
                    + "<message>" + message + "</message>"
                    + "<code>" + code + "</code>"
                + "</result>";
            e.printStackTrace();
        }

        req.setAttribute("resultStr", resultStr);
        return "/api/result";
    }
    
    @RequestMapping("/api/uploadWaterData")
    public String uploadWaterData(HttpServletRequest req) {
        String message = "";
        String code = "";
        String resultStr = "";
        
        try{
            InputSource is = new InputSource(req.getReader());
            Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
            document.getDocumentElement().normalize();
            
            log.debug(convertToString(document));

            // xpath 생성
            XPath  xpath = XPathFactory.newInstance().newXPath();
            
            String serialNo = (String) xpath.evaluate("//*/serialNo", document, XPathConstants.STRING);
            Double waterQuantity = (Double) xpath.evaluate("//*/waterQuantity", document, XPathConstants.NUMBER);
            
            Farm farmObj = new Farm();
            farmObj.setSerialNo(serialNo);
            farmObj.setType(Constants.DataTypeWater);
            farmObj.setFarmNo(1); // 급수현황은 계사별로 존재하지 않음 고정번호 부여
            farmObj.setWaterQntty(waterQuantity);
            
            apiService.createWaterInfo(farmObj);
            
            message = "성공";
            code = "00";
            resultStr = "<result>"
                          + "<message>" + message + "</message>"
                          + "<code>" + code + "</code>"
                      + "</result>";
        } catch(Exception e) {
            message = "실패 : " + e.getMessage();
            code = "99";
            resultStr = "<result>"
                    + "<message>" + message + "</message>"
                    + "<code>" + code + "</code>"
                + "</result>";
            e.printStackTrace();
        }

        req.setAttribute("resultStr", resultStr);
        return "/api/result";
    }
    
    private String getSingleNodeTextContent(NodeList nl, String nodeName) {
        String text = "";
        
        for (int i = 0; i < nl.getLength(); i++) {
            Node item = nl.item(i);
            
            if (StringUtils.equals(nodeName, item.getNodeName())) {
                text = item.getTextContent();
                break;
            }
        }
        
        return text;
    }
    
    private Farm convertToFarm(Node farm, String serialNo, String type) {
        Farm farmObj = new Farm();
        farmObj.setSerialNo(serialNo);
        farmObj.setFarmNo(Integer.parseInt(getSingleNodeTextContent(farm.getChildNodes(), "no")));
        farmObj.setConnectionStatus(getSingleNodeTextContent(farm.getChildNodes(), "connectionStatus"));
        farmObj.setStatus(getSingleNodeTextContent(farm.getChildNodes(), "status"));
        farmObj.setInputCount(convertToInteger(getSingleNodeTextContent(farm.getChildNodes(), "inputCount")));
        farmObj.setHenCount(convertToInteger(getSingleNodeTextContent(farm.getChildNodes(), "henCount")));
        farmObj.setEntDt(getSingleNodeTextContent(farm.getChildNodes(), "entDt"));
        farmObj.setWaterQntty(convertToDouble(getSingleNodeTextContent(farm.getChildNodes(), "waterQuantity")));
        //farmObj.setErrorCode(getSingleNodeTextContent(farm.getChildNodes(), "errorCode"));
        farmObj.setType(type);
        
        return farmObj;
    }
    
    private Egg convertToEgg(Node egg, String serialNo, int farmNo) {
        Egg eggObj = new Egg();
        eggObj.setSerialNo(serialNo);
        eggObj.setFarmNo(farmNo);
        eggObj.setGrade(getSingleNodeTextContent(egg.getChildNodes(), "grade"));
        //eggObj.setWeightRange(getSingleNodeTextContent(egg.getChildNodes(), "weightRange"));
        eggObj.setProdRatio(convertToDouble(getSingleNodeTextContent(egg.getChildNodes(), "productRatio")));
        eggObj.setQntty(convertToInteger(getSingleNodeTextContent(egg.getChildNodes(), "quantity")));
        eggObj.setBox(convertToInteger(getSingleNodeTextContent(egg.getChildNodes(), "box")));
        eggObj.setTotalWeight(convertToDouble(getSingleNodeTextContent(egg.getChildNodes(), "totalWeight")));
        eggObj.setAvrgWeight(convertToDouble(getSingleNodeTextContent(egg.getChildNodes(), "averageWeight")));
        
        return eggObj;
    }
    
    private Bin convertToBin(Node bin, String serialNo) {
        Bin binObj = new Bin();
        binObj.setSerialNo(serialNo);
        //binObj.setFarmNo(farmNo);
        binObj.setBinNo(Integer.parseInt(getSingleNodeTextContent(bin.getChildNodes(), "no")));
        binObj.setCurrentWeight(convertToDouble(getSingleNodeTextContent(bin.getChildNodes(), "currentWeight")));
        binObj.setUsedWeight(convertToDouble(getSingleNodeTextContent(bin.getChildNodes(), "usedWeight")));
        binObj.setAddWeight(convertToDouble(getSingleNodeTextContent(bin.getChildNodes(), "addWeight")));
        
        return binObj;
    }
    
    private Thermometer convertToThermo(Node thermo, String serialNo) {
        Thermometer thermoObj = new Thermometer();
        thermoObj.setSerialNo(serialNo);
        //thermoObj.setFarmNo(farmNo);
        thermoObj.setThermometerNo(convertToInteger(getSingleNodeTextContent(thermo.getChildNodes(), "no")));
        thermoObj.setDegree(convertToDouble(getSingleNodeTextContent(thermo.getChildNodes(), "degree")));
        
        return thermoObj;
    }
    
    private Fan convertToFan(Node fan, String serialNo) {
        Fan fanObj = new Fan();
        fanObj.setSerialNo(serialNo);
        //fanObj.setFarmNo(farmNo);
        fanObj.setFanNo(convertToInteger(getSingleNodeTextContent(fan.getChildNodes(), "no")));
        fanObj.setStatus(getSingleNodeTextContent(fan.getChildNodes(), "status"));
        
        return fanObj;
    }
    
    private Light convertToLight(Node light, String serialNo) {
        Light lightObj = new Light();
        lightObj.setSerialNo(serialNo);
        //lightObj.setFarmNo(farmNo);
        lightObj.setLightNo(convertToInteger(getSingleNodeTextContent(light.getChildNodes(), "no")));
        lightObj.setLux(convertToInteger(getSingleNodeTextContent(light.getChildNodes(), "lux")));
        
        return lightObj;
    }
    
    private ErrorCode convertToError(Node error, String serialNo, String type) {
        ErrorCode errorObj = new ErrorCode();
        errorObj.setSerialNo(serialNo);
        errorObj.setType(type);
        errorObj.setErrorNo(convertToInteger(getSingleNodeTextContent(error.getChildNodes(), "no")));
        errorObj.setErrorCode(getSingleNodeTextContent(error.getChildNodes(), "errorCode"));
        
        return errorObj;
    }
    
    private Integer convertToInteger(String num) {
        if (StringUtils.isEmpty(num)) {
            return null;
        } else if (StringUtils.isNumeric(num)){
            return Integer.parseInt(num);
        } else {
            return null;
        }
    }
    
    private Double convertToDouble(String num) {
        if (StringUtils.isEmpty(num)) {
            return null;
        } else if (StringUtils.isNumeric(StringUtils.remove(num, "."))){
            return Double.parseDouble(num);
        } else {
            return null;
        }
    }
    
    private String convertToString(Document doc) {
        try {
            DOMSource domSource = new DOMSource(doc);
            StringWriter writer = new StringWriter();
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            
            return writer.toString();
        } catch (Exception e) {
            return null;
        }
    }
}

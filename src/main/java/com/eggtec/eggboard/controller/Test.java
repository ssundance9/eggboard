package com.eggtec.eggboard.controller;

import java.io.StringReader;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.lang.StringUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class Test {

	public static void main(String[] args) {
		try {
		// TODO Auto-generated method stub
			String xml = "<farms>"
							+ "<farm>"
								+ "<no>1</no>"
								+ "<eggs>"
									+ "<egg>"
										+ "<no>1</no>"
									+ "</egg>"
									+ "<egg>"
									    + "<no>2</no>"
									+ "</egg>"
								+ "</eggs>"
							+ "</farm>" 
							+ "<farm>"
								+ "<no>2</no>"
								+ "<eggs>"
									+ "<egg>"
										+ "<no>3</no>"
									+ "</egg>"
									+ "<egg>"
									    + "<no>4</no>"
									+ "</egg>"
								+ "</eggs>"
							+ "</farm>"
                       + "</farms>";
		
		
			// XML Document 객체 생성
	        InputSource is = new InputSource(new StringReader(xml));
	        Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
	        
	        
	        
	        // xpath 생성
	        XPath xpath = XPathFactory.newInstance().newXPath();
	         
	        // NodeList 가져오기 : row 아래에 있는 모든 col1 을 선택
	        NodeList farms = (NodeList) xpath.evaluate("/farms/farm", document, XPathConstants.NODESET);
	        for (int i = 0; i < farms.getLength(); i++){
	            Node farm = farms.item(i);
	            
	            
	            NodeList fl = farm.getChildNodes();
	            String fno = fl.item(0).getTextContent();
	            
	            System.out.println(farm.getNodeName() + "/" + fno);
	        	
	        	String ex = "/farms/farm[no="+ fno +"]/eggs/egg";
	        	NodeList eggs = (NodeList) xpath.evaluate(ex, document, XPathConstants.NODESET);
	        	for (int j = 0; j < eggs.getLength(); j++){
	        		Node egg = eggs.item(j);
	        		
	        		NodeList el = egg.getChildNodes();
		            String eno = el.item(0).getTextContent();
	        		
		            System.out.println(egg.getNodeName() + "/" + eno);
	        	}
	        }
	        
	        
	        //String a = "   <aaa>12  12</aaa>   <bbb>123 456  </bbb>";
	        
	        System.out.println(StringUtils.isNumeric(StringUtils.remove("123.4", ".")));
	        System.out.println(Double.parseDouble("123.4"));
	        
	        
        
        
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

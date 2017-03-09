package com.eggtec.eggboard;

import org.apache.commons.lang.StringUtils;

import com.eggtec.eggboard.util.MailSender;

public class Test {
    public static void main(String[] args) {
        MailSender.send("joonover2@naver.com", "test", "test");
    }
}

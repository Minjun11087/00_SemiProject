package com.kh.semi.common.template;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;


public class MyFileRenamePolicy {
    public String rename(String originName) {
        String ext = originName.substring(originName.lastIndexOf("."));
        String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int randomNum = (int)(Math.random() * 90000) + 10000; // 5자리 랜덤
        return timeStamp + "_" + randomNum + ext;
    }
}

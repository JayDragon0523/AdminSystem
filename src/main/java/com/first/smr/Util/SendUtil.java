package com.first.smr.Util;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import java.io.IOException;

public class SendUtil {

    public SendUtil() {
        // TODO 自动生成的构造函数存根
    }
    public void sendMess(String userTel,int random) throws  IOException
    {
        String message="校验码为："+random;
        HttpClient client = new HttpClient();
        PostMethod post = new PostMethod("http://utf8.api.smschinese.cn");
        post.addRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf8");//在头文件中设置转码
        NameValuePair[] data ={ new NameValuePair("Uid", "众里寻车"),new NameValuePair("Key", "d41d8cd98f00b204e980"),new NameValuePair("smsMob",userTel),new NameValuePair("smsText",message)};
        post.setRequestBody(data);
        client.executeMethod(post);
        Header[] headers = post.getResponseHeaders();
        int statusCode = post.getStatusCode();
        System.out.println("statusCode:"+statusCode);
        for(Header h : headers)
        {
            System.out.println(h.toString());
        }
        String result = new String(post.getResponseBodyAsString().getBytes("utf8"));
        System.out.println(result); //打印返回消息状态
        post.releaseConnection();

    }
}
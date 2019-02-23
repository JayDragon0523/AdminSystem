package com.smart.web;

import java.util.List;

public class Page {

    public static  List Page(List list,String page,String limit){
        int size =  list.size();
        int p=Integer.parseInt(page);
        int l=Integer.parseInt(limit);
        if(size<=l)//仅一页且小于limit
            return list.subList(l*(p-1),size);
        else if((size-(p-1)*l)<=l) //最后一页小于limit
            return list.subList(l*(p-1),size);
        else//正常情况
            return list.subList(l*(p-1),l*p);
    }
}

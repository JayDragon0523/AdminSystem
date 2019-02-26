package com.first.smr;

public class CommonResult {
    private int status;
    private String result;

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    private String msg;
    private Object data;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public CommonResult()
    {
        status=200;
        result="success";
        msg="接口调用成功";
    }
    public CommonResult(int status, String msg)
    {
        this.status=status;
        this.msg=msg;
    }
    public CommonResult(int status,String msg,Object data)
    {
        this.status=status;
        this.msg=msg;
        this.data=data;
    }

}

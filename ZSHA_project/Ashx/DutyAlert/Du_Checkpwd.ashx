<%@ WebHandler Language="C#" Class="Du_Checkpwd" %>

using System;
using System.Web;
using System.Text;

public class Du_Checkpwd : IHttpHandler {

    string json_str = "";

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        string username_str=context.Request.Form["username"];
        string password_str=context.Request.Form["password"];
        PythonHelper ph = new PythonHelper();
        try
        {
            json_str=ph.checkpwd(username_str, password_str);
            context.Response.Write(json_str);
        }
        catch
        {
            context.Response.Write("接口调用失败，请稍后再试！");
        }

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
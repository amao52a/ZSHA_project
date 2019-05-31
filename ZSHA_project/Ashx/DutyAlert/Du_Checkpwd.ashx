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
        json_str=ph.checkpwd(username_str, password_str);
        context.Response.Write(json_str);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
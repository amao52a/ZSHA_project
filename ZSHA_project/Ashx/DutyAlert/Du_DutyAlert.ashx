<%@ WebHandler Language="C#" Class="Du_DutyAlert" %>

using System;
using System.Web;
using System.Text;

public class Du_DutyAlert : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
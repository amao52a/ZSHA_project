<%@ WebHandler Language="C#" Class="Du_Industrys" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public class Du_Industrys : IHttpHandler {
    string json_str = "";
    //默认为查询状态
    string type_str = "search";
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        type_str=context.Request.Params["type"];
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
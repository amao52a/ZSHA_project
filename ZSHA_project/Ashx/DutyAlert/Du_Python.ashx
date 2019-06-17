<%@ WebHandler Language="C#" Class="Du_Python" %>

using System;
using System.Web;
using System.Text;
using System.Threading;

public class Du_Python : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
       
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        string[] user=context.Request.Form["user"].ToString().Split(',');
        string[] pwd=context.Request.Form["pwd"].ToString().Split(',');
        for (int i = 0; i < user.Length; i++)
        {
            Thread thr = new Thread(a);
            IpAndPort aa = new IpAndPort();
            aa.user = user[i];
            aa.pwd = pwd[i];
            thr.Start((object)aa);
        }

    }
    
     private void a(object aa)
     {
         PythonHelper ph = new PythonHelper();
         IpAndPort ip = (IpAndPort)aa;
         ph.getTax(ip.user,ip.pwd,"20181001","20181031","1","0");
     }

    public bool IsReusable {
        get {
            return false;
        }
    }

    struct IpAndPort
    {
        public string user;
        public string pwd;
    }

}
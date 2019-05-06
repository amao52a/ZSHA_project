<%@ WebHandler Language="C#" Class="Du_DutyAlert" %>

using System;
using System.Web;
using System.Text;

public class Du_DutyAlert : IHttpHandler {

    string json_str = "";

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        string username_str=context.Request.Form["username"];
        string password_str=context.Request.Form["password"];
        int type_i=int.Parse(context.Request.Form["type"].ToString());
        string dutytime_str=context.Request.Form["dutytime"];
        //查询指定时间是否有数据（没有通过python获取）
        if ((type_i&1)==1)
        {
            //增值税本月
            string year_str = dutytime_str.Substring(0,4);
            string month_str=dutytime_str.Substring(5,2);
            string day_str=DateTime.DaysInMonth(int.Parse(year_str), int.Parse(month_str)).ToString();
            string sql_str = "select count(*) from BasicIndicateValue where Companys_Numbers='" + username_str + "' and FinanceYear=" + year_str + " and FinanceMonth=" + int.Parse(month_str) + "";
            int count_i = (Int32)SqlHelper.ExecuteScalar(sql_str);
            if (count_i==0)
            {
                PythonHelper ph = new PythonHelper();
                ph.getTax(username_str,password_str,year_str+month_str+"01",year_str+month_str+day_str,"1");
            }
            //增值税上月
            DateTime lastTime=DateTime.Parse(dutytime_str);
            string lastdutytime_str = lastTime.AddMonths(-1).ToString("yyyy-MM");
            year_str = lastdutytime_str.Substring(0,4);
            month_str=lastdutytime_str.Substring(5,2);
            day_str=DateTime.DaysInMonth(int.Parse(year_str), int.Parse(month_str)).ToString();
            sql_str = "select count(*) from BasicIndicateValue where Companys_Numbers='" + username_str + "' and FinanceYear=" + year_str + " and FinanceMonth=" + int.Parse(month_str) + "";
            count_i = (Int32)SqlHelper.ExecuteScalar(sql_str);
            if (count_i==0)
            {
                PythonHelper ph = new PythonHelper();
                ph.getTax(username_str,password_str,year_str+month_str+"01",year_str+month_str+day_str,"1");
            }
        }
        if ((type_i&2)==2)
        {
            //所得税本年
            string year_str = dutytime_str.Substring(0,4);
            string sql_str = "select count(*) from BasicIndicateValue where Companys_Numbers='" + username_str + "' and FinanceYear=" + year_str + " and FinanceMonth=0";
            int count_i = (Int32)SqlHelper.ExecuteScalar(sql_str);
            if (count_i==0)
            {
                PythonHelper ph = new PythonHelper();
                string rs=ph.getTax(username_str,password_str,year_str+"0101",year_str+"1231","2");
                if (rs.Equals("empty"))
                {
                    json_str += year_str+",";
                }
            }
            //所得税上年
            year_str = (int.Parse(year_str) - 1).ToString();
            sql_str = "select count(*) from BasicIndicateValue where Companys_Numbers='" + username_str + "' and FinanceYear=" + year_str + " and FinanceMonth=0";
            count_i = (Int32)SqlHelper.ExecuteScalar(sql_str);
            if (count_i==0)
            {
                PythonHelper ph = new PythonHelper();
                string rs=ph.getTax(username_str,password_str,year_str+"0101",year_str+"1231","2");
                if (rs.Equals("empty"))
                {
                    json_str += year_str+",";
                }
            }
        }
    context.Response.Write(json_str);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
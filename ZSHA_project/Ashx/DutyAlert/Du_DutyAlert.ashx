<%@ WebHandler Language="C#" Class="Du_DutyAlert" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public class Du_DutyAlert : IHttpHandler {

    string json_str = "";
    string Progress_key = null;

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        string Method = context.Request["Method"];
        Progress_key = context.Request["Progress_key"];
        if (Method == "GetProgress")
        {
            context.Response.Clear();
            context.Response.Write(this.GetProgress(context));
            context.Response.End();
        }else if (Method == "StopProgress")
        {
            context.Application[Progress_key] = null;
        }
        else
        {
            this.DoWork(context);
        }
    }

    private int GetProgress(HttpContext context)
    {
        if (context.Application[Progress_key] != null)
        {
            return (int)context.Application[Progress_key];
        }
        else
        {
            return -1;
        }
    }

    private void DoWork(HttpContext context)
    {
        context.Application[Progress_key]=10;
        string username_str=context.Request.Form["username"];
        string password_str=context.Request.Form["password"];
        string companyname_str=context.Request.Form["companyname"];
        string county_str=context.Request.Form["county"];
        string industry_str = context.Request.Form["industry"];
        string countyname_str=context.Request.Form["countyname"];
        string industryname_str =context.Request.Form["industryname"];
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
                ph.getTax(username_str,password_str,year_str+month_str+"01",year_str+month_str+day_str,"1","0");
            }
            context.Application[Progress_key]=30;
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
                ph.getTax(username_str,password_str,year_str+month_str+"01",year_str+month_str+day_str,"1","0");
            }
        }
        context.Application[Progress_key]=50;
        if ((type_i&2)==2)
        {
            //所得税本年
            string taxtype = "Ta020001,Ta020002,Ta020003";
            string year_str = dutytime_str.Substring(0,4);
            string sql_str = "select FinancialTable_Numbers from BasicIndicateValue where Companys_Numbers='" + username_str + "' and FinanceYear=" + year_str + " and FinanceMonth=0 group by FinancialTable_Numbers";
            DataTable dt= SqlHelper.ExecuteDataTable(sql_str);
            foreach (DataRow dr in dt.Rows)
            {
                taxtype=taxtype.Replace(dr[0].ToString()," ");
            }
            PythonHelper ph = new PythonHelper();
            if (taxtype.Length>8)
            {
                string rs=ph.getTax(username_str,password_str,year_str+"0101",year_str+"1231","2",taxtype);
                json_str += "[{\"year\":"+rs+"},";
            }
            else
            {
                json_str += "[{\"year\":[]},";
            }
            context.Application[Progress_key]=70;
            //所得税上年
            taxtype = "Ta020001,Ta020002,Ta020003";
            year_str = (int.Parse(year_str) - 1).ToString();
            sql_str = "select FinancialTable_Numbers from BasicIndicateValue where Companys_Numbers='" + username_str + "' and FinanceYear=" + year_str + " and FinanceMonth=0 group by FinancialTable_Numbers";
            dt= SqlHelper.ExecuteDataTable(sql_str);
            foreach (DataRow dr in dt.Rows)
            {
                taxtype=taxtype.Replace(dr[0].ToString()," ");
            }
            ph = new PythonHelper();
            if (taxtype.Length > 8)
            {
                string lrs=ph.getTax(username_str,password_str,year_str+"0101",year_str+"1231","2",taxtype);
                json_str += "{\"lastyear\":"+lrs+"},";
            }
            else
            {
                json_str += "{\"lastyear\":[]},";
            }
        }
        context.Application[Progress_key]=90;
        //添加warn表记录（先判断是否存在，不存在就新建）
        DataTable dtw=SqlHelper.ExecuteDataTable("select Numbers from Warns where Companys_Numbers='" + username_str + "' and FinanceYear=" + dutytime_str.Substring(0,4) + " and FinanceMonth=" + int.Parse(dutytime_str.Substring(5,2)) + "");
        if (dtw.Rows.Count>0)
        {
            json_str += "{\"numbers\":\""+dtw.Rows[0][0]+"\"}]";
        }
        else
        {
            //生成单号（地区行业暂时没有添加）
            Random rNum = new Random();
            string number_str = LDBasicTools.WarnsNumbers(county_str);
            string wsql_str = "insert into Warns (Numbers,Companys_Numbers,USCCs,Companys_Names,Areas_Numbers,Industrys_Numbers,FinanceYear,FinanceMonth,Areas_Names,Industrys_Names,Times) " +
                 " values (@Numbers,@Companys_Numbers,@USCCs,@Companys_Names,@Areas_Numbers,@Industrys_Numbers,@FinanceYear,@FinanceMonth,@Areas_Names,@Industrys_Names,@Times);";
            SqlParameter[] parameters ={ new SqlParameter("@Numbers", number_str),
                new SqlParameter("@Companys_Numbers", username_str),
                new SqlParameter("@USCCs", username_str),
                new SqlParameter("@Companys_Names", companyname_str),
                new SqlParameter("@Areas_Numbers", county_str),
                new SqlParameter("@Industrys_Numbers", industry_str),
                new SqlParameter("@FinanceYear", dutytime_str.Substring(0,4)),
                new SqlParameter("@FinanceMonth", int.Parse(dutytime_str.Substring(5,2))),
                new SqlParameter("@Areas_Names", countyname_str),
                new SqlParameter("@Industrys_Names", industryname_str),
                new SqlParameter("@Times", LDBasicTools.DateStrToInt(DateTime.Now.ToString()))};
            SqlHelper.ExecuteNonQuery(wsql_str,parameters);
            json_str += "{\"numbers\":\""+number_str+"\"}]";
        }
        context.Application[Progress_key] = null;
        context.Response.Write(json_str);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
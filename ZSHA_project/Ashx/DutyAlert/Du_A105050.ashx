﻿<%@ WebHandler Language="C#" Class="Du_A105050" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public class Du_A105050 : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        string year_str = context.Request.Form["year"].ToString().Substring(0,4);
        string companysnumbers_str=context.Request.Form["companysnumbers"];
        //判断有没有数据
        int count_i=(Int32)SqlHelper.ExecuteScalar("select count(*) from BasicIndicateValue where FinancialTable_Numbers='Ta020002' and FinanceYear="+year_str+" and Companys_Numbers='"+companysnumbers_str+"';");
        if (count_i==0)
        {
            //先获取需要的基础指标 Ta020002
            DataTable dt= SqlHelper.ExecuteDataTable("select * from BasicIndicate where FinancialTable_Numbers='Ta020002'");
            foreach(DataRow dr in dt.Rows)
            {
                string code_str=dr["CodeStr"].ToString().ToLower();
                string valuess_str=context.Request.Form[code_str];
                //保存数据
                string sql_str = "insert into BasicIndicateValue (BasicIndicate_Numbers,BasicIndicate_Names,Companys_Numbers,FinanceYear,FinanceMonth,Valuess,FinancialTable_Numbers) " +
                    " values (@BasicIndicate_Numbers,@BasicIndicate_Names,@Companys_Numbers,@FinanceYear,@FinanceMonth,@Valuess,@FinancialTable_Numbers);";
                SqlParameter[] parameters ={ new SqlParameter("@BasicIndicate_Numbers", dr["Numbers"]),
                    new SqlParameter("@BasicIndicate_Names", dr["Names"]),
                    new SqlParameter("@Companys_Numbers", companysnumbers_str),
                    new SqlParameter("@FinanceYear", year_str),
                    new SqlParameter("@FinanceMonth", "0"),
                    new SqlParameter("@Valuess", valuess_str),
                    new SqlParameter("@FinancialTable_Numbers", "Ta020002")};
                SqlHelper.ExecuteNonQuery(sql_str,parameters);
            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
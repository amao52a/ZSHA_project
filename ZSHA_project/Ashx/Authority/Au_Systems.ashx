<%@ WebHandler Language="C#" Class="Au_Systems" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public class Au_Systems : IHttpHandler {
    string json_str = "";
    //默认为查询状态
    string type_str = "search";
    //默认分页
    int page_i = 1;
    int rows_i = 20;

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        type_str=context.Request.Params["type"];
        switch (type_str)
        {
            case "search":
                Systemsearch(context);
                break;
            case "save":
                Systemsave(context);
                break;
            case "remove":
                Systemremove(context);
                break;
        }
        context.Response.Write(json_str);
    }

    //查询
    public void Systemsearch(HttpContext context)
    {
        if (null!=context.Request.Form["page"]){
            page_i=int.Parse(context.Request.Form["page"]);
        }
        if (null!=context.Request.Form["rows"]){
            rows_i=int.Parse(context.Request.Form["rows"]);
        }
        string SystemName_str=context.Request.Form["name"];
        StringBuilder strwhere_sb = new StringBuilder();
        StringBuilder strcount_sb = new StringBuilder();
        strwhere_sb.Append("select * from Au_Systems where 1=1");
        strcount_sb.Append("select count(*) from Au_Systems where 1=1");
        if (!string.IsNullOrEmpty(SystemName_str)){
            strwhere_sb.AppendFormat(" and SystemName like '%{0}%'" , SystemName_str);
            strcount_sb.AppendFormat(" and SystemName like '%{0}%'" , SystemName_str);
        }
        strwhere_sb.Append(" order by Sorts offset "+(page_i-1)*rows_i+" rows fetch next "+rows_i+" rows only ");
        DataTable dt=SqlHelper.ExecuteDataTable(strwhere_sb.ToString());
        int total_i = (Int32)SqlHelper.ExecuteScalar(strcount_sb.ToString());
        json_str=ToJson.DataTable2Json(dt,total_i);
    }

    //保存
    public void Systemsave(HttpContext context)
    {
        string SystemId_str = context.Request.Form["SystemId"];
        string SystemName_str =context.Request.Form["SystemName"];
        string Links_str =context.Request.Form["Links"];
        string Remarks_str = context.Request.Form["Remarks"] == null?"": context.Request.Form["Remarks"];
        int Sorts_i=int.Parse(context.Request.Form["Sorts"]== ""?"0": context.Request.Form["Sorts"]);
        int count_i = 0;
        //判断新增还是编辑
        if (string.IsNullOrEmpty(SystemId_str)) {
            string insertsql = "insert into Au_Systems (SystemName,Links,Remarks,Sorts) values (@SystemName,@Links,@Remarks,@Sorts);";
            SqlParameter[] parameters ={ new SqlParameter("@SystemName", SystemName_str),
                        new SqlParameter("@Links", Links_str),
                        new SqlParameter("@Remarks", Remarks_str),
                        new SqlParameter("@Sorts", Sorts_i)};
            count_i=SqlHelper.ExecuteNonQuery(insertsql,parameters);
        }
        else
        {
            string updatesql = "Update Au_Systems Set SystemName=@SystemName , Links=@Links ,Remarks=@Remarks , Sorts=@Sorts  Where ID=@id;";
            SqlParameter[] parameters ={new SqlParameter("@id", SystemId_str),
                        new SqlParameter("@SystemName", SystemName_str),
                        new SqlParameter("@Links", Links_str),
                        new SqlParameter("@Remarks", Remarks_str),
                        new SqlParameter("@Sorts", Sorts_i)};
            count_i=SqlHelper.ExecuteNonQuery(updatesql,parameters);
        }
        if (count_i>0)
        {
            json_str = "保存成功!";
        }
        else
        {
            json_str = "保存出错，请联系管理员!";
        }
    }

    //删除
    public void Systemremove(HttpContext context)
    {
        string SystemId_str = context.Request.Form["SystemId"];
        string deletesql_str = "delete Au_Systems Where ID="+SystemId_str+";";
        int count_i=SqlHelper.ExecuteNonQuery(deletesql_str);
        if (count_i>0)
        {
            json_str = "删除成功!";
        }
        else
        {
            json_str = "删除出错，请联系管理员!";
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
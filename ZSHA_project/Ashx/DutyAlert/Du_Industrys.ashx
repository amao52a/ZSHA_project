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
    //默认分页
    int page_i = 1;
    int rows_i = 20;

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        type_str = context.Request.Params["type"];
        switch (type_str)
        {
            case "search":
                Industryssearch(context);
                break;
            case "save":
                Industryssave(context);
                break;
            case "remove":
                Industrysremove(context);
                break;
            case "getIndustrys":
                getIndustrys(context);
                break;
        }
        context.Response.Write(json_str);
    }

    public void Industryssearch(HttpContext context)
    {
        if (null!=context.Request.Form["page"]){
            page_i=int.Parse(context.Request.Form["page"]);
        }
        if (null!=context.Request.Form["rows"]){
            rows_i=int.Parse(context.Request.Form["rows"]);
        }
        string Names_str=context.Request.Form["name"];
        string AreasNumbers_str = context.Request.Form["a_number"];
        StringBuilder strwhere_sb = new StringBuilder();
        StringBuilder strcount_sb = new StringBuilder();
        strwhere_sb.Append("select * from Industrys where 1=1");
        strcount_sb.Append("select count(*) from Industrys where 1=1");
        if (!string.IsNullOrEmpty(AreasNumbers_str)){
            strwhere_sb.AppendFormat(" and Areas_Numbers = '{0}'" , AreasNumbers_str);
            strcount_sb.AppendFormat(" and Areas_Numbers = '{0}'" , AreasNumbers_str);
        }
        if (!string.IsNullOrEmpty(Names_str)){
            strwhere_sb.AppendFormat(" and Names like '%{0}%'" , Names_str);
            strcount_sb.AppendFormat(" and Names like '%{0}%'" , Names_str);
        }
        strwhere_sb.Append("order by id offset "+(page_i-1)*rows_i+" rows fetch next "+rows_i+" rows only ");
        DataTable dt=SqlHelper.ExecuteDataTable(strwhere_sb.ToString());
        int total_i = (Int32)SqlHelper.ExecuteScalar(strcount_sb.ToString());
        json_str=ToJson.DataTable2Json(dt,total_i);
    }

    public void Industryssave(HttpContext context)
    {
        string id_str =context.Request.Form["id"];
        string Areas_Numbers_str=context.Request.Form["Areas_Numbers"];
        string Names_str = context.Request.Form["Names"];
        string Numbers_str=context.Request.Form["Numbers"];
        int count_i = 0;
        //判断新增还是编辑
        if (string.IsNullOrEmpty(id_str)) {
            string sql_str = "insert into Industrys (Areas_Numbers,Names,Numbers) values (@Areas_Numbers,@Names,@Numbers);";
            SqlParameter[] parameters ={ new SqlParameter("@Areas_Numbers", Areas_Numbers_str),
                new SqlParameter("@Names", Names_str),
                new SqlParameter("@Numbers", Numbers_str)};
            count_i=SqlHelper.ExecuteNonQuery(sql_str,parameters);
        }
        else
        {
            string sql_str = "Update Industrys Set Areas_Numbers=@Areas_Numbers , Names=@Names,Numbers=@Numbers Where ID=@Id;";
            SqlParameter[] parameters ={ new SqlParameter("@Id", id_str),
                new SqlParameter("@Areas_Numbers", Areas_Numbers_str),
                new SqlParameter("@Names", Names_str),
                new SqlParameter("@Numbers", Numbers_str)};
            count_i=SqlHelper.ExecuteNonQuery(sql_str,parameters);
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

    public void Industrysremove(HttpContext context)
    {
        string id_str = context.Request.Form["id"];
        string sql_str = "delete Industrys Where ID="+id_str+";";
        int count_i=SqlHelper.ExecuteNonQuery(sql_str);
        if (count_i>0)
        {
            json_str = "删除成功!";
        }
        else
        {
            json_str = "删除出错，请联系管理员!";
        }
    }


    //根据区县查行业
    public void getIndustrys(HttpContext context)
    {
        string id_str = context.Request.Form["IndustrysId"];
        string sql_str = "select * from Industrys Where Areas_Numbers="+id_str+";";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        json_str = "<option value=''>---请选择---</option>";
        foreach (DataRow dr in dt.Rows)
        {
            json_str += "<option value=\'"+dr["Numbers"]+"\'>"+dr["Names"]+"</option>";
        }
    }
        

    public bool IsReusable {
        get {
            return false;
        }
    }

}
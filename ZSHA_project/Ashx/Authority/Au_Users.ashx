<%@ WebHandler Language="C#" Class="Au_Users" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public class Au_Users : IHttpHandler {

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
                Usersearch(context);
                break;
            case "save":
                Usersave(context);
                break;
            case "remove":
                Userremove(context);
                break;
            case "check":
                Usercheck(context);
                break;
            case "active":
                Useractive(context);
                break;
            case "tree":
                Usertree(context);
                break;
        }
        context.Response.Write(json_str);
    }

    //查询方法
    public void Usersearch(HttpContext context) {
        if (null!=context.Request.Form["page"]){
            page_i=int.Parse(context.Request.Form["page"]);
        }
        if (null!=context.Request.Form["rows"]){
            rows_i=int.Parse(context.Request.Form["rows"]);
        }
        string UserName_str=context.Request.Form["name"];
        int FId_i = int.Parse(context.Request.Form["id"]);
        StringBuilder strwhere_sb = new StringBuilder();
        StringBuilder strcount_sb = new StringBuilder();
        strwhere_sb.Append("select au.id,au.UserName,au.PassWord,au.Unit_Id,au.Names,au.Activate,au.Sorts,au.Level,au.F_id,aus.UnitName from Au_Users au left join Au_Units aus on au.Unit_Id=aus.id where 1=1");
        strcount_sb.Append("select count(*) from Au_Users where 1=1");
        if (FId_i!=0){
            strwhere_sb.AppendFormat(" and au.F_id = {0}" , FId_i);
            strcount_sb.AppendFormat(" and F_id = {0}" , FId_i);
        }
        if (!string.IsNullOrEmpty(UserName_str)){
            strwhere_sb.AppendFormat(" and UserName like '%{0}%'" , UserName_str);
            strcount_sb.AppendFormat(" and UserName like '%{0}%'" , UserName_str);
        }
        strwhere_sb.Append(" order by Sorts offset "+(page_i-1)*rows_i+" rows fetch next "+rows_i+" rows only ");
        DataTable dt=SqlHelper.ExecuteDataTable(strwhere_sb.ToString());
        int total_i = (Int32)SqlHelper.ExecuteScalar(strcount_sb.ToString());
        json_str=ToJson.DataTable2Json(dt,total_i);
    }

    //保存方法
    public void Usersave(HttpContext context) {
        string userid_str = context.Request.Form["userid"];
        string username_str =context.Request.Form["username"];
        string password_str =context.Request.Form["pwd"];
        string name_str =context.Request.Form["Names"];
        string Level_str =context.Request.Form["Level"];
        string Fid_str =context.Request.Form["Fid"];
        int unit_i=int.Parse(context.Request.Form["Unit"]);
        int sorts_i=int.Parse(context.Request.Form["sorts"]==""?"0":context.Request.Form["sorts"]);
        int count_i = 0;
        //判断新增还是编辑
        if (string.IsNullOrEmpty(userid_str)) {
            string insertsql = "insert into Au_Users (UserName,PassWord,Names,Sorts,Unit_Id,Level,F_id) values (@UserName,@PassWord,@Names,@Sorts,@Unit_Id,@Level,@F_id);";
            SqlParameter[] parameters ={ new SqlParameter("@UserName", username_str),
                        new SqlParameter("@PassWord", password_str),
                        new SqlParameter("@Names", name_str),
                        new SqlParameter("@Sorts", sorts_i),
                        new SqlParameter("@Unit_Id", unit_i),
                        new SqlParameter("@Level", Level_str),
                        new SqlParameter("@F_id", Fid_str)};
            count_i=SqlHelper.ExecuteNonQuery(insertsql,parameters);
        }
        else
        {
            string updatesql = "Update Au_Users Set UserName=@UserName , PassWord=@PassWord ,Names=@Names , Sorts=@Sorts ,Unit_Id=@Unit_Id , Level=@Level , F_id=@F_id  Where ID=@id;";
            SqlParameter[] parameters ={new SqlParameter("@id", userid_str),
                        new SqlParameter("@UserName", username_str),
                        new SqlParameter("@PassWord", password_str),
                        new SqlParameter("@Names", name_str),
                        new SqlParameter("@Sorts", sorts_i),
                        new SqlParameter("@Unit_Id", unit_i),
                        new SqlParameter("@Level", Level_str),
                        new SqlParameter("@F_id", Fid_str)
                };
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

    //删除方法
    public void Userremove(HttpContext context) {
        string userid_str = context.Request.Form["userid"];
        string deletesql_str = "delete Au_Users Where ID="+userid_str+";";
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


    //激活用户
    public void Useractive(HttpContext context) {
        string userid_str = context.Request.Form["userid"];
        string sql_str = "Update Au_Users Set Activate=@Activate Where ID=@id;";
        SqlParameter[] parameters ={new SqlParameter("@id", userid_str),
                    new SqlParameter("@Activate",1)};
        int count_i=SqlHelper.ExecuteNonQuery(sql_str,parameters);
        if (count_i>0)
        {
            json_str = "激活成功!";
        }
        else
        {
            json_str = "激活出错，请联系管理员!";
        }
    }

    //验证用户是否存在
    public void Usercheck(HttpContext context) {
        string UserName_str = context.Request.Form["username"];
        string checksql_str = "select count(*) from  Au_Users Where UserName = '"+UserName_str+"';";
        int count_i=(Int32)SqlHelper.ExecuteScalar(checksql_str);
        if (count_i>0)
        {
            json_str = "false";
        }
        else
        {
            json_str = "true";
        }
    }

    //查询树
    public void Usertree(HttpContext context)
    {
        string father_str = context.Request.Params["father"];
        string sql_str = "select * from Au_Users order by Sorts";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        //拼装JSON
        StringBuilder sb = new StringBuilder();
        sb.Append("[{\"id\":\"0\",\"text\":\"用户栏\",\"state\":\"open\",\"attributes\":\"0\",\"children\":");

        ToJsonTree tojosn = new ToJsonTree();
        sb.Append(tojosn.GetTreeJsonByTable(dt, "id","F_id",father_str,"Names","UserName","Sorts"));
        sb.Append("}]");
        json_str = sb.ToString();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
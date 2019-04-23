<%@ WebHandler Language="C#" Class="Au_RoleUsers" %>

using System;
using System.Web;
using System.Data;
using System.Text;
public class Au_RoleUsers : IHttpHandler {

    string json_str = "";
    string type_str = "";

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        type_str=context.Request.Params["type"];
        switch (type_str)
        {
            case "user":
                selectUser(context);
                break;
            case "saveUser":
                saveUser(context);
                break;
            case "checkUser":
                checkUser(context);
                break;
        }
        context.Response.Write(json_str);
    }

    //查询用户树
    public void selectUser(HttpContext context)
    {
        string sql_str = "select * from Au_Users ";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        //拼装JSON
        StringBuilder sb = new StringBuilder();
        sb.Append("[{\"id\":\"0\",\"text\":\"选择用户\",\"state\":\"open\",\"children\":[");
        foreach (DataRow row in dt.Rows)
        {
            sb.Append("{\"id\":\""+row["id"]+"\",\"text\":\""+row["Names"]+"\",\"state\":\"open\"},");
        }
        sb.Remove(sb.Length - 1, 1);
        sb.Append("]}]");
        json_str = sb.ToString();
    }

    //查询用户
    public void checkUser(HttpContext context)
    {
        string RoleId_str = context.Request.Params["RoleId"];
        StringBuilder sb = new StringBuilder();
        DataTable dt=SqlHelper.ExecuteDataTable("select User_Id from Au_RoleUsers where Role_Id="+RoleId_str+"");
        foreach(DataRow row in dt.Rows)
        {
            sb.Append(row["User_Id"]+",");
        }
        if (sb.Length>1)
        {
            sb.Remove(sb.Length - 1, 1);
        }
        json_str =sb.ToString();
    }

    //保存用户
    public void saveUser(HttpContext context)
    {
        string RoleId_str = context.Request.Params["roleid"];
        string[] UserIds_str = context.Request.Params["userids"].ToString().Split(',');

        //先删除原先的角色用户关系
        SqlHelper.ExecuteNonQuery("delete from Au_RoleUsers where Role_Id="+RoleId_str+"");
        //构造表结构
        DataTable dt = new DataTable();
        dt.Columns.Add("id",Type.GetType("System.Int32"));
        dt.Columns.Add("Role_Id",Type.GetType("System.Int32"));
        dt.Columns.Add("User_Id",Type.GetType("System.Int32"));
        for (int i = 0; i < UserIds_str.Length-1; i++)
        {
            DataRow dr = dt.NewRow();
            dr["Role_Id"] = RoleId_str;
            dr["User_Id"] = UserIds_str[i];
            dt.Rows.Add(dr);
        }
        //批量插入
        SqlHelper.SqlBulkCopyDomo(dt,"Au_RoleUsers");
        json_str = "用户绑定成功！";
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
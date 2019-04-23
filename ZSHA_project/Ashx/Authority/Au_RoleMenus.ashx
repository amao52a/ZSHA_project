<%@ WebHandler Language="C#" Class="Au_RoleMenus" %>

using System;
using System.Web;
using System.Data;
using System.Text;
public class Au_RoleMenus : IHttpHandler {

    string json_str = "";
    string type_str = "";

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        type_str=context.Request.Params["type"];
        switch (type_str)
        {
            case "menu":
                selectMenu(context);
                break;
            case "saveMenu":
                saveMenu(context);
                break;
            case "checkMenu":
                checkMenu(context);
                break;
        }
        context.Response.Write(json_str);
    }

    //查询菜单树
    public void selectMenu(HttpContext context)
    {
        string sql_str = "select * from Au_Menus ";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        //拼装JSON
        StringBuilder sb = new StringBuilder();
        sb.Append("[{\"id\":\"0\",\"text\":\"选择系统和菜单\",\"state\":\"open\",\"attributes\":\"0\",\"children\":");
        ToJsonTree tojosn = new ToJsonTree();
        sb.Append(tojosn.GetTreeJsonByTable(dt, "id","F_id",0,"MenuName","System_Id","Sorts"));
        sb.Append("}]");
        json_str = sb.ToString();
    }

    //查询已选菜单
    public void checkMenu(HttpContext context)
    {
        string RoleId_str = context.Request.Params["RoleId"];
        StringBuilder sb = new StringBuilder();
        DataTable dt=SqlHelper.ExecuteDataTable("select Menu_Id from Au_RoleMenus where Role_Id="+RoleId_str+"");
        foreach(DataRow row in dt.Rows)
        {
            sb.Append(row["Menu_Id"]+",");
        }
        if (sb.Length>1)
        {
            sb.Remove(sb.Length - 1, 1);
        }
        json_str =sb.ToString();
    }

    //保存菜单
    public void saveMenu(HttpContext context)
    {
        string RoleId_str = context.Request.Params["roleid"];
        string[] MenuIds_str = context.Request.Params["menuids"].ToString().Split(',');
        string[] SystemIds_str = context.Request.Params["systemids"].ToString().Split(',');
        //先删除原先的角色用户关系
        SqlHelper.ExecuteNonQuery("delete from Au_RoleMenus where Role_Id="+RoleId_str+"");
        //构造表结构
        DataTable dt = new DataTable();
        dt.Columns.Add("id",Type.GetType("System.Int32"));
        dt.Columns.Add("Role_Id",Type.GetType("System.Int32"));
        dt.Columns.Add("Menu_Id",Type.GetType("System.Int32"));
        dt.Columns.Add("System_Id",Type.GetType("System.Int32"));
        for (int i = 0; i < MenuIds_str.Length-1; i++)
        {
            DataRow dr = dt.NewRow();
            dr["Role_Id"] = RoleId_str;
            dr["Menu_Id"] = MenuIds_str[i];
            dr["System_Id"] = SystemIds_str[i];
            dt.Rows.Add(dr);
        }
        //批量插入
        SqlHelper.SqlBulkCopyDomo(dt,"Au_RoleMenus");
        json_str = "系统菜单绑定成功！";
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
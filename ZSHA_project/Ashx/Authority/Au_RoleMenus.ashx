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
        //权限拼接
        StringBuilder authority = new StringBuilder();
        authority.Append("[");
        authority.Append("{\"authorityname\":\"1权限\",\"authority\":\"1\"},");
        authority.Append("{\"authorityname\":\"2权限\",\"authority\":\"2\"},");
        authority.Append("{\"authorityname\":\"4权限\",\"authority\":\"4\"},");
        authority.Append("{\"authorityname\":\"8权限\",\"authority\":\"8\"}");
        authority.Append("]");
        string sql_str = "select * from Au_Menus ";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        //拼装JSON
        StringBuilder sb = new StringBuilder();
        sb.Append("[{\"id\":\"0\",\"text\":\"选择系统和菜单\",\"state\":\"open\",\"attributes\":\"0\",\"systemid\":\"0\",\"children\":");
        ToJsonTree tojosn = new ToJsonTree();
        sb.Append(GetTreeJsonByTable(dt, "id","F_id",0,"MenuName",authority.ToString()));
        sb.Append("}]");
        json_str = sb.ToString();
    }

    StringBuilder result = new StringBuilder();
    StringBuilder sb = new StringBuilder();
    public  string GetTreeJsonByTable(DataTable tabel, string id,string rela, object pId, string text,string authority)
    {
        result.Append(sb.ToString());
        sb.Clear();
        if (tabel.Rows.Count > 0)
        {
            sb.Append("[");
            string filer = string.Format("{0}='{1}'", rela, pId);
            DataRow[] rows = tabel.Select(filer);
            if (rows.Length > 0)
            {
                foreach (DataRow row in rows)
                {
                    sb.Append("{\"id\":\"" + row[id] + "\",\"text\":\"" + row[text] + "\",\"attributes\":"+authority+",\"state\":\"open\",\"systemid\":\"" + row["System_Id"] + "\"");
                    if (tabel.Select(string.Format("{0}='{1}'", rela, row[id])).Length > 0)
                    {
                        sb.Append(",\"children\":");
                        GetTreeJsonByTable(tabel, id, rela, row[id], text ,authority);
                        result.Append(sb.ToString());
                        sb.Clear();
                    }
                    result.Append(sb.ToString());
                    sb.Clear();
                    sb.Append("},");
                }
                sb = sb.Remove(sb.Length - 1, 1);
            }
            sb.Append("]");
            result.Append(sb.ToString());
            sb.Clear();
        }
        return result.ToString();
    }

    //查询已选菜单
    public void checkMenu(HttpContext context)
    {
        string RoleId_str = context.Request.Params["RoleId"];
        StringBuilder sb = new StringBuilder();
        DataTable dt=SqlHelper.ExecuteDataTable("select Menu_Id,Authority from Au_RoleMenus where Role_Id="+RoleId_str+"");
        sb.Append("[");
        foreach(DataRow row in dt.Rows)
        {
            sb.Append("{\"menuid\":\""+row["Menu_Id"]+"\",");
            sb.Append("\"authority\":\""+row["Authority"]+"\"},");
        }
        if (sb.Length>1)
        {
            sb.Remove(sb.Length - 1, 1);
        }
        sb.Append("]");
        json_str =sb.ToString();
    }

    //保存菜单
    public void saveMenu(HttpContext context)
    {
        string RoleId_str = context.Request.Params["roleid"];
        string[] MenuIds_str = context.Request.Form["menuids"].ToString().Split(',');
        string[] SystemIds_str = context.Request.Form["systemids"].ToString().Split(',');
        string[] Authoritys_str = context.Request.Form["authoritys"].ToString().Split(',');
        //先删除原先的角色用户关系
        SqlHelper.ExecuteNonQuery("delete from Au_RoleMenus where Role_Id="+RoleId_str+"");
        //构造表结构
        DataTable dt = new DataTable();
        dt.Columns.Add("id",Type.GetType("System.Int32"));
        dt.Columns.Add("Role_Id",Type.GetType("System.Int32"));
        dt.Columns.Add("Menu_Id",Type.GetType("System.Int32"));
        dt.Columns.Add("System_Id",Type.GetType("System.Int32"));
        dt.Columns.Add("Authority",Type.GetType("System.Int32"));
        for (int i = 0; i < MenuIds_str.Length; i++)
        {
            DataRow dr = dt.NewRow();
            dr["Role_Id"] = RoleId_str;
            dr["Menu_Id"] = MenuIds_str[i];
            dr["System_Id"] = SystemIds_str[i];
            dr["Authority"] = Authoritys_str[i];
            dt.Rows.Add(dr);
        }
        //批量插入
        SqlHelper.SqlBulkCopyDomo(dt,"Au_RoleMenus");
        json_str = "系统菜单权限绑定成功！";
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
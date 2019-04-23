<%@ WebHandler Language="C#" Class="Au_Menus" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public class Au_Menus : IHttpHandler {
    string json_str = "";
    //默认为查询状态
    string type_str = "search";

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        type_str=context.Request.Params["type"];
        switch (type_str)
        {
            case "search":
                Menusearch(context);
                break;
            case "save":
                Menusave(context);
                break;
            case "remove":
                Menuremove(context);
                break;
            case "check":
                Menuacheck(context);
                break;
            case "active":
                Menuactive(context);
                break;
        }
        context.Response.Write(json_str);
    }

    //查询tree方法
    public void Menusearch(HttpContext context)
    {
        string sid_str = context.Request.Form["sid"];
        string sql_str = "select * from Au_Menus where System_Id="+sid_str+" order by Sorts";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        json_str=GetTreeJsonByTable(dt, "id","F_id", 0);
    }

    #region 根据DataTable生成EasyUI Tree Json树结构
    /// <summary>
    /// 根据DataTable生成EasyUI Tree Json树结构
    /// </summary>
    /// <param name="tabel">数据源</param>
    /// <param name="id">ID字段</param>
    /// <param name="rela">父ID字段</param>
    /// <param name="pId">父ID起始ID</param>
    StringBuilder result = new StringBuilder();
    StringBuilder sb = new StringBuilder();
    public  string GetTreeJsonByTable(DataTable tabel, string id,string rela, object pId)
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
                    sb.Append("{\"id\":\"" + row[id] + "\",\"text\":\"" + row["MenuName"] + "\",\"attributes\":\"" + row["Links"] + "\",\"state\":\"open\",\"sorts\":\""+row["Sorts"]+"\",\"icons\":\""+row["Icons"]+"\"");
                    if (tabel.Select(string.Format("{0}='{1}'", rela, row[id])).Length > 0)
                    {
                        sb.Append(",\"children\":");
                        GetTreeJsonByTable(tabel, id, rela, row[id]);
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
    #endregion 
    //保存方法
    public void Menusave(HttpContext context)
    {
        string MenuId_str =context.Request.Form["MenuId"];
        string Fid_str=context.Request.Form["Fid"];
        string MenuName_str = context.Request.Form["MenuName"];
        string SystemId_str=context.Request.Form["SystemId"];
        string Links_str =context.Request.Form["Links"]==null?"":context.Request.Form["Links"];
        string Icons_str =context.Request.Form["Icons"]==null?"":context.Request.Form["Icons"];
        int Sorts_i=int.Parse(context.Request.Form["Sorts"]==""?"0":context.Request.Form["Sorts"]);
        int count_i = 0;
        //判断新增还是编辑
        if (string.IsNullOrEmpty(MenuId_str)) {
            string sql_str = "insert into Au_Menus (MenuName,Links,F_id,Icons,Sorts,System_Id) values (@MenuName,@Links,@F_id,@Icons,@Sorts,@System_Id);";
            SqlParameter[] parameters ={ new SqlParameter("@MenuName", MenuName_str),
                new SqlParameter("@Links", Links_str),
                new SqlParameter("@F_id", Fid_str),
                new SqlParameter("@Icons", Icons_str),
                new SqlParameter("@Sorts", Sorts_i),
                new SqlParameter("@System_Id", SystemId_str)};
            count_i=SqlHelper.ExecuteNonQuery(sql_str,parameters);
        }
        else
        {
            string sql_str = "Update Au_Menus Set MenuName=@MenuName , Links=@Links,F_id=@F_id,Sorts=@Sorts,Icons=@Icons Where ID=@Id;";
            SqlParameter[] parameters ={ new SqlParameter("@Id", MenuId_str),
                new SqlParameter("@MenuName", MenuName_str),
                new SqlParameter("@Links", Links_str),
                new SqlParameter("@F_id", Fid_str),
                new SqlParameter("@Icons", Icons_str),
                new SqlParameter("@Sorts", Sorts_i)};
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

    //删除方法
    public void Menuremove(HttpContext context)
    {
        string MenuId_str = context.Request.Form["MenuId"];
        string sql_str = "delete Au_Menus Where ID="+MenuId_str+";";
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

    //检查菜单根目录
    public void Menuacheck(HttpContext context)
    {
        string SystemId_str = context.Request.Form["systemid"];
        string sql_str = "select count(*) from Au_Menus Where System_Id="+SystemId_str+";";
        int count_i=(Int32)SqlHelper.ExecuteScalar(sql_str);
        if (count_i>0)
        {
            json_str = "false";
        }
        else
        {
            json_str = "true";
        }
    }

    //新建菜单根目录
    public void Menuactive(HttpContext context)
    {
        string SystemId_str = context.Request.Form["SystemId"];
        string SystemName_str = context.Request.Form["SystemName"];
        string sql_str = "insert into Au_Menus (MenuName,Links,F_id,Icons,Sorts,System_Id) values (@MenuName,@Links,@F_id,@Icons,@Sorts,@System_Id);";
        SqlParameter[] parameters ={ new SqlParameter("@MenuName", SystemName_str),
            new SqlParameter("@Links", ""),
            new SqlParameter("@F_id", "0"),
            new SqlParameter("@Icons", ""),
            new SqlParameter("@Sorts", "0"),
            new SqlParameter("@System_Id", SystemId_str)};
        int count_i=SqlHelper.ExecuteNonQuery(sql_str,parameters);
        if (count_i>0)
        {
            json_str = "系统根目录新建成功!";
        }
        else
        {
            json_str = "新建出错，请联系管理员!";
        }
    }



    public bool IsReusable {
        get {
            return false;
        }
    }

}
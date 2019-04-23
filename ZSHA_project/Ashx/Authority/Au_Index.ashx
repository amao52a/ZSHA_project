<%@ WebHandler Language="C#" Class="Au_Index" %>

using System;
using System.Web;
using System.Text;
using System.Data;

public class Au_Index : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        string json_str = "";
        string sql_str = "select * from  Au_Menus where System_Id = 1 order by Sorts";
        DataTable dt=SqlHelper.ExecuteDataTable(sql_str);
        json_str= "{"+GetMenusByTable(dt,"id","F_id", "7")+"}";
        //查询菜单，并组合成html返回
        context.Response.Write(json_str);
    }

         //目前只支持到2级菜单
    StringBuilder result = new StringBuilder();
    StringBuilder sb = new StringBuilder();
    public  string GetMenusByTable(DataTable tabel, string id,string rela, object pId)
    {
        result.Append(sb.ToString());
        sb.Clear();
        if (tabel.Rows.Count > 0)
        {
            sb.Append("\"menus\":[");
            string filer_str = string.Format("{0}='{1}'", rela, pId);
            DataRow[] rows = tabel.Select(filer_str);
            if (rows.Length > 0)
            {
                foreach (DataRow row in rows)
                {
                    sb.Append("{\"menuid\":\"" + row[id] + "\",\"menuname\":\"" + row["MenuName"] + "\",\"url\":\"" + row["Links"] + "\"");
                    if (tabel.Select(string.Format("{0}='{1}'", rela, row[id])).Length > 0)
                    {
                        sb.Append(",");
                        GetMenusByTable(tabel, id, rela, row[id]);
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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
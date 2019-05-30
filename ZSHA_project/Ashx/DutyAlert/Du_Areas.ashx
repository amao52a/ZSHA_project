<%@ WebHandler Language="C#" Class="Du_Areas" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public class Du_Areas : IHttpHandler {
    string json_str = "";
    //默认为查询状态
    string type_str = "search";

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.GetEncoding("utf-8"); //必须加上，否则会产生乱码
        type_str=context.Request.Params["type"];
        switch (type_str)
        {
            case "search":
                Areassearch(context);
                break;
            case "save":
                Areassave(context);
                break;
            case "remove":
                Areasremove(context);
                break;
            case "getAreas":
                getAreas(context);
                break;
        }
        context.Response.Write(json_str);
    }

    //查询方法
    public void Areassearch(HttpContext context)
    {
        string fid_str = context.Request.Form["fid"].Substring(0,2);
        string sql_str = "select * from Areas where Numbers like '"+fid_str+"%'";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        json_str=GetTreeJsonByTable(dt, "id","F_Numbers", 0);
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
                    sb.Append("{\"id\":\"" + row[id] + "\",\"text\":\"" + row["Names"] + "\",\"attributes\":\"" + row["Numbers"] + "\",\"state\":\"open\"");
                    if (tabel.Select(string.Format("{0}='{1}'", rela, row["Numbers"])).Length > 0)
                    {
                        sb.Append(",\"children\":");
                        GetTreeJsonByTable(tabel, id, rela, row["Numbers"]);
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
    public void Areassave(HttpContext context)
    {
        string id_str =context.Request.Form["id"];
        string F_Numbers_str=context.Request.Form["F_Numbers"];
        string Names_str = context.Request.Form["Names"];
        string Numbers_str=context.Request.Form["Numbers"];
        int count_i = 0;
        //判断新增还是编辑
        if (string.IsNullOrEmpty(id_str)) {
            string sql_str = "insert into Areas (F_Numbers,Names,Numbers) values (@F_Numbers,@Names,@Numbers);";
            SqlParameter[] parameters ={ new SqlParameter("@F_Numbers", F_Numbers_str),
                new SqlParameter("@Names", Names_str),
                new SqlParameter("@Numbers", Numbers_str)};
            count_i=SqlHelper.ExecuteNonQuery(sql_str,parameters);
        }
        else
        {
            string sql_str = "Update Areas Set F_Numbers=@F_Numbers , Names=@Names,Numbers=@Numbers Where ID=@Id;";
            SqlParameter[] parameters ={ new SqlParameter("@Id", id_str),
                new SqlParameter("@F_Numbers", F_Numbers_str),
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

    //删除方法
    public void Areasremove(HttpContext context)
    {
        string id_str = context.Request.Form["id"];
        string sql_str = "delete Areas Where ID="+id_str+";";
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


    //查询市区县
    public void getAreas(HttpContext context)
    {
        string id_str = context.Request.Form["AreasId"];
        string sql_str = "select * from Areas Where F_Numbers="+id_str+";";
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
<%@ WebHandler Language="C#" Class="Au_Units" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public class Au_Units : IHttpHandler {
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
                Unitssearch(context);
                break;
            case "save":
                Unitssave(context);
                break;
            case "remove":
                Unitsremove(context);
                break;
            case "tree":
                Unitstree(context);
                break;
        }
        context.Response.Write(json_str);
    }

    //查询
    public void Unitssearch(HttpContext context)
    {
        if (null!=context.Request.Form["page"]){
            page_i=int.Parse(context.Request.Form["page"]);
        }
        if (null!=context.Request.Form["rows"]){
            rows_i=int.Parse(context.Request.Form["rows"]);
        }
        string UnitName_str=context.Request.Form["name"];
        int FId_i = int.Parse(context.Request.Form["id"]);
        StringBuilder strwhere_sb = new StringBuilder();
        StringBuilder strcount_sb = new StringBuilder();
        strwhere_sb.Append("select *,asu.id as subid from Au_Units au left join Au_SubUnits asu on au.C_id=asu.id where 1=1");
        strcount_sb.Append("select count(*) from Au_Units where 1=1");
        if (FId_i!=0){
            strwhere_sb.AppendFormat(" and F_id = {0}" , FId_i);
            strcount_sb.AppendFormat(" and F_id = {0}" , FId_i);
        }
        if (!string.IsNullOrEmpty(UnitName_str)){
            strwhere_sb.AppendFormat(" and UnitName like '%{0}%'" , UnitName_str);
            strcount_sb.AppendFormat(" and UnitName like '%{0}%'" , UnitName_str);
        }
        strwhere_sb.Append(" order by Sorts offset "+(page_i-1)*rows_i+" rows fetch next "+rows_i+" rows only ");
        DataTable dt=SqlHelper.ExecuteDataTable(strwhere_sb.ToString());
        int total_i = (Int32)SqlHelper.ExecuteScalar(strcount_sb.ToString());
        json_str=ToJson.DataTable2Json(dt,total_i);
    }

    //查询树
    public void Unitstree(HttpContext context)
    {
        string father_str = context.Request.Params["father"];
        string sql_str = "select * from Au_Units order by Sorts";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        //拼装JSON
        StringBuilder sb = new StringBuilder();
        sb.Append("[{\"id\":\"0\",\"text\":\"单位栏\",\"state\":\"open\",\"attributes\":\"0\",\"children\":");

        ToJsonTree tojosn = new ToJsonTree();
        sb.Append(tojosn.GetTreeJsonByTable(dt, "id","F_id",father_str,"UnitName","C_id","Sorts"));
        sb.Append("}]");
        json_str = sb.ToString();
    }

    //保存
    public void Unitssave(HttpContext context)
    {
        //主表信息
        string UnitId_str=context.Request.Form["UnitId"];
        string UnitName_str=context.Request.Form["UnitName"];
        string Fid_str=context.Request.Form["Fid"];
        int Sorts_i=int.Parse(context.Request.Form["Sorts"]==""?"0":context.Request.Form["Sorts"]);
        string Remarks_str=context.Request.Form["Remarks"]==null?"":context.Request.Form["Remarks"];
        //子表信息
        string SubUnitId_str=context.Request.Form["SubUnitId"];
        string UnitCode_str=context.Request.Form["UnitCode"];
        string UnitAddress_str=context.Request.Form["UnitAddress"];
        string MainBusiness_str=context.Request.Form["MainBusiness"]==null?"":context.Request.Form["MainBusiness"];
        string RegisteredFunds_str=context.Request.Form["RegisteredFunds"]==null?"":context.Request.Form["RegisteredFunds"];
        string Legal_str=context.Request.Form["Legal"]==null?"":context.Request.Form["Legal"];
        string Contacts_str=context.Request.Form["Contacts"]==null?"":context.Request.Form["Contacts"];
        string ContactMethod_str=context.Request.Form["ContactMethod"]==null?"":context.Request.Form["ContactMethod"];
        int count_i = 0;
        string sql_str = "";
        //判断是新增还是修改
        if (string.IsNullOrEmpty(UnitId_str))
        {
            //获取子表ID
            sql_str = "select IDENT_CURRENT('Au_SubUnits')+IDENT_INCR('Au_SubUnits')";
            int cid_i = Convert.ToInt32(SqlHelper.ExecuteScalar(sql_str));
            //先插入主表
            sql_str= "insert into Au_Units (UnitName,Remarks,Sorts,F_id,C_id) values (@UnitName,@Remarks,@Sorts,@F_id,@C_id);";
            SqlParameter[] parameters ={ new SqlParameter("@UnitName", UnitName_str),
                        new SqlParameter("@Remarks", Remarks_str),
                        new SqlParameter("@Sorts", Sorts_i),
                        new SqlParameter("@F_id", Fid_str),
                        new SqlParameter("@C_id", cid_i)};
            count_i=SqlHelper.ExecuteNonQuery(sql_str,parameters);
            //再插入子表
            sql_str= "insert into Au_SubUnits (UnitAddress,UnitCode,MainBusiness,RegisteredFunds,Legal,Contacts,ContactMethod) values (@UnitAddress,@UnitCode,@MainBusiness,@RegisteredFunds,@Legal,@Contacts,@ContactMethod);";
            SqlParameter[] Cparameters ={ new SqlParameter("@UnitAddress", UnitAddress_str),
                        new SqlParameter("@UnitCode", UnitCode_str),
                        new SqlParameter("@MainBusiness", MainBusiness_str),
                        new SqlParameter("@RegisteredFunds", RegisteredFunds_str),
                        new SqlParameter("@Legal", Legal_str),
                        new SqlParameter("@Contacts", Contacts_str),
                        new SqlParameter("@ContactMethod", ContactMethod_str)};
            count_i=SqlHelper.ExecuteNonQuery(sql_str,Cparameters);
        }
        else
        {
            //先更新主表
            sql_str= "update Au_Units set UnitName=@UnitName , Remarks=@Remarks , Sorts=@Sorts , F_id=@F_id  where id=@id;";
            SqlParameter[] parameters ={ new SqlParameter("@id", UnitId_str),
                    new SqlParameter("@UnitName", UnitName_str),
                    new SqlParameter("@Remarks", Remarks_str),
                    new SqlParameter("@Sorts", Sorts_i),
                    new SqlParameter("@F_id", Fid_str)};
            count_i=SqlHelper.ExecuteNonQuery(sql_str,parameters);
            //在更新子表
            sql_str= "update Au_SubUnits set UnitAddress=@UnitAddress , UnitCode=@UnitCode , MainBusiness=@MainBusiness , RegisteredFunds=@RegisteredFunds , Legal=@Legal , Contacts=@Contacts , ContactMethod=@ContactMethod where id=@id;";
            SqlParameter[] Cparameters ={ new SqlParameter("@id", SubUnitId_str),
                        new SqlParameter("@UnitAddress", UnitAddress_str),
                        new SqlParameter("@UnitCode", UnitCode_str),
                        new SqlParameter("@MainBusiness", MainBusiness_str),
                        new SqlParameter("@RegisteredFunds", RegisteredFunds_str),
                        new SqlParameter("@Legal", Legal_str),
                        new SqlParameter("@Contacts", Contacts_str),
                        new SqlParameter("@ContactMethod", ContactMethod_str)};
            count_i=SqlHelper.ExecuteNonQuery(sql_str,Cparameters);
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
    public void Unitsremove(HttpContext context)
    {
        string UnitId_str = context.Request.Form["unitid"];
        string SubUnitId_str = context.Request.Form["subunitid"];
        string deletesql_str = "delete Au_Units Where ID="+UnitId_str+";";
        int count_i=SqlHelper.ExecuteNonQuery(deletesql_str);
        deletesql_str = "delete Au_SubUnits Where ID="+SubUnitId_str+"";
        count_i=SqlHelper.ExecuteNonQuery(deletesql_str);
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
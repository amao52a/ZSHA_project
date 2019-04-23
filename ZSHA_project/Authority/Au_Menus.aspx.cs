using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Authority_Au_Menus : System.Web.UI.Page
{
    public string System_str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql_str = "select * from Au_Systems";
        DataTable dt=SqlHelper.ExecuteDataTable(sql_str);
        foreach (DataRow row in dt.Rows)
        {
            System_str += "<option value=\'"+row["id"]+"\'>"+row["SystemName"] +"</option>";
        }
    }
}
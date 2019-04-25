using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DutyAlert_Du_Industrys : System.Web.UI.Page
{
    public string Province_str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql_str = "select * from Areas where F_Numbers='0'";
        DataTable dt = SqlHelper.ExecuteDataTable(sql_str);
        foreach (DataRow row in dt.Rows)
        {
            Province_str += "<option value=\'" + row["Numbers"] + "\'>" + row["Names"] + "</option>";
        }
    }
}
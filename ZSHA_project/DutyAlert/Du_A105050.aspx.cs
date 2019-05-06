using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DutyAlert_Du_A105050 : System.Web.UI.Page
{
    public string year = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        year = Request.Params["year"];
        if (string.IsNullOrEmpty(year))
        {
            DateTime dt = DateTime.Now;
            year = dt.Year.ToString();
        }
        year = year + "年";
    }
}
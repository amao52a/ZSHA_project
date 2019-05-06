using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DutyAlert_Du_A104000 : System.Web.UI.Page
{
    public string year = "", companysnumbers = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        year = Request.Params["year"];
        companysnumbers = Request.Params["companysnumbers"];
        if (string.IsNullOrEmpty(year))
        {
            DateTime dt = DateTime.Now;
            year = dt.Year.ToString();
        }
        year = year + "年";
    }
}
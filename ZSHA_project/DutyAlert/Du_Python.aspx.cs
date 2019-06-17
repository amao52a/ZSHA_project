using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DutyAlert_Du_Python : System.Web.UI.Page
{
    public string py = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Dictionary<string, string> hashMap = new Dictionary<string, string>();
        hashMap.Add("913306830620335968", "033596");
        hashMap.Add("91330683687864146N", "83507818");
        hashMap.Add("913306213441336596", "sx12345678");
        hashMap.Add("91330621327903199R", "a12345678");
        hashMap.Add("200307038", "12345678");
        hashMap.Add("91330621MA29BN5DXY", "231411");
        hashMap.Add("9133060256236528X9", "1234567a");
        hashMap.Add("91330621689972255Q", "654321CD");
        hashMap.Add("91330621572929958W", "sx221863");
        hashMap.Add("913306216938709057", "sx123456");
        hashMap.Add("91330602704478846N", "a1234567");
        //遍历整个字典 
        foreach (var item in hashMap)
        {
            py += "<input id='user' name='user' type='text' class='user' value='" + item.Key+ "'/><input type='text' id='pwd' name='pwd' class='pwd' value='" + item.Value + "' style='width:1500px'/></br>";
        }
    }

}
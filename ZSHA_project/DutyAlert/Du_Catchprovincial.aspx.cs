using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ivony.Html;
using Ivony.Html.Parser;

public partial class DutyAlert_Du_Catchprovincial : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        getProvince();
    }

    //抓取省市区县数据
    public void getProvince()
    {
        string ProvinceNames_str = "";
        string ProvinceId_str = "";
        string Cityurl_str = "";
        string CityId_str = "";
        string CityNames_str = "";
        string Countyurl_str = "";
        string CountyId_str = "";
        string CountyNames_str = "";
        //获取省数据
        foreach (var P_contents in new JumonyParser().LoadDocument("http://www.stats.gov.cn/WZWSREL3Rqc2ovdGpiei90anlxaGRtaGN4aGZkbS8yMDE4L2luZGV4Lmh0bWw=?wzwschallenge=V1pXU19DT05GSVJNX1BSRUZJWF9MQUJFTDQ1Nzk1MTM=").Find(".provincetr a"))
        {
            //a标签下所有的text为省会名称，href下面为市页面数据
            ProvinceNames_str = P_contents.InnerText().ToString().Trim();
            Cityurl_str = P_contents.Attribute("href").Value();
            ProvinceId_str = "Ar"+Cityurl_str.Split('.')+"0000000000";
            //插入省数据
            SqlParameter[] parameters_p ={ new SqlParameter("@Numbers", ProvinceId_str),
                    new SqlParameter("@Names", ProvinceNames_str),
                    new SqlParameter("@F_Numbers", "0")};
            SqlHelper.ExecuteNonQuery("insert into Areas (Numbers,Names,F_Numbers) values (@Numbers,@Names,@F_Numbers)", parameters_p);
            //获取市数据
            foreach (var C_contents in new JumonyParser().LoadDocument("http://www.stats.gov.cn/tjsj/tjbz/tjyqhdmhcxhfdm/2018/" + Cityurl_str + "").Find(".citytr"))
            {
                Countyurl_str = C_contents.Find("a").First().Attribute("href").Value();
                CityId_str = "Ar" + C_contents.Find("a").First().InnerText();
                CityNames_str = C_contents.Find("a").Last().InnerText();
                //插入市数据
                SqlParameter[] parameters_c ={ new SqlParameter("@Numbers", CityId_str),
                    new SqlParameter("@Names", CityNames_str),
                    new SqlParameter("@F_Numbers", ProvinceId_str)};
                SqlHelper.ExecuteNonQuery("insert into Areas (Numbers,Names,F_Numbers) values (@Numbers,@Names,@F_Numbers)", parameters_c);
                //获取区县数据
                foreach (var Co_contents in new JumonyParser().LoadDocument("http://www.stats.gov.cn/tjsj/tjbz/tjyqhdmhcxhfdm/2018/" + Countyurl_str + "").Find(".countytr"))
                {
                    CountyId_str = "Ar" + Co_contents.Find("a").First().InnerText();
                    CountyNames_str = Co_contents.Find("a").Last().InnerText();
                    //插入区县数据
                    SqlParameter[] parameters_co ={ new SqlParameter("@Numbers", CountyId_str),
                    new SqlParameter("@Names", CountyNames_str),
                    new SqlParameter("@F_Numbers", CityId_str)};
                    SqlHelper.ExecuteNonQuery("insert into Areas (Numbers,Names,F_Numbers) values (@Numbers,@Names,@F_Numbers)", parameters_co);
                }
            }
        }
        Response.Write(CountyNames_str);
    }
}
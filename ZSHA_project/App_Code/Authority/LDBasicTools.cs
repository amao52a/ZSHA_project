using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public class LDBasicTools
{
    public LDBasicTools() {
    }


    // -------------------- 日期 转 时间戳 --------------------
    public static int DateStrToInt(string data_str) {
        DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
        DateTime dtNow = DateTime.Parse(data_str);
        TimeSpan toNow = dtNow.Subtract(dtStart);
        string timeStamp = toNow.Ticks.ToString();
        timeStamp = timeStamp.Substring(0, timeStamp.Length - 7);
        return Int32.Parse(timeStamp);
    }

    // -------------------- 获取时间戳（毫秒精度） --------------------
    public static long GetTimeToLong() {
        long currentTicks = DateTime.Now.Ticks;
        DateTime dtFrom = new DateTime(1970, 1, 1, 0, 0, 0, 0);
        long currentMillis = (currentTicks - dtFrom.Ticks) / 10000;
        return currentMillis;
    }

    // -------------------- 获取Warns识别码(查询号) --------------------
    public static string WarnsNumbers(string AreasStr) {
        string StrCode = "W" + AreasStr.Substring(0, 6) + GetTimeToLong().ToString().Substring(2, 9);
        return StrCode;
    }





}

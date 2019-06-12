using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

/// <summary>
/// PythonHelper 的摘要说明
/// </summary>
public class PythonHelper
{
    public PythonHelper()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    /// <summary>
    ///sssq_q:所属时期起
    ///sssq_z:所属时期止
    ///username：社会信用代码
    ///pwd:密码
    ///zsxm_dm：所得税和增值税类型
    /// </summary>
    /// <returns>返回python结果</returns>
    public string getTax(string username, string pwd, string sssq_q, string sssq_z,string zsxm_dm,string taxtype)
    {
        string serviceAddress = "http://127.0.0.1:8091/ZSHA_DutyAlert/";
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(serviceAddress);
        request.Method = "POST";
        //request.ReadWriteTimeout = 5000;
        //request.KeepAlive = false;
        request.ContentType = "application/x-www-form-urlencoded;charset=utf-8";
        //使用utf-8格式组装post参数
        string data = "username="+ username + "&pwd="+pwd+"&sssq_q="+ sssq_q + "&sssq_z="+ sssq_z+ "&zsxm_dm="+ zsxm_dm + "&taxtype="+ taxtype + "";
        byte[] postData =Encoding.UTF8.GetBytes(data);
        Stream reqStream = request.GetRequestStream();
        reqStream.Write(postData, 0, postData.Length);
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        string encoding = response.ContentEncoding;
        if (encoding == null || encoding.Length < 1)
        {
            encoding = "UTF-8"; //默认编码  
        }
        StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding(encoding));
        string retString = reader.ReadToEnd();
        return retString;
    }


    public string checkpwd(string username, string pwd)
    {
        string serviceAddress = "http://127.0.0.1:8091/Checkpwd/";
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(serviceAddress);
        request.Method = "POST";
        //request.ReadWriteTimeout = 5000;
        //request.KeepAlive = false;
        request.ContentType = "application/x-www-form-urlencoded;charset=utf-8";
        //使用utf-8格式组装post参数
        string data = "username=" + username + "&pwd=" + pwd + "";
        byte[] postData = Encoding.UTF8.GetBytes(data);
        Stream reqStream = request.GetRequestStream();
        reqStream.Write(postData, 0, postData.Length);
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        string encoding = response.ContentEncoding;
        if (encoding == null || encoding.Length < 1)
        {
            encoding = "UTF-8"; //默认编码  
        }
        StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding(encoding));
        string retString = reader.ReadToEnd();
        return retString;
    }
    


}
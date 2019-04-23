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

public class LDCheck
{
    public LDCheck()
    {
    }

    public static bool CheckInput(string Text)
    {
        if (Text.IndexOf("'") != -1 || Text.IndexOf("\"") != -1 || Text.IndexOf("<") != -1 || Text.IndexOf(">") != -1)
            return false;
        return true;
    }

    public static string NoHTML(string Htmlstring)
    {
        if (Htmlstring == null)
        {
            return "";
        }
        else
        {
            //ɾ���ű�
            Htmlstring = Regex.Replace(Htmlstring, @"<script[^>]*?>.*?</script>", "", RegexOptions.IgnoreCase);
            //ɾ��HTML
            Htmlstring = Regex.Replace(Htmlstring, @"<(.[^>]*)>", "", RegexOptions.IgnoreCase);
            //Htmlstring = Regex.Replace(Htmlstring, @"([\r\n])[\s]+", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"-->", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"<!--.*", "", RegexOptions.IgnoreCase);

            Htmlstring = Regex.Replace(Htmlstring, @"&(quot|#34);", "\"", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(amp|#38);", "&", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(lt|#60);", "<", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(gt|#62);", ">", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(nbsp|#160);", " ", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(iexcl|#161);", "\xa1", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(cent|#162);", "\xa2", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(pound|#163);", "\xa3", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(copy|#169);", "\xa9", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&#(\d+);", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "xp_cmdshell", "", RegexOptions.IgnoreCase);

            //ɾ�������ݿ���صĴ�
            Htmlstring = Regex.Replace(Htmlstring, "select ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "insert ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "delete from", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "count''", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "drop table", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "truncate ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "asc ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "mid ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "char ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "xp_cmdshell", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "exec master", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "net localgroup administrators", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "and ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "net user", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "or ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "net ", "", RegexOptions.IgnoreCase);
            //Htmlstring =  Regex.Replace(Htmlstring,"*", "", RegexOptions.IgnoreCase);
            //Htmlstring =  Regex.Replace(Htmlstring,"-", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "delete ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "drop ", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "script ", "", RegexOptions.IgnoreCase);

            //������ַ�
            Htmlstring = Htmlstring.Replace("'", "");
            //Htmlstring = Htmlstring.Replace("\"", "");
            Htmlstring = Htmlstring.Replace("<", "");
            Htmlstring = Htmlstring.Replace(">", "");
            Htmlstring = Htmlstring.Replace("*", "");
            //Htmlstring = Htmlstring.Replace("-", "");
            Htmlstring = Htmlstring.Replace("?", "");
            Htmlstring = Htmlstring.Replace(",", "");
            //Htmlstring = Htmlstring.Replace("/", "");
            Htmlstring = Htmlstring.Replace(";", "");
            Htmlstring = Htmlstring.Replace("*/", "");
            //Htmlstring = Htmlstring.Replace("\r\n", "");

            Htmlstring = HttpContext.Current.Server.HtmlEncode(Htmlstring).Trim();

            return Htmlstring;
        }
    }

    /*
    public static bool ExtensionIsPic(FileUpload hifile)
    {
        System.IO.FileStream fs = new System.IO.FileStream(hifile.PostedFile.FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
        System.IO.BinaryReader r = new System.IO.BinaryReader(fs);
        string fileclass = "";
        //�����λ��Ҫ�����ж�. 
        byte buffer;
        try
        {
            buffer = r.ReadByte();
            fileclass = buffer.ToString();
            buffer = r.ReadByte();
            fileclass += buffer.ToString();
        }
        catch
        {
        }
        r.Close();
        fs.Close();
        if (fileclass == "255216" || fileclass == "7173" || fileclass == "6677" || fileclass == "13780") // ˵��255216��jpg, 7173��gif, 6677��BMP, 13780��PNG, 7790��exe, 8297��rar, 208207��doc/excel, 00��mpg, 7076��flv
        {
            return true;
        }
        else return false;
    }

    public static bool ExtensionIsDocOrExcel(FileUpload hifile)
    {
        System.IO.FileStream fs = new System.IO.FileStream(hifile.PostedFile.FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
        System.IO.BinaryReader r = new System.IO.BinaryReader(fs);
        string fileclass = "";
        //�����λ��Ҫ�����ж�. 
        byte buffer;
        try
        {
            buffer = r.ReadByte();
            fileclass = buffer.ToString();
            buffer = r.ReadByte();
            fileclass += buffer.ToString();
        }
        catch
        {
        }
        r.Close();
        fs.Close();
        if (fileclass == "208207") // ˵��255216��jpg, 7173��gif, 6677��BMP, 13780��PNG, 7790��exe, 8297��rar, 208207��doc/excel, 00��mpg, 7076��flv
        {
            return true;
        }
        else return false;
    }

    public static bool ExtensionIsMpgOrFlv(FileUpload hifile)
    {
        System.IO.FileStream fs = new System.IO.FileStream(hifile.PostedFile.FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
        System.IO.BinaryReader r = new System.IO.BinaryReader(fs);
        string fileclass = "";
        //�����λ��Ҫ�����ж�. 
        byte buffer;
        try
        {
            buffer = r.ReadByte();
            fileclass = buffer.ToString();
            buffer = r.ReadByte();
            fileclass += buffer.ToString();
        }
        catch
        {
        }
        r.Close();
        fs.Close();
        if (fileclass == "00" || fileclass == "7076") // ˵��255216��jpg, 7173��gif, 6677��BMP, 13780��PNG, 7790��exe, 8297��rar, 208207��doc/excel, 00��mpg, 7076��flv
        {
            return true;
        }
        else return false;
    }

    public static bool FileIsPic(FileUpload hifile)
    {
        string FileType = hifile.PostedFile.ContentType;
        int idx = hifile.PostedFile.FileName.ToString().LastIndexOf(".");
        string suffix = hifile.PostedFile.FileName.ToString().Substring(idx);
        if (suffix.ToLower() == ".jpg" | suffix.ToLower() == ".jpeg" | suffix.ToLower() == ".gif" | suffix.ToLower() == ".png")
        {
            if (FileType == "image/jpg" | FileType == "image/jpeg" | FileType == "image/gif" | FileType == "image/png")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    public static bool FileIsExcle(FileUpload hifile)
    {
        string FileType = hifile.PostedFile.ContentType;
        int idx = hifile.PostedFile.FileName.ToString().LastIndexOf(".");
        string suffix = hifile.PostedFile.FileName.ToString().Substring(idx);
        if (suffix.ToLower() == ".xls")
        {
            if (FileType == "application/msexcel" | FileType == "application/vnd.ms-excel" | FileType == "application/excel" | FileType == "application/kset")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
    */

    public static string ConnManageString()
    {
        string Conn_DataSource = ConfigurationManager.ConnectionStrings["Conn_DataSource"].ConnectionString.ToString();
        string Conn_InitialCatalog = ConfigurationManager.ConnectionStrings["Conn_InitialCatalog"].ConnectionString.ToString();
        string Conn_UserId = ConfigurationManager.ConnectionStrings["Conn_UserId"].ConnectionString.ToString();
        string Conn_Password = ConfigurationManager.ConnectionStrings["Conn_Password"].ConnectionString.ToString();
        string HtmlCodes = "";
        HtmlCodes = HtmlCodes + "Data Source = " + Conn_DataSource + "; ";
        HtmlCodes = HtmlCodes + "Initial Catalog = " + Conn_InitialCatalog + "; ";
        HtmlCodes = HtmlCodes + "User ID = " + Conn_UserId + "; ";
        HtmlCodes = HtmlCodes + "Password = " + Conn_Password+ "; ";
        HtmlCodes = HtmlCodes + "Max Pool Size = 51200; ";
        HtmlCodes = HtmlCodes + "Persist Security Info = True; ";
        return HtmlCodes;
    }

}

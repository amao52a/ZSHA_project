using IronPython.Hosting;
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
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        getPython();
    }

    public void getPython()
    {
        var pythonEngine = Python.CreateEngine();//(options);
        var pyText = Convert.ToBase64String(File.ReadAllBytes(new FileInfo(@"E:\TaxDutyAlert\Code\ZSHA_DutyAlert.py").ToString()));
        var CodeString = Encoding.UTF8.GetString(Convert.FromBase64String(pyText));
        //读取文件 方法一
        var script = pythonEngine.CreateScriptSourceFromString(CodeString);
        //读取文件 方法二
        //var script = pythonEngine.CreateScriptSourceFromFile(@"F:\Practice\net\py\PYTest1\PYTest1\Test2.py");
        var code = script.Compile();
        var scope = pythonEngine.CreateScope();
        var excuteResult = code.Execute(scope);
        //调用py方法,不带参数
        var _func = scope.GetVariable("ZSHA_DutyAlert");
        var CustomerData = _func();

        //调用py方法,带参数
        //var _func = scope.GetVariable("Test1");
        //var CustomerData = _func(1, 2);
        Response.Write(CustomerData);
    }
}
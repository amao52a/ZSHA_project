<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_DutyAlert.aspx.cs" Inherits="DutyAlert_Du_DutyAlert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="../Js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="../JS/My97DatePicker/WdatePicker.js" ></script>
<link href="../Css/DutyAlert/bootstrap.min.css" rel="stylesheet" />
<script src="../Js/jsencrypt.min.js"></script>
    <title>税务预警</title>
    <style>
        table {
            border-collapse: collapse;
            margin: auto;
        }
    </style>
</head>
<body>
    <div>
        <table>
            <tr>
                <td>企业名称：</td><td><input type="text" id="companyname" name="companyname"/></td>
            </tr>
            <tr>
                <td>社会信用代码：</td><td><input type="text" id="username" name="username"/></td>
            </tr>
            <tr>
                <td>密码：</td><td><input type="password" id="password" name="password"/></td>
            </tr>
            <tr>
                <td>预警日期：</td><td><input type="text" id="dutytime" name="dutytime" onclick="selectMonth()"/></td>
            </tr>
            <tr>
                <td>预警类型：</td><td>增值税：<input type="checkbox" id="addtax" name="addtax" value="1"/>
                                       所得税：<input type="checkbox" id="incometax" name="incometax" value="2"/></td>
            </tr>
            <tr><td colspan="2"><button onclick="getDutyAlert()">税务预警</button><div id="tax"></div></td></tr>
        </table>
    </div>
    <div id="taxtable">

    </div>
</body>
<script type="text/javascript">

    function getDutyAlert() {
        var type = 0
        $.each($('input:checkbox:checked'),function(){
            type+=parseInt($(this).val());
        });
        var publickey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDKRjqvZrVffhtgtu96a9fw413O0zXR/rTJffpFTixAFeipMKsDnUL/g4T18+0kFI40Y6u8cH4OirRbAm+za8nx6xdsWt/W7/rD2r2xIG8oWaBSJzC7IFshDAaLJ2FxGKahsvqAwTIRi65HgjTyc2YYq6L3/Ez8Nuu4piaUYfDSFQIDAQAB";
        var encrypt = new JSEncrypt();
        encrypt.setPublicKey(publickey);
        var mpwd=encrypt.encrypt($('#password').val());
        //访问进行数据查询
        $.ajax({
            url: "../Ashx/DutyAlert/Du_DutyAlert.ashx",
            data: { companyname:$('#companyname').val(),username: $('#username').val(), password:mpwd, type: type, dutytime: $('#dutytime').val() },
            contentType: 'application/x-www-form-urlencoded',
            type: 'post',
            traditional: 'true',
            beforeSend:function(){
                $("#tax").html("<span style='color:green'>查询中，请稍等...</span>");
            },
            success: function (result) {
                console.log(result)
                $("#tax").html("<span style='color:green'>查询结束</span>");
            }
        });
    }

    function selectMonth() {  
        WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false });  
    }  

</script>
</html>

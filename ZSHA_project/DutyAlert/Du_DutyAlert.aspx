<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_DutyAlert.aspx.cs" Inherits="DutyAlert_Du_DutyAlert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="../Js/jquery-3.3.1.min.js"></script>
<link href="../Css/DutyAlert/bootstrap.min.css" rel="stylesheet" />
    <title>税务预警</title>
    <style>
        table {
            border-collapse: collapse;
            margin: auto;
        }
    </style>
</head>
<body>
    <table>
        <tr>
            <td>社会信用代码：</td><td><input type="text" id="username" name="username"/></td>
        </tr>
        <tr>
            <td>密码：</td><td><input type="password" id="password" name="password"/></td>
        </tr>
        <tr>
            <td>预警日期：</td><td><input type="text" id="dutytime" name="dutytime"/></td>
        </tr>
        <tr>
            <td>预警类型：</td><td>增值税：<input type="checkbox" id="addtax" name="addtax" value="1"/>
                                   所得税：<input type="checkbox" id="incometax" name="incometax" value="2"/></td>
        </tr>
        <tr><td colspan="2"><button onclick="getDutyAlert()">税务预警</button></td></tr>
    </table>
</body>
<script type="text/javascript">

    function getDutyAlert() {
        var type = 0
        $.each($('input:checkbox:checked'),function(){
            type+=parseInt($(this).val());
        });
        alert(type)
    }
</script>
</html>

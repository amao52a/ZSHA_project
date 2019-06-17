<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_Python.aspx.cs" Inherits="DutyAlert_Du_Python" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="../Js/jquery-3.3.1.min.js"></script>
<script src="../Js/jsencrypt.min.js"></script>
    <title></title>
</head>
<body>
    <form id="searchForm" method="post">
        <%=py %>
    </form>
    <button onclick="checkpy()">测试python接口</button>
</body>
<script type="text/javascript">
    //页面初始化
    $(function () {
        $(".pwd").each(function () {
            var pwd = this.value;
            var publickey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDKRjqvZrVffhtgtu96a9fw413O0zXR/rTJffpFTixAFeipMKsDnUL/g4T18+0kFI40Y6u8cH4OirRbAm+za8nx6xdsWt/W7/rD2r2xIG8oWaBSJzC7IFshDAaLJ2FxGKahsvqAwTIRi65HgjTyc2YYq6L3/Ez8Nuu4piaUYfDSFQIDAQAB";
            var encrypt = new JSEncrypt();
            encrypt.setPublicKey(publickey);
            var mpwd = encrypt.encrypt(pwd);
            $(this).val(mpwd)
        })
    });

    function checkpy() {
        $.ajax({
            url: "../Ashx/DutyAlert/Du_python.ashx",
            type: "POST",
            data: $("#searchForm").serialize(),
            success: function (data) {
                
            }
        });
        
    }
</script>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Au_Index.aspx.cs" Inherits="Authority_Au_Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/icon.css"/>
<script type="text/javascript" src="../Js/Authority/jquery.min.js"></script>
<script type="text/javascript" src="../Js/Authority/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Js/Authority/easyui-lang-zh_CN.js"></script>
    <title>权限管理平台</title>
    <style>
        a{
            text-decoration: none;
            color:aliceblue;
        }
		#menu ul {
			list-style: none;
			padding: 0px;
			margin: 0px;
		}
		#menu ul li {
			border-bottom: 1px solid #fff;
			
		}
		#menu ul li a {
			/*先将a标签转换为块级元素，才能设置宽和内间距*/
			display: block;
			padding: 5px;
            color:blue;
			text-decoration: none;
		}
		#menu ul li a:hover {
			background-color:cadetblue;
		}
        .footer{
            text-align:center;
            color:#15428B; 
            margin:0px;
            padding:0px;
            line-height:23px;
            font-weight:bold;
        }
        .header{
            text-align:left;
            color:aliceblue; 
            margin-top:15px;
            font-weight:bold;
            font-size:20px;
        }
        
</style>
</head>
<body class="easyui-layout">
    <div data-options="region:'north'" style="height:90px;background:#3C72C4;padding:10px">
        <div class="header">权限管理系统</div>
        <span style="float:right; padding-right:20px;color:aliceblue;" >欢迎 admin <a href="#" id="editpass">修改密码</a> <a href="#" id="loginOut">安全退出</a></span>
    </div>
	<div data-options="region:'south'" style="height:25px;background: #D2E0F2; ">
        <div class="footer">by 中世华安</div>
	</div>
    <div data-options="region:'west', split:true, collapsible: true" title="菜单栏" style="width:200px;">
        <div id="menu" class="easyui-accordion" data-options="fit:true">
        </div>
    </div>
    <div data-options="region:'center',border: false" title="功能列表">
        <div id="tt"class="easyui-tabs" data-options="fit:true">
            <div title="欢迎" style="padding:10px;">
    			欢迎权限管理平台
    		</div>   
        </div>
       
    </div>
</body>
<script type="text/javascript">
    var _menus = {
    };
    var menulist = "";
    $(function () {
        //初始化菜单
        Initmenus();
    });

    //选择菜单，增加tab页
    function addtab() {
		$("a[title]").click(function(){
			var text = $(this).text();
			var href = $(this).attr("title");
			//判断当前右边是否已有相应的tab
			if($("#tt").tabs("exists", text)) {
			    $("#tt").tabs("select", text);
			} else {
				//如果没有则创建一个新的tab，否则切换到当前tag
				$("#tt").tabs("add",{
					title:text,
					closable:true,
					content:'<iframe title='+text+' src='+href+ ' frameborder="0" width="100%" height="100%" />'
				});
			}
		});
    }

    //初始化菜单
    function Initmenus() {
        $.post(
            "../Ashx/Authority/Au_Index.ashx",
            function (data, status) {
                if (status == 'success') {
                    _menus = jQuery.parseJSON(data);
                    $.each(_menus.menus, function (i, n) {
                        if (n.menus != undefined) {
                            menulist += "<div  style='padding:10px;'><ul>";
                            $.each(n.menus, function (j, o) {
                                menulist += "<li><a  href='#' title='" + o.url + "'>" + o.menuname + "</a></li> ";
                            })
                            menulist += "</ul></div>";
                            $(".easyui-accordion").accordion("add", {
                                title: n.menuname,
                                content: menulist,
                                selected: false
                             })
                        } else {
                            menulist += "<div  style='padding-left:10px;'><ul><li><a  href='#' title='" + n.url + "'>" + n.menuname + "</a></li></ul></div> ";
                            $("#menu").append(menulist);
                        }
                        menulist = "";  //每次循环完子菜单后清空，避免内容重复
                    });
                } else {
                    $.messager.alert('提示', data, 'info');
                }
                addtab();
            }
        );
    }
</script>
</html>

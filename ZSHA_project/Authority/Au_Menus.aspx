<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Au_Menus.aspx.cs" Inherits="Authority_Au_Menus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/icon.css"/>
<script type="text/javascript" src="../Js/Authority/jquery.min.js"></script>
<script type="text/javascript" src="../Js/Authority/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Js/Authority/easyui-lang-zh_CN.js"></script>
    <title>菜单管理</title>
</head>
<body class="easyui-layout">
    <div data-options="region:'west', split: true , collapsible: false, border: false , "  title="选择菜单" style="width:25%;">
        <div>
            系统选择：
            <select id="Systems" class="easyui-combobox" name="Systems" style="width:200px;" >
                <%=System_str%>
            </select>
            <a href="#" style="display:inline-block" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true"  onclick="tocheck()">新建根目录</a>
        </div>
        <div id="tree">
        </div>
    </div>
    <div data-options="region:'center',border: true" title="编辑菜单内容" >
        <form id="fm" method="post">
            <table>
                <tr>
                    <td><label>父级菜单：</label></td>
                    <td><input id="Fname" name="Fname" class="easyui-textbox" data-options="required:true,readonly:true"   />
                        <input id="Fid" name="Fid" type="hidden"/>
                    </td>
                </tr>
                <tr>
                    <td><label>菜单名称：</label></td>
                    <td><input id="MenuName" name="MenuName" class="easyui-textbox" data-options="required:true"/>
                        <input id="MenuId" name="MenuId" type="hidden"/>
                    </td>
                </tr>
                <tr>
                    <td><label>菜单链接：</label></td>
                    <td><input id="Links" name="Links"   class="easyui-textbox" /></td>
                </tr>
                <tr>
                    <td><label>菜单图标：</label></td>
                    <td><input id="Icons" name="Icons"   class="easyui-textbox" /></td>
                </tr>
                <tr>
                    <td><label>菜单排序：</label></td>
                    <td><input id="Sorts" name="Sorts" type="number"  class="easyui-textbox"  /></td>
                </tr>
            </table>
            <span style="color:red">注：新建菜单时先点击新建按钮，否则保存功能只是修改原来菜单内容！</span>
        </form>
        <div id="fm-buttons">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="toadd()">新建</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="tosave()">保存</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="toremove()">删除</a>
        </div>
    </div>
    <div id="w" class="easyui-window" title="选择上级菜单" data-options="iconCls:'icon-save',closed:true" style="width:500px;height:300px;padding:10px;">
		<div id="selecttree">
        </div>
	</div>
    
</body>
<script type="text/javascript">
    $(function () {
        //初始化菜单树
        $('#tree').tree({
            animate: true,
            checkbox: false,
            url: "../Ashx/Authority/Au_Menus.ashx?type=search",
            onBeforeLoad: function (node, param) {
                param.sid = $("#Systems").combotree("getValue");
            },
            onClick: function (node) {
                $("#MenuName").textbox("setValue", node.text);
                $("#MenuId").val(node.id);
                $("#Links").textbox("setValue", node.attributes);
                $("#Sorts").textbox("setValue", node.sorts);
                $("#Icons").textbox("setValue", node.icons);
                var parent = $('#tree').tree('getParent', node.target);
                if (parent == null) {
                    $("#Fname").textbox("setValue", "");
                    $("#Fid").val("");
                } else {
                    $("#Fname").textbox("setValue", parent.text);
                    $("#Fid").val(parent.id);
                }
            },
            onLoadSuccess: function (node, data) {
                $('#tree').show();
            }
        });
       

         //选择上级菜单
        $("input", $("#Fname").next("span")).click(function () {
            $('#w').window('open');
            $('#selecttree').tree({
                animate: true,
                checkbox: false,
                url: "../Ashx/Authority/Au_Menus.ashx?type=search",
                onBeforeLoad: function (node, param) {
                    param.sid = $("#Systems").combotree("getValue");
                },
                onClick: function (node) {
                    $("#Fname").textbox("setValue", node.text);
                    $("#Fid").val(node.id);
                    $('#w').window('close');
                },
                onLoadSuccess: function (node, data) {
                    $('#selecttree').show();
                }
            });
        });


        //选择系统事件
        $("#Systems").combobox({
            onChange: function (n, o) {
                $("#tree").tree('reload');
            }
        });

    });

  

    //新增
    function toadd () {
        //清除表单元素的值
        $("#fm").form('clear');
    }

     //保存
    function tosave () {
         $('#fm').form('submit', {
            url: "../Ashx/Authority/Au_Menus.ashx?type=save",
             onSubmit: function (param) {
                param.SystemId = $("#Systems").combotree("getValue");
                return $(this).form('validate');
            },
            success: function (data) {
                $.messager.alert('提示', data, 'info');
                $("#tree").tree('reload');
                $("#fm").form('clear');
            }
		});
    }

     //删除
    function toremove() {
        var menuid = $("#MenuId").val();
        var Fid = $("#Fid").val();
        if (menuid == "") {
            $.messager.alert('提示', "请选择要删除的菜单!", 'info');
        } else if (Fid == "") {
            $.messager.alert('提示', "根菜单无法删除!", 'info');
        } else {
            $.post(
                "../Ashx/Authority/Au_Menus.ashx?type=remove",
                { menuid:menuid },
                function (data, status) {
                    if (status == 'success') {
                        $.messager.alert('提示', data, 'info');
                        $("#tree").tree('reload');
                        $("#fm").form('clear');
                    } else {
                        $.messager.alert('提示', data, 'info');
                    }
                }
            );
        }
    }

    //先判断根菜单是否存在
    function tocheck() {
        $.post(
            "../Ashx/Authority/Au_Menus.ashx?type=check",
            { systemid:$("#Systems").combotree("getValue") },
            function (data, status) {
                if (status == 'success') {
                    if (data == "true") {
                        toactive();
                    } else {
                        $.messager.alert('提示', "系统根目录已经存在，无需新建", 'info');
                    }
                } else {
                    $.messager.alert('提示', "系统出错，联系管理员", 'info');
                }
            }
        );
    }

    //新建菜单根目录
    function toactive() {
        var SystemName = $("#Systems").combotree("getText");
        var SystemId=$("#Systems").combotree("getValue")
        $.post(
            "../Ashx/Authority/Au_Menus.ashx?type=active",
            { SystemName:SystemName,SystemId:SystemId },
            function (data, status) {
                if (status == 'success') {
                    $.messager.alert('提示', data, 'info');
                    $("#tree").tree('reload');
                    $("#fm").form('clear');
                } else {
                    $.messager.alert('提示', data, 'info');
                }
            }
        );
    }

    
</script>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_Areas.aspx.cs" Inherits="DutyAlert_Du_Areas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/icon.css"/>
<script type="text/javascript" src="../Js/Authority/jquery.min.js"></script>
<script type="text/javascript" src="../Js/Authority/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Js/Authority/easyui-lang-zh_CN.js"></script>
    <title>地区维护</title>
</head>
<body class="easyui-layout">
    <div data-options="region:'west', split: true , collapsible: false, border: false , "  title="选择省会" style="width:20%;">
        <div>
            选择省：
            <select id="Provinces" class="easyui-combobox" name="Systems" style="width:200px;" >
                <%=Province_str%>
            </select>
        </div>
        <div id="tree">
        </div>
    </div>
    <div data-options="region:'center',border: true" title="编辑地区内容" >
        <form id="fm" method="post">
            <table>
                <tr>
                    <td><label>父级地区：</label></td>
                    <td><input id="Fname" name="Fname" class="easyui-textbox" data-options="required:true,readonly:true"   />
                        <input id="F_Numbers" name="F_Numbers" type="hidden"/>
                    </td>
                </tr>
                <tr>
                    <td><label>地区名称：</label></td>
                    <td><input id="Names" name="Names" class="easyui-textbox" data-options="required:true"/>
                        <input id="id" name="id" type="hidden"/>
                    </td>
                </tr>
                <tr>
                    <td><label>行政区划：</label></td>
                    <td><input id="Numbers" name="Numbers"  class="easyui-textbox" data-options="required:true"/></td>
                </tr>
            </table>
            <span style="color:red">注：新建地区时先点击新建按钮，否则保存功能只是修改原来地区内容！</span>
        </form>
        <div id="fm-buttons">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="toadd()">新建</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="tosave()">保存</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="toremove()">删除</a>
        </div>
    </div>
    <div id="w" class="easyui-window" title="选择上级地区" data-options="iconCls:'icon-save',closed:true" style="width:500px;height:300px;padding:10px;">
		<div id="selecttree">
        </div>
	</div>
</body>
<script type="text/javascript">
    $(function () {
        //初始化地区树
        $('#tree').tree({
            animate: true,
            checkbox: false,
            url: "../Ashx/DutyAlert/Du_Areas.ashx?type=search",
            onBeforeLoad: function (node, param) {
                param.fid = $("#Provinces").combotree("getValue");
                
            },
            onClick: function (node) {
                $("#Names").textbox("setValue", node.text);
                $("#id").val(node.id);
                $("#Numbers").textbox("setValue", node.attributes);
                var parent = $('#tree').tree('getParent', node.target);
                if (parent == null) {
                    $("#Fname").textbox("setValue", "");
                    $("#F_Numbers").val("");
                } else {
                    $("#Fname").textbox("setValue", parent.text);
                    $("#F_Numbers").val(parent.attributes);
                }
            },
            onLoadSuccess: function (node, data) {
                $("#tree").tree("collapseAll");  
            }
        });

        //选择上级地区
        $("input", $("#Fname").next("span")).click(function () {
            $('#w').window('open');
            $('#selecttree').tree({
                animate: true,
                checkbox: false,
                url: "../Ashx/DutyAlert/Du_Areas.ashx?type=search",
                onBeforeLoad: function (node, param) {
                    param.fid = $("#Provinces").combotree("getValue");
                },
                onClick: function (node) {
                    $("#Fname").textbox("setValue", node.text);
                    $("#F_Numbers").val(node.attributes);
                    $('#w').window('close');
                },
                onLoadSuccess: function (node, data) {
                    $('#selecttree').tree("collapseAll");  
                }
            });
        });

        //选择省事件
        $("#Provinces").combobox({
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
            url: "../Ashx/DutyAlert/Du_Areas.ashx?type=save",
             onSubmit: function () {
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
        var id = $("#id").val();
        var F_Numbers = $("#F_Numbers").val();
        if (id == "") {
            $.messager.alert('提示', "请选择要删除的地区!", 'info');
        } else if (F_Numbers == "") {
            $.messager.alert('提示', "省份无法删除!", 'info');
        } else {
            $.post(
                "../Ashx/DutyAlert/Du_Areas.ashx?type=remove",
                { id:id },
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


 </script>
</html>

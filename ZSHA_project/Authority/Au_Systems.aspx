<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Au_Systems.aspx.cs" Inherits="Authority_Au_Systems" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/icon.css"/>
<script type="text/javascript" src="../Js/Authority/jquery.min.js"></script>
<script type="text/javascript" src="../Js/Authority/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Js/Authority/easyui-lang-zh_CN.js"></script>
    <title>系统管理</title>
</head>
<body>
    <div id="tb">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"  onclick="toadd()">新增</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"  onclick="toedit()">编辑</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"  onclick="toremove()">删除</a>
        系统名：<input type="text" id="s_name" name="s_name" />
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="tosearch('search')">查询</a>
    </div>
    <div id="tt">
    </div>
    <div id="dlg" class="easyui-dialog" title="新建系统" data-options="iconCls:'icon-save',closed:true, buttons:'#dlg-buttons'"  
        style="width:400px;height:300px;padding:10px ">
		 <form id="fm" method="post">
            <table>
               <tr>
                    <td><label>系统名称：</label></td>
                    <td><input id="SystemName" name="SystemName" class="easyui-textbox" data-options="required:true"/>
                        <input id="SystemId" name="SystemId" type="hidden"/>
                    </td>
                </tr>
                <tr>
                    <td><label>系统地址：</label></td>
                    <td><input id="Links" name="Links"  type="text" class="easyui-textbox" data-options="required:true"/></td>
                </tr>
                <tr>
                    <td><label>排序号：</label></td>
                    <td><input id="Sorts" name="Sorts" type="number" class="easyui-textbox"  /></td>
                </tr>
                 <tr>
                    <td><label>备注：</label></td>
                    <td><input id="Remarks" name="Remarks" type="text" class="easyui-textbox"  /></td>
                </tr>
            </table>
        </form>
	</div>
    <div id="dlg-buttons">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="save()">保存</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
    </div>
</body>
<script type="text/javascript">
     $(function () {
        $('#tt').datagrid({
            url: "../Ashx/Authority/Au_Systems.ashx",
            toolbar: "#tb",
            queryParams: {
                type: "search",
                name:$("#s_name").val()
            },
			fitColumns : "true",
            striped: true,
            loadMsg : '正在努力为您加载..',
			rownumbers:true,
            checkOnSelect: 'true',
            singleSelect : true,
            pagination : true,
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50 ],
            columns: [[
                { field: 'id', checkbox: true, },
                { field: 'SystemName', title: '系统名称', width: 100, align: 'center' },
                { field: 'Links', title: '系统地址', width: 100, align: 'center' },
                { field: 'Remarks', title: '备注', width: 100, align: 'center' },
                { field: 'Sorts', title: '排序号', width: 100, align: 'center' }
            ]]
		});
    });

     //监听回车
    $(document).keyup(function(event){
        if(event.keyCode ==13){
            tosearch("search");
        }
    });

    //查询
    function tosearch(type) {
        var queryParams = $('#tt').datagrid('options').queryParams;
        queryParams.name = $('#s_name').val();
        queryParams.type = type;
        $("#tt").datagrid('reload');
    }

     //新增
    function toadd() {
        //清除表单元素的值
        $("#fm").form('clear');
        $("#dlg").dialog({ title: "新建系统" });
        $("#dlg").dialog('open');
    }

    //修改
    function toedit() {
        var row = $('#tt').datagrid('getSelected');
        if (null == row) {
            $.messager.alert("提示", "请选择要编辑的行！", "info");
            return;
        }
        $("#fm").form('clear');
        $('#fm').form('load', row);
        $('#SystemId').val(row.id)
        $("#dlg").dialog({ title: "编辑系统" });
        $("#dlg").dialog('open');
    }

    //保存数据
    function save() {
        $('#fm').form('submit', {
            url: "../Ashx/Authority/Au_Systems.ashx?type=save",
			onSubmit:function(){
			    return $(this).form('validate');
            },
            success: function (data) {
                $.messager.alert('提示', data, 'info');
                $("#dlg").dialog('close');
                tosearch("search");
             }
		});
    }


    //删除
    function toremove() {
        var row = $('#tt').datagrid('getSelected');
        if (null == row) {
            $.messager.alert("提示", "请选择要删除的行！", "info");
            return;
        }
        $.messager.confirm('确认删除', '是否要删除所选记录?', function(r){
			if (r){
                $.post(
                    "../Ashx/Authority/Au_Systems.ashx?type=remove",
                    { SystemId: row.id },
                    function (data, status) {
                        if (status == 'success') {
                            $.messager.alert('提示', data, 'info');
                             tosearch("search");
                        } else {
                            $.messager.alert('提示', data, 'info');
                        }
                    }
                );
			}
		});
    }
</script>
</html>

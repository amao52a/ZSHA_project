<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Au_Roles.aspx.cs" Inherits="Authority_Au_Roles" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/icon.css"/>
<script type="text/javascript" src="../Js/Authority/jquery.min.js"></script>
<script type="text/javascript" src="../Js/Authority/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Js/Authority/easyui-lang-zh_CN.js"></script>
    <title>角色管理</title>
</head>
<body>
    <div id="tb">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"  onclick="toadd()">新增</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"  onclick="toedit()">编辑</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"  onclick="toremove()">删除</a>
        角色名：<input type="text" id="s_name" name="s_name" />
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="tosearch('search')">查询</a>
    </div>
    <div id="tt">
    </div>
    <div id="dlg" class="easyui-dialog" title="新建角色" data-options="iconCls:'icon-save',closed:true, buttons:'#dlg-buttons'"  
        style="width:400px;height:300px;padding:10px ">
		 <form id="fm" method="post">
            <table>
               <tr>
                    <td><label>角色名称：</label></td>
                    <td><input id="RoleName" name="RoleName" class="easyui-textbox" data-options="required:true"/>
                        <input id="RoleId" name="RoleId" type="hidden"/>
                    </td>
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

    <input id="RoleUserId" type="hidden"/>

     <div id="w" class="easyui-window" title="选择用户" data-options="iconCls:'icon-save',closed:true" style="width:250px;height:300px;padding:10px;">
		<div id="selectUser">
        </div>
        <div style="float:right">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveRoleUser()">确定</a>
        </div>
	 </div>

    <input id="RoleMenuId" type="hidden"/>

    <div id="m" class="easyui-window" title="选择系统和菜单权限" data-options="iconCls:'icon-save',closed:true" style="width:400px;height:500px;padding:10px;">
		<div id="selectMenu">
        </div>
        <div style="float:right">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveRoleMenu()">确定</a>
        </div>
	 </div>

</body>
<script type="text/javascript">
     $(function () {
        $('#tt').datagrid({
            url: "../Ashx/Authority/Au_Roles.ashx",
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
                { field: 'index', checkbox: true, },
                { field: 'RoleName', title: '角色名称', width: 100, align: 'center' },
                { field: 'Remarks', title: '备注', width: 100, align: 'center' },
                { field: 'Sorts', title: '排序号', width: 100, align: 'center' },
                {
                    field: 'id', title: '操作', width: 150, align: 'center',formatter: function (value,row,index) {
                        return '<a href="#" onclick="selectUsers('+value+')">选择用户</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="selectMenus('+value+')">选择菜单</a>';
                    }
                }
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
        $("#dlg").dialog({ title: "新建角色" });
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
        $('#RoleId').val(row.id)
        $("#dlg").dialog({ title: "编辑角色" });
        $("#dlg").dialog('open');
    }

    //保存数据
    function save() {
        $('#fm').form('submit', {
            url: "../Ashx/Authority/Au_Roles.ashx?type=save",
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
                    "../Ashx/Authority/Au_Roles.ashx?type=remove",
                    { RoleId: row.id },
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

     //选择用户
    function selectUsers(id) {
        $('#w').window('open');
        $('#selectUser').tree({
            animate: true,
            checkbox: true,
            cascadeCheck:false,
            url: '../Ashx/Authority/Au_RoleUsers.ashx?type=user',
            onClick: function (node) {
                if (node.checkState=="unchecked") {
                    $('#selectUser').tree("check", node.target);
                } else {
                    $('#selectUser').tree("uncheck", node.target);
                }
            },
            onLoadSuccess: function () {
                //获取之前已经选择的用户ID
                $.post("../Ashx/Authority/Au_RoleUsers.ashx?type=checkUser",
                    { RoleId: id },
                    function (data, status) {
                        if (status == 'success') {
                            if (data != "") {
                                var userid = data.split(",");
                                for (var i = 0; i < userid.length; i++) {
                                    var node=$('#selectUser').tree("find",userid[i]);
                                    $('#selectUser').tree("check",node.target);
                                }
                            }
                        } else {
                            $.messager.alert('提示', "用户获取失败，请联系管理员", 'info');
                        }
                    }
                );
                $('#RoleUserId').val(id);
            }
        });
    }

    //保存用户
    function saveRoleUser() {
        var node = $('#selectUser').tree('getChecked');
        if (node.length==0) {
            $.messager.alert("提示", "请先选择用户！", "info");
            return;
        }
        var userids = "";
        for (var i = 0; i < node.length;i++) {
            userids += node[i].id+",";
        }
        $.post(
            "../Ashx/Authority/Au_RoleUsers.ashx?type=saveUser",
            { userids: userids,roleid:$('#RoleUserId').val() },
            function (data, status) {
                if (status == 'success') {
                    $.messager.alert('提示', data, 'info');
                    $('#w').window('close');
                } else {
                    $.messager.alert('提示', data, 'info');
                }
            }
        );
    }

    //选择菜单和系统权限
    function selectMenus(id) {
        $('#m').window('open');
        $('#selectMenu').tree({
            animate: true,
            checkbox: true,
            cascadeCheck:false,
            url: '../Ashx/Authority/Au_RoleMenus.ashx?type=menu',
            onClick: function (node) {
                if (node.checkState=="unchecked") {
                    $('#selectMenu').tree("check", node.target);
                } else {
                    $('#selectMenu').tree("uncheck", node.target);
                }
            },
            onLoadSuccess: function () {
                //获取之前已经选择的菜单ID
                $.post("../Ashx/Authority/Au_RoleMenus.ashx?type=checkMenu",
                    { RoleId: id },
                    function (data, status) {
                        if (status == 'success') {
                            if (data != "") {
                                var menuid = data.split(",");
                                for (var i = 0; i < menuid.length; i++) {
                                    var node=$('#selectMenu').tree("find",menuid[i]);
                                    $('#selectMenu').tree("check",node.target);
                                }
                            }
                        } else {
                            $.messager.alert('提示', "用户获取失败，请联系管理员", 'info');
                        }
                    }
                );
                $('#RoleMenuId').val(id);
            }
        });
    }

    //保存菜单和系统权限
    function saveRoleMenu() {
        var node = $('#selectMenu').tree('getChecked',  ['checked','indeterminate']);
        if (node.length==0) {
            $.messager.alert("提示", "请先选择用户！", "info");
            return;
        }
        var menuids = "";
        var systemids = "";
        for (var i = 0; i < node.length;i++) {
            menuids += node[i].id + ",";
            systemids += node[i].attributes + ",";
        }
        $.post(
            "../Ashx/Authority/Au_RoleMenus.ashx?type=saveMenu",
            { menuids: menuids,roleid:$('#RoleMenuId').val(),systemids:systemids },
            function (data, status) {
                if (status == 'success') {
                    $.messager.alert('提示', data, 'info');
                    $('#m').window('close');
                } else {
                    $.messager.alert('提示', data, 'info');
                }
            }
        );
    }
</script>
</html>

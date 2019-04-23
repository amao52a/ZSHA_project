<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Au_Users.aspx.cs" Inherits="Authority_Au_Users" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/icon.css"/>
<script type="text/javascript" src="../Js/Authority/jquery.min.js"></script>
<script type="text/javascript" src="../Js/Authority/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Js/Authority/easyui-lang-zh_CN.js"></script>
    <title>用户管理</title>
</head>
<body class="easyui-layout"> 
    <div data-options="region:'west', split: true , collapsible: false, border: false , "  title="选择用户" style="width:20%;">
        <div id="tree">
        </div>
    </div>
    <div data-options="region:'center',border: true" title="编辑用户内容" >
        <div id="tb">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"  onclick="toadd()">新增</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"  onclick="toedit()">编辑</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"  onclick="toremove()">删除</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true"  onclick="toactive()">激活</a>
            用户名：<input type="text" id="s_name" name="s_name" /><input type="hidden" name="s_id" id="s_id" value="0"/>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="tosearch('search')">查询</a>
        </div>
        <div id="tt">
        </div>
    </div>
    <div id="dlg" class="easyui-dialog" title="新建用户" data-options="iconCls:'icon-save',closed:true, buttons:'#dlg-buttons'"  
        style="width:400px;height:350px;padding:10px ">
		 <form id="fm" method="post">
            <table>
                <tr>
                    <td><label>上级用户：</label></td>
                    <td><input id="Fname" name="Fname" class="easyui-textbox" data-options="required:true,readonly:true"   />
                        <input id="Fid" name="Fid" type="hidden" />
                    </td>
                </tr>
               <tr>
                    <td><label>用户名：</label></td>
                    <td><input id="username" name="username" class="easyui-textbox" data-options="required:true" validType="isuserexist['#userid']"/>
                        <input id="userid" name="userid" type="hidden"/>
                    </td>
                </tr>
                <tr>
                    <td><label>姓名：</label></td>
                    <td><input id="names" name="names"  type="text" class="easyui-textbox" data-options="required:true"/></td>
                </tr>
                <tr>
                    <td><label>密码：</label></td>
                    <td><input id="pwd" name="pwd"  type="password" class="easyui-textbox" data-options="required:true"/></td>
                </tr>
                <tr>
                    <td><label>确认密码：</label></td>
                    <td><input id="rpwd" name="rpwd" type="password" class="easyui-textbox" required="required"  validType="equals['#pwd']"/></td>
                </tr>
                <tr>
                    <td><label>单位：</label></td>
                    <td><input id="Unit" name="Unit"  class="easyui-combotree" required="required" style="width:99%"/>
                    </td>
                </tr>
                <tr>
                    <td><label>用户等级：</label></td>
                    <td><input id="Level" name="Level" type="number" class="easyui-textbox" />
                    </td>
                </tr>
                <tr>
                    <td><label>排序号：</label></td>
                    <td><input id="sorts" name="sorts" type="number" class="easyui-textbox"  /></td>
                </tr>
            </table>
        </form>
	</div>
    <div id="dlg-buttons">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="save()">保存</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
    </div>

    <div id="w" class="easyui-window" title="选择上级用户" data-options="iconCls:'icon-save',closed:true" style="width:500px;height:300px;padding:10px;">
		<div id="selecttree">
        </div>
	</div>

</body>
<script type="text/javascript">
    $(function () {
        $('#tt').datagrid({
            url: "../Ashx/Authority/Au_Users.ashx",
            toolbar: "#tb",
            queryParams: {
                type: "search",
                name: $("#s_name").val() ,
                id:$("#s_id").val()
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
                { field: 'UserName', title: '用户名', width: 100, align: 'center' },
                { field: 'Names', title: '姓名', width: 100, align: 'center' },
                { field: 'PassWord', title: '密码', width: 100, align: 'center' },
                { field: 'UnitName', title: '单位', width: 100, align: 'center' },
                { field: 'Activate', title: '是否激活', width: 100, align: 'center',formatter:getActivate }
            ]]
        });

        //加载用户树
         $('#tree').tree({
            animate: true,
            checkbox: false,
            url: '../Ashx/Authority/Au_Users.ashx?father=0&type=tree',
            onClick: function (node) {
                $("#s_id").val(node.id);
                tosearch("search");
            },
            onLoadSuccess: function (node, data) {
                $('#tree').show();
                 //默认选中的树节点
                var node = $('#tree').tree('find', $('#s_id').val());
                $('#tree').tree('select', node.target);
            }
        });

        //选择上级用户
        $("input", $("#Fname").next("span")).click(function () {
            $('#w').window('open');
            $('#selecttree').tree({
                animate: true,
                checkbox: false,
                url: '../Ashx/Authority/Au_Users.ashx?father=0&type=tree',
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

        //加载单位comboxtree
        $("#Unit").combotree({
               url: "../Ashx/Authority/Au_Units.ashx?father=0&type=tree",
               valueField: "id",
               textField: "text",
               editable:true,
               lines: true           
           });

    });

    //是否激活
    function getActivate(value, row, index) {
        var rs=""
        if (value == "0") {
            rs="<span style='color:red'>未激活</span>"
        } else {
            rs="<span style='color:green'>已激活</span>"
        }
        return rs;
    }

    //拓展easyui表单验证
    $.extend($.fn.validatebox.defaults.rules, {
        equals: {
		    validator: function(value,param){
			    return value == $(param[0]).val();
		    },
		    message: '两次密码不一致'
        },
        isuserexist: {
            validator: function (value,param) {
                var re = "true"; 
                var isadd = $(param[0]).val();
                //新建
                if (isadd.length==0) {
                    re = $.ajax({
                        url: "../Ashx/Authority/Au_Users.ashx?type=check",
                        data: { username: value },
                        cache: false,
                        async: false,
                        type: "POST",
                        dataType: 'json/xml/html'
                    }).responseText;
                }
                return "true" == re;
		    },
		    message: '用户名已经存在'
        }
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
        queryParams.id = $('#s_id').val();
        queryParams.type = type;
        $("#tt").datagrid('reload');
    }

    //激活
    function toactive(){
        var row = $('#tt').datagrid('getSelected');
        if (null == row) {
            $.messager.alert("提示", "请选择要激活的用户！", "info");
            return;
        }
        $.post(
            "../Ashx/Authority/Au_Users.ashx?type=active",
            { userid: row.id },
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

    //新增
    function toadd() {
        //清除表单元素的值
        $("#fm").form('clear');
        $("#username").textbox({
            readonly:false
        });
        $("#dlg").dialog({ title: "新建用户" });
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
        var node = $('#tree').tree("find", row.F_id);
        $('#fm').form('load',{
				userid: row.id,
				username: row.UserName,
				pwd: row.PassWord,
                rpwd: row.PassWord,
                names: row.Names,
                sorts: row.Sorts,
                Level: row.Level,
                Fid: row.F_Id,
                Fname: node.text,
                Unit:row.Unit_Id
			});
        $("#username").textbox({
            readonly:true
        });
        $("#dlg").dialog({ title: "编辑用户" });
        $("#dlg").dialog('open');
    }

    //保存数据
    function save() {
        $('#fm').form('submit', {
            url: "../Ashx/Authority/Au_Users.ashx?type=save",
			onSubmit:function(){
			    return $(this).form('validate');
            },
            success: function (data) {
                $.messager.alert('提示', data, 'info');
                $("#dlg").dialog('close');
                tosearch("search");
                $("#tree").tree('reload');
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
                    "../Ashx/Authority/Au_Users.ashx?type=remove",
                    { userid: row.id },
                    function (data, status) {
                        if (status == 'success') {
                            $.messager.alert('提示', data, 'info');
                            tosearch("search");
                            $("#tree").tree('reload');
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

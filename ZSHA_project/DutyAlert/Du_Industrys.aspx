<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_Industrys.aspx.cs" Inherits="DutyAlert_Du_Industrys" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/icon.css"/>
<script type="text/javascript" src="../Js/Authority/jquery.min.js"></script>
<script type="text/javascript" src="../Js/Authority/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Js/Authority/easyui-lang-zh_CN.js"></script>
    <title>行业维护</title>
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
    <div data-options="region:'center',border: true" title="编辑行业内容" >
        <div id="tb">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"  onclick="toadd()">新增</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"  onclick="toedit()">编辑</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"  onclick="toremove()">删除</a>
            行业名称：<input type="text" id="s_name" name="s_name" /><input type="hidden" name="s_id" id="s_id"  />
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="tosearch('search')">查询</a>
        </div>
        <div id="tt">

        </div>
    </div>

    <div id="dlg" class="easyui-dialog" title="新建单位" data-options="iconCls:'icon-save',closed:true, buttons:'#dlg-buttons'"  
        style="width:600px;height:300px;padding:10px ">
		 <form id="fm" method="post">
            <table>
                <tr>
                    <td><label>行业名称：</label></td>
                    <td><input id="Names" name="Names" class="easyui-textbox" data-options="required:true"   />
                        <input id="id" name="id" type="hidden" />
                    </td>
                </tr>
                <tr>
                    <td><label>行业代码：</label></td>
                    <td><input id="Numbers" name="Numbers" class="easyui-textbox" data-options="required:true"   />
                    </td>
                </tr>
                <tr>
                    <td><label>行政区划：</label></td>
                    <td><input id="Areas_Numbers" name="Areas_Numbers" class="easyui-textbox" data-options="required:true,readonly:true"   />
                    </td>
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
        //初始化地区树
        $('#tree').tree({
            animate: true,
            checkbox: false,
            url: "../Ashx/DutyAlert/Du_Areas.ashx?type=search",
            onBeforeLoad: function (node, param) {
                param.fid = $("#Provinces").combotree("getValue");                
            },
            onClick: function (node) {
                $("#s_id").val(node.attributes);
                tosearch("search");
            },
            onLoadSuccess: function (node, data) {
                $("#tree").tree("collapseAll");  
            }
        });

        //加载列表
        $('#tt').datagrid({
            url: "../Ashx/DutyAlert/Du_Industrys.ashx",
            toolbar: "#tb",
            queryParams: {
                type: "search",
                name: $("#s_name").val(),
                a_number:$("#s_id").val()
            },
			fitColumns : "true",
            striped: true,
            loadMsg : '正在努力为您加载..',
			rownumbers:true,
            checkOnSelect: 'true',
            singleSelect : true,
            pagination : true,
            pageSize : 15,
            pageList : [ 10, 15, 30, 40, 50 ],
            columns: [[
                { field: 'id', checkbox: true, },
                { field: 'Numbers', title: '行政代码', width: 100, align: 'center' },
                { field: 'Areas_Numbers', title: '行政区划', width: 100, align: 'center' },
                { field: 'Names', title: '行业名称', width: 100, align: 'center' }
            ]]
        });


         //选择省事件
        $("#Provinces").combobox({
            onChange: function (n, o) {
                $("#tree").tree('reload');
            }
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
        queryParams.a_number = $('#s_id').val();
        queryParams.type = type;
        $("#tt").datagrid('reload');
    }

    function toadd() {
        //清除表单元素的值
        $("#fm").form('clear');
        var node = $('#tree').tree("getSelected");
        $("#Areas_Numbers").textbox("setValue", node.attributes);
        $("#dlg").dialog({ title: "新建行业" });
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
        $("#dlg").dialog({ title: "编辑行业" });
        $("#dlg").dialog('open');
    }

    //保存数据
    function save() {
        $('#fm').form('submit', {
            url: "../Ashx/DutyAlert/Du_Industrys.ashx?type=save",
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
                    "../Ashx/DutyAlert/Du_Industrys.ashx?type=remove",
                    { id: row.id},
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

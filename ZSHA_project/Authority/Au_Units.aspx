<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Au_Units.aspx.cs" Inherits="Authority_Au_Units" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../Css/Authority/themes/icon.css"/>
<script type="text/javascript" src="../Js/Authority/jquery.min.js"></script>
<script type="text/javascript" src="../Js/Authority/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../Js/Authority/easyui-lang-zh_CN.js"></script>
    <title>单位管理</title>
</head>
<body class="easyui-layout">
    <div data-options="region:'west', split: true , collapsible: false, border: false , "  title="选择单位" style="width:20%;">
        <div id="tree">
        </div>
    </div>
    <div data-options="region:'center',border: true" title="编辑单位内容" >
        <div id="tb">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"  onclick="toadd()">新增</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"  onclick="toedit()">编辑</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"  onclick="toremove()">删除</a>
            单位名称：<input type="text" id="s_name" name="s_name" /><input type="hidden" name="s_id" id="s_id" value="0"/>
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
                    <td><label>上级单位：</label></td>
                    <td><input id="Fname" name="Fname" class="easyui-textbox" data-options="required:true,readonly:true"   />
                        <input id="Fid" name="Fid" type="hidden" />
                    </td>
                    <td><label>单位名称：</label></td>
                    <td><input id="UnitName" name="UnitName" class="easyui-textbox" data-options="required:true"/>
                        <input id="UnitId" name="UnitId" type="hidden"/>
                    </td>
                </tr>
                <tr>
                    <td><label>统一编码：</label></td>
                    <td><input id="UnitCode" name="UnitCode"  type="text" class="easyui-textbox" data-options="required:true"/>
                        <input id="SubUnitId" name="SubUnitId" type="hidden"/>
                    </td>
                    <td><label>单位地址：</label></td>
                    <td><input id="UnitAddress" name="UnitAddress"  type="text" class="easyui-textbox" data-options="required:true"/></td>
                </tr>
                <tr>
                    <td><label>主营业务：</label></td>
                    <td><input id="MainBusiness" name="MainBusiness"  type="text" class="easyui-textbox" /></td>
                    <td><label>注册资金(万)：</label></td>
                    <td><input id="RegisteredFunds" name="RegisteredFunds"  type="text" class="easyui-textbox"/></td>
                </tr>
                <tr>
                    <td><label>法人代表：</label></td>
                    <td><input id="Legal" name="Legal"  type="text" class="easyui-textbox" /></td>
                    <td><label>联系人：</label></td>
                    <td><input id="Contacts" name="Contacts"  type="text" class="easyui-textbox" /></td>
                </tr>
                <tr>
                    <td><label>联系方法：</label></td>
                    <td><input id="ContactMethod" name="ContactMethod"  type="text" class="easyui-textbox" /></td>
                    <td><label>排序号：</label></td>
                    <td><input id="Sorts" name="Sorts" type="number" class="easyui-textbox"  /></td>
                </tr>
                 <tr>
                    <td><label>备注：</label></td>
                    <td colspan="3"><input id="Remarks" name="Remarks"  type="text" class="easyui-textbox"  style="width:100%;"/></td>
                </tr>
            </table>
        </form>
	</div>
    <div id="dlg-buttons">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="save()">保存</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
    </div>

    <div id="w" class="easyui-window" title="选择上级单位" data-options="iconCls:'icon-save',closed:true" style="width:500px;height:300px;padding:10px;">
		<div id="selecttree">
        </div>
	</div>
    
</body>
<script type="text/javascript">
    $(function () {
        //加载列表
        $('#tt').datagrid({
            url: "../Ashx/Authority/Au_Units.ashx",
            toolbar: "#tb",
            queryParams: {
                type: "search",
                name: $("#s_name").val(),
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
                { field: 'UnitName', title: '单位名称', width: 100, align: 'center' },
                { field: 'UnitCode', title: '统一编码', width: 100, align: 'center' },
                { field: 'Legal', title: '法人代表', width: 100, align: 'center' },
                { field: 'Contacts', title: '联系人', width: 100, align: 'center' },
                { field: 'ContactMethod', title: '联系方法', width: 100, align: 'center' }
            ]]
        });

        //加载单位树
         $('#tree').tree({
            animate: true,
            checkbox: false,
            url: '../Ashx/Authority/Au_Units.ashx?father=0&type=tree',
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

        
         //选择上级单位
        $("input", $("#Fname").next("span")).click(function () {
            $('#w').window('open');
            $('#selecttree').tree({
                animate: true,
                checkbox: false,
                url: '../Ashx/Authority/Au_Units.ashx?father=0&type=tree',
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

    function toadd() {
        //清除表单元素的值
        $("#fm").form('clear');
        var node=$('#tree').tree("getSelected");
        $("#Fid").val(node.id);
        //easyui textbox赋值方法
        $("#Fname").textbox("setValue", node.text);
        $("#dlg").dialog({ title: "新建单位" });
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
        $("#UnitId").val(row.id);
        $("#SubUnitId").val(row.C_id);
        $("#Fid").val(row.F_id);
        var node = $('#tree').tree("find", row.F_id);
        //easyui textbox赋值方法
        $("#Fname").textbox("setValue", node.text);
        $("#dlg").dialog({ title: "编辑单位" });
        $("#dlg").dialog('open');
    }


    //保存数据
    function save() {
        $('#fm').form('submit', {
            url: "../Ashx/Authority/Au_Units.ashx?type=save",
			onSubmit:function(){
			    return $(this).form('validate');
            },
            success: function (data) {
                $.messager.alert('提示', data, 'info');
                $("#dlg").dialog('close');
                $("#tree").tree('reload');
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
                    "../Ashx/Authority/Au_Units.ashx?type=remove",
                    { unitid: row.id,subunitid:row.subid },
                    function (data, status) {
                        if (status == 'success') {
                            $.messager.alert('提示', data, 'info');
                            $("#tree").tree('reload');
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

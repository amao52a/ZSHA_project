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
            行业名称：<input type="text" id="s_name" name="s_name" /><input type="hidden" name="s_id" id="s_id" value="0"/>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="tosearch('search')">查询</a>
        </div>
        <div id="tt">

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
                
            },
            onLoadSuccess: function (node, data) {
                $("#tree").tree("collapseAll");  
            }
        });

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


         //选择省事件
        $("#Provinces").combobox({
            onChange: function (n, o) {
                $("#tree").tree('reload');
            }
        });

    });
</script>
</html>

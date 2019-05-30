﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_DutyAlert.aspx.cs" Inherits="DutyAlert_Du_DutyAlert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="../Js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="../JS/My97DatePicker/WdatePicker.js" ></script>
<link href="../Css/DutyAlert/bootstrap.min.css" rel="stylesheet" />
<link href="../Css/tab.css" rel="stylesheet" />
<script src="../Js/jsencrypt.min.js"></script>
<script src="../Js/tab.js"></script>
    <title>税务预警</title>
    <style>
        table {
            border-collapse: collapse;
            margin: auto;
        }
        td{
            text-align:center;
            width:125px;
        }
    </style>
</head>
<body>
    <div>
        <table>
            <tr>
                <td>企业名称：</td><td><input type="text" id="companyname" name="companyname"/></td><td>社会信用代码：</td><td><input type="text" id="username" name="username"/></td>
            </tr>
            <tr>
                <td>密码：</td><td><input type="password" id="password" name="password"/></td><td>预警日期：</td><td><input type="text" id="dutytime" name="dutytime" onclick="selectMonth()"/></td>
            </tr>
            <tr>
                <td>地区行业：</td>
                <td>
                    省<select id="province" style="width:105px" onchange="getcity()">
                        <%=Province_str %>
                     </select>
                </td>
                <td>
                    市<select id="city" style="width:105px" onchange="getcounty()"></select>
                </td>
                <td>
                    区县<select id="county" style="width:105px" onchange="getindustry()"></select>
                </td>
            </tr>
            <tr>
                <td>行业：</td>
                <td>
                    <select id="industry" style="width:105px"></select>
                </td>
                <td>预警类型：</td><td>增值税：<input type="checkbox" id="addtax" name="addtax" value="1"/>
                                       所得税：<input type="checkbox" id="incometax" name="incometax" value="2"/></td>
            </tr>
            <tr><td><button onclick="getDutyAlert()">税务预警</button></td><td colspan="3"><div id="tax"></div></td></tr>
        </table>
    </div>
    <div id="TabMain">
	<div class="c_tabNav"><div class="tabNavWrapper">
		<div class="tabTurner">
			<ul>
				<li><a id="Left" href="#" title="左移标签组" class="left"></a></li>
				<li><a id="Right" href="#" title="右移标签组" class="right"></a></li>
				<li><a id="Reset" href="#" title="复位标签组" class="default"></a></li>
				<li><a id="Close" href="#" title="全部关闭" class="close"></a></li>
			</ul>
		</div>
		<div><div class="tab"><div class="maxWidth">
			<!-- 这里存放生成的Tab-->
			<ul id="Tabs"></ul>
		</div></div></div>
	</div>
	</div>
</div>
    <!-- 这里存放生成的IFrame 只要ID='Frames'就可以，可以根据布局自己定义-->
    <div id="Frames" style="height:768px">

    </div>
</body>
<script type="text/javascript">

    function getDutyAlert() {
        var type = 0
        $.each($('input:checkbox:checked'),function(){
            type+=parseInt($(this).val());
        });
        var publickey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDKRjqvZrVffhtgtu96a9fw413O0zXR/rTJffpFTixAFeipMKsDnUL/g4T18+0kFI40Y6u8cH4OirRbAm+za8nx6xdsWt/W7/rD2r2xIG8oWaBSJzC7IFshDAaLJ2FxGKahsvqAwTIRi65HgjTyc2YYq6L3/Ez8Nuu4piaUYfDSFQIDAQAB";
        var encrypt = new JSEncrypt();
        encrypt.setPublicKey(publickey);
        var mpwd=encrypt.encrypt($('#password').val());
        //访问进行数据查询
        $.ajax({
            url: "../Ashx/DutyAlert/Du_DutyAlert.ashx",
            data: { companyname:$('#companyname').val(),username: $('#username').val(), password:mpwd, type: type, dutytime: $('#dutytime').val(),county:$("#county").val(),industry:$("#industry").val() },
            contentType: 'application/x-www-form-urlencoded',
            type: 'post',
            traditional: 'true',
            beforeSend:function(){
                $("#tax").html("<span style='color:green'>查询中，请稍等...</span>");
            },
            success: function (result) {
                rs = jQuery.parseJSON(result)
                var count=0
                //本年度的年报
                for (var i = 0; i < rs[0].year.length;i++) {
                    var y = rs[0].year[i]
                    if (y.state=="false") {
                        //打开相应的填报页面
                        addTab(i+1,y.table, y.year,$('#username').val());
                    }
                    count++;
                }
                //上年度的年报
                for (var i = 0; i < rs[1].lastyear.length;i++) {
                    var ly = rs[1].lastyear[i]
                    if (ly.state=="false") {
                        //打开相应的填报页面
                        addTab((i+1)*10,ly.table, ly.year,$('#username').val());
                    }
                    count++;
                }
                if (count > 0) {
                    $("#tax").html("<span style='color:red'>请补充完成以下数据，便于结果更加精确，</span><span style='color:green'>您的查询号为：" + rs[2].numbers + "</span>");
                } else {
                    $("#tax").html("<span style='color:green'>您的查询号为：" + rs[2].numbers + "</span>");
                } 
            }
        });
    }

    function selectMonth(){  
        WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false });  
    }  

    function addTab(id,table,year,username){
        var option = {tabID:"Tabs",frameID:"Frames",activeClass:"on",lockClass:"locked",leftID:"Left",
	    rightID:"Right",resetID:"Reset",closeID:"Close"};
        window.tab = FantasyTab.create(option);
        var url = "";
        var name = "";
        if (table == "A100000") {
            url = "Du_A100000.aspx?year=" + year + "&companysnumbers=" + username + "";
            name="中华人民共和国企业所得税年度纳税申报表（"+year+"年）"
        } else if (table == "A104000") {
            url = "Du_A104000.aspx?year=" + year + "&companysnumbers=" + username + "";
            name="期间费用明细表（"+year+"年）"
        } else if (table == "A105050") {
            url = "Du_A105050.aspx?year=" + year + "&companysnumbers=" + username + "";
            name="职工薪酬纳税调整明细表（"+year+"年）"
        }
        var table = {
            id:id,name:name,lock:false,url:url,title:name
        }
        window.tab.add(table);
    }

    //获取市
    function getcity() {
        $.ajax({
            url: "../Ashx/DutyAlert/Du_Areas.ashx?type=getAreas",
            data: { AreasId: $("#province").val() },
            contentType: 'application/x-www-form-urlencoded',
            type: 'post',
            traditional: 'true',
            success: function (result)  {
                $("#city").html(result);
            }
        });
    }

     //获取区县
    function getcounty() {
         $.ajax({
            url: "../Ashx/DutyAlert/Du_Areas.ashx?type=getAreas",
            data: { AreasId: $("#city").val() },
            contentType: 'application/x-www-form-urlencoded',
            type: 'post',
            traditional: 'true',
            success: function (result)  {
                $("#county").html(result);
            }
        });
    }

     //获取行业
    function getindustry() {
        $.ajax({
            url: "../Ashx/DutyAlert/Du_Industrys.ashx?type=getIndustrys",
            data: { IndustrysId: $("#county").val() },
            contentType: 'application/x-www-form-urlencoded',
            type: 'post',
            traditional: 'true',
            success: function (result)  {
                $("#industry").html(result);
            }
        });
    }

</script>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_A104000.aspx.cs" Inherits="DutyAlert_Du_A104000" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="../Css/DutyAlert/bootstrap.min.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/funcmenu_nssb.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/lc_sq.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/zkpub.css" rel="stylesheet" />
    <script type="text/javascript" src="../Js/jquery-3.3.1.min.js"></script>
    <title>期间费用明细表</title>
</head>
<body>
    <div id="dy_div">
	<form id="fm">
		<table width="700" align="center">
			<tbody><tr>
				<td colspan="3" width="100%" align="left">A104000</td>
			</tr>
			<tr>
				<td width="786" colspan="3" align="center"><b>期间费用明细表</b></td>
			</tr>
			<tr>
				<td width="33%" align="center">&nbsp;</td>
				<td width="33%" align="center">所属时间：<span id="rq"><%=year%></span></td>
				<td width="34%" align="right">金额单位：元（列至角分）</td>
			</tr>
		</tbody></table>
        <input id="year" name="year" type="hidden" value="<%=year %>"/>
        <input id="companysnumbers" name="companysnumbers" type="hidden" value="<%=companysnumbers %>"/>
		<table width="700" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" align="center" class="lc_table">
			<tbody><tr>
				<td rowspan="2" align="center" class="bttd" style="width: 30px">行次</td>
				<td rowspan="2" align="center" class="bttd" style="width: 190px">项目</td>
				<td height="24" align="center" class="bttd">销售费用</td>
				<td align="center" class="bttd">其中：<br>境外支付</td>
				<td align="center" class="bttd">管理费用</td>
				<td align="center" class="bttd">其中：<br>境外支付</td>
				<td align="center" class="bttd">财务费用</td>
				<td align="center" class="bttd">其中：<br>境外支付</td>
			</tr>
			<tr>
				<td align="center" class="bttd">1</td>
				<td align="center" class="bttd">2</td>
				<td align="center" class="bttd">3</td>
				<td align="center" class="bttd">4</td>
				<td align="center" class="bttd">5</td>
				<td align="center" class="bttd">6</td>
			</tr>
			<tr>
				<td align="center" class="bttd">1</td>
				<td class="bttd">一、职工薪酬</td>
				<td><input type="text" id="zgxcxsfy" name="ZGXCXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="zgxcglfy" name="ZGXCGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">2</td>
				<td class="bttd">二、劳务费</td>
				<td><input type="text" id="lwfxsfy" name="LWFXSFY" value="0"  ></td>
				<td><input type="text" id="lwfjwzf" name="LWFJWZF" value="0"  ></td>
				<td><input type="text" id="lwfglfy" name="LWFGLFY" value="0"  ></td>
				<td><input type="text" id="lwfjwzf1" name="LWFJWZF1" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">3</td>
				<td class="bttd">三、咨询顾问费</td>
				<td><input type="text" id="zxgwfxsfy" name="ZXGWFXSFY" value="0"  ></td>
				<td><input type="text" id="zxgwfjwzf" name="ZXGWFJWZF" value="0"  ></td>
				<td><input type="text" id="zxgwfglfy" name="ZXGWFGLFY" value="0"  ></td>
				<td><input type="text" id="zxgwfjwzf1" name="ZXGWFJWZF1" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">4</td>
				<td class="bttd">四、业务招待费</td>
				<td><input type="text" id="ywzdfxsfy" name="YWZDFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="ywzdfglfy" name="YWZDFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">5</td>
				<td class="bttd">五、广告费和业务宣传费</td>
				<td><input type="text" id="ggxcfxsfy" name="GGXCFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="ggxcfglfy" name="GGXCFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">6</td>
				<td class="bttd">六、佣金和手续费</td>
				<td><input type="text" id="yjsxfxsfy" name="YJSXFXSFY" value="0"  ></td>
				<td><input type="text" id="yjsxfjwzf" name="YJSXFJWZF" value="0"  ></td>
				<td><input type="text" id="yjsxfglfy" name="YJSXFGLFY" value="0"  ></td>
				<td><input type="text" id="yjsxfjwzf1" name="YJSXFJWZF1" value="0"  ></td>
				<td><input type="text" id="yjsxfcwfy" name="YJSXFCWFY" value="0"  ></td>
				<td><input type="text" id="yjsxfjwzf2" name="YJSXFJWZF2" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">7</td>
				<td class="bttd">七、资产折旧摊销费</td>
				<td><input type="text" id="zczjtxfxsfy" name="ZCZJTXFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="zczjtxfglfy" name="ZCZJTXFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">8</td>
				<td class="bttd">八、财产损耗、盘亏及毁损损失</td>
				<td><input type="text" id="ccshpkxsfy" name="CCSHPKXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="ccshpkglfy" name="CCSHPKGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">9</td>
				<td class="bttd">九、办公费</td>
				<td><input type="text" id="bgfxsfy" name="BGFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="bgfglfy" name="BGFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">10</td>
				<td class="bttd">十、董事会费</td>
				<td><input type="text" id="dshfxsfy_10" name="DSHFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="dshfglfy_10" name="DSHFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">11</td>
				<td class="bttd">十一、租赁费</td>
				<td><input type="text" id="zlfxsfy" name="ZLFXSFY" value="0"  ></td>
				<td><input type="text" id="zlfjwzf" name="ZLFJWZF" value="0"  ></td>
				<td><input type="text" id="zlfglfy" name="ZLFGLFY" value="0"  ></td>
				<td><input type="text" id="zlfjwzf1" name="ZLFJWZF1" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">12</td>
				<td class="bttd">十二、诉讼费</td>
				<td><input type="text" id="ssfxsfy" name="SSFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="ssfglfy" name="SSFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">13</td>
				<td class="bttd">十三、差旅费</td>
				<td><input type="text" id="clfxsfy" name="CLFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="clfglfy" name="CLFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">14</td>
				<td class="bttd">十四、保险费</td>
				<td><input type="text" id="bxfxsfy" name="BXFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="bxfglfy" name="BXFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">15</td>
				<td class="bttd">十五、运输、仓储费</td>
				<td><input type="text" id="ysccfxsfy" name="YSCCFXSFY" value="0"  ></td>
				<td><input type="text" id="ysccfjwzf" name="YSCCFJWZF" value="0"  ></td>
				<td><input type="text" id="ysccfglfy" name="YSCCFGLFY" value="0"  ></td>
				<td><input type="text" id="ysccfjwzf1" name="YSCCFJWZF1" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">16</td>
				<td class="bttd">十六、修理费</td>
				<td><input type="text" id="xlfxsfy" name="XLFXSFY" value="0"  ></td>
				<td><input type="text" id="xlfjwzf" name="XLFJWZF" value="0"  ></td>
				<td><input type="text" id="xlfglfy" name="XLFGLFY" value="0"  ></td>
				<td><input type="text" id="xlfjwzf1" name="XLFJWZF1" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">17</td>
				<td class="bttd">十七、包装费</td>
				<td><input type="text" id="bzfxsfy" name="BZFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="bzfglfy" name="BZFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">18</td>
				<td class="bttd">十八、技术转让费</td>
				<td><input type="text" id="jszrfxsfy" name="JSZRFXSFY" value="0"  ></td>
				<td><input type="text" id="jszrfjwzf" name="JSZRFJWZF" value="0"  ></td>
				<td><input type="text" id="jszrfglfy" name="JSZRFGLFY" value="0"  ></td>
				<td><input type="text" id="jszrfjwzf1" name="JSZRFJWZF1" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">19</td>
				<td class="bttd">十九、研究费用</td>
				<td><input type="text" id="yjfyxsfy" name="YJFYXSFY" value="0"  ></td>
				<td><input type="text" id="yjfyjwzf" name="YJFYJWZF" value="0"  ></td>
				<td><input type="text" id="yjfyglfy" name="YJFYGLFY" value="0"  ></td>
				<td><input type="text" id="yjfyjwzf1" name="YJFYJWZF1" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">20</td>
				<td class="bttd">二十、各项税费</td>
				<td><input type="text" id="gxsfxsfy_20" name="GXSFXSFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="gxsfglfy_20" name="GXSFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">21</td>
				<td class="bttd">二十一、利息收支</td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="lxszcwfy" name="LXSZCWFY" value="0"  ></td>
				<td><input type="text" id="lxszjwzf2" name="LXSZJWZF2" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">22</td>
				<td class="bttd">二十二、汇兑差额</td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="hdcecwfy" name="HDCECWFY" value="0"  ></td>
				<td><input type="text" id="hdcejwzf2" name="HDCEJWZF2" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">23</td>
				<td class="bttd">二十三、现金折扣</td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="xjzkcwfy" name="XJZKCWFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="table_td_hc">24</td>
				<td class="table_td_bd">二十四、党组织工作经费</td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td><input type="text" id="dzzgzjfglfy" name="DZZGZJFGLFY" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
				<td align="center">*<input type="hidden" id="" name="" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">25</td>
				<td class="bttd">二十四、其他</td>
				<td><input type="text" id="qtxsfy" name="QTXSFY" value="0"  ></td>
				<td><input type="text" id="qtjwzf" name="QTJWZF" value="0"  ></td>
				<td><input type="text" id="qtglfy" name="QTGLFY" value="0"  ></td>
				<td><input type="text" id="qtjwzf1" name="QTJWZF1" value="0"  ></td>
				<td><input type="text" id="qtcwfy" name="QTCWFY" value="0"  ></td>
				<td><input type="text" id="qtjwzf2" name="QTJWZF2" value="0"  ></td>
			</tr>
			<tr>
				<td align="center" class="bttd">26</td>
				<td class="bttd">合计(1+2+3+…24+25)</td>
				<td><input type="text" id="hjxsfy" name="HJXSFY" value="0"   disabled=""></td>
				<td><input type="text" id="hjjwzf" name="HJJWZF" value="0"   disabled=""></td>
				<td><input type="text" id="hjglfy" name="HJGLFY" value="0"   disabled=""></td>
				<td><input type="text" id="hjjwzf1" name="HJJWZF1" value="0"   disabled=""></td>
				<td><input type="text" id="hjcwfy" name="HJCWFY" value="0"   disabled=""></td>
				<td><input type="text" id="hjjwzf2" name="HJJWZF2" value="0"   disabled=""></td>
			</tr>
		</tbody></table>
	</form>
        <div align="center"><button  onclick="saveTax()">提交</button></div>
</div>

</body>
<script type="text/javascript">
    function saveTax() {
        $.ajax({
            url: "../Ashx/DutyAlert/Du_A104000.ashx",
            contentType: 'application/x-www-form-urlencoded',
            type: 'POST',
            data: $('#fm').serialize(),
            success: function (rs) {
                alert("保存成功！");
            },
            error: function () {
                alert("保存失败，请联系管理员！");
            }
        });
    }
</script>
</html>

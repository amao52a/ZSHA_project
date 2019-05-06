<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_A100000.aspx.cs" Inherits="DutyAlert_Du_A100000" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="../Css/DutyAlert/bootstrap.min.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/funcmenu_nssb.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/lc_sq.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/zkpub.css" rel="stylesheet" />
    <title>中华人民共和国企业所得税年度纳税申报表（A类）</title>
</head>
<body>
<div id="dy_div">
	<input type="hidden" id="bblx" value="SB_SDS_JMCZ_14ND_QYSDSNDNSSBZB"/>
	<table width="700" border="0" align="center">
	   <tbody><tr>
			   <td colspan="7">A100000</td>
			</tr>
		<tr>
			<td colspan="6" align="center" class="pop"><b>中华人民共和国企业所得税年度纳税申报表（A类）</b></td>
           <td align="right">&nbsp;</td>
		</tr>
		<tr>
			<td width="30%"></td>
			<td align="center">
			所属时间：<span id="rq"><%=year%></span>
			</td>
			<td align="right" width="30%">
						金额单位：元(列至角分)
			</td>
			</tr>
	</tbody></table>
  <table width="700" border="1" align="center" class="lc_table">
  <tbody><tr height="19">
    <td width="40" align="center" class="bttd">行次</td>
    <td height="19" align="center" class="bttd">类别</td>
    <td colspan="4" align="center" class="bttd">项目</td>
    <td width="179" align="center" class="bttd">金额</td>
  </tr>
  <tr height="19">
    <td align="center">1</td>
    <td width="118" height="247" rowspan="13" align="center" class="bttd">利润总额计算</td>
    <td colspan="4" align="left" class="bttd">一、营业收入（A101010\101020\103000）</td>
    <td align="right"><input id="yysr" name="yysr" value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">2</td>
    <td colspan="4" align="left" class="bttd"> 　　减：营业成本（A102010\102020\103000）</td>
    <td align="right"><input id="yycb" name="yycb"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">3</td>
    <td colspan="4" align="left" class="bttd">　　　　 营业税金及附加</td>
    <td align="right"><input id="yysj_fj" name="yysj_fj"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">4</td>
    <td colspan="4" align="left" class="bttd">　　　　 销售费用（A104000）</td>
    <td align="right"><input id="xsfy" name="xsfy"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">5</td>
    <td colspan="4" align="left" class="bttd">　　　　    管理费用（A104000）</td>
    <td align="right"><input id="glfy" name="glfy"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">6</td>
    <td colspan="4" align="left" class="bttd">　　　　 财务费用（A104000）</td>
    <td align="right"><input id="cwfy" name="cwfy"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">7</td>
    <td colspan="4" align="left" class="bttd">　　　　 资产减值损失</td>
    <td align="right"><input id="zcjzss" name="zcjzss"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">8</td>
    <td colspan="4" align="left" class="bttd">　　加：公允价值变动收益</td>
    <td align="right"><input id="gyjzbdsy" name="gyjzbdsy"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">9</td>
    <td colspan="4" align="left" class="bttd">　　　　 投资收益</td>
    <td align="right"><input id="tzsy" name="tzsy"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">10</td>
    <td colspan="4" align="left" class="bttd">二、营业利润（1-2-3-4-5-6-7+8+9）</td>
    <td align="right"><input id="yylr" name="yylr"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">11</td>
    <td colspan="4" align="left" class="bttd">　　加：营业外收入（A101010\101020\103000）</td>
    <td align="right"><input id="yywsr" name="yywsr"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">12</td>
    <td colspan="4" align="left" class="bttd">　　减：营业外支出（A102010\102020\103000）</td>
    <td align="right"><input id="yywzc" name="yywzc"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">13</td>
    <td colspan="4" align="left" class="bttd">三、利润总额（10＋11－12）</td>
    <td align="right"><input id="lrze" name="lrze"  value="0"></td>
  </tr>
  <tr height="19">
    <td align="center" class="bttd">14</td>
    <td width="118" height="228" rowspan="10" align="center" class="bttd">应纳税所得额计算</td>
    <td colspan="4" align="left" class="bttd">　　减：境外所得（填写A108000）</td>
    <td align="right"><input id="jwsdje" name="jwsdje"  value="0"></td>
  </tr>
  
  <tr height="19">
    <td height="19" align="center" class="bttd">15</td>
    <td colspan="4" align="left" class="bttd">　　加：纳税调整增加额（填写A105000）</td>
    <td align="right"><input id="nstzzje" name="nstzzje"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">16</td>
    <td colspan="4" align="left" class="bttd">　　减：纳税调整减少额（填写A105000）</td>
    <td align="right"><input id="nstzjse" name="nstzjse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">17</td>
    <td colspan="4" align="left" class="bttd">　　减：免税、减计收入及加计扣除（填写A107010）</td>
    <td align="right"><input id="msjjsrjjjkc" name="msjjsrjjjkc"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">18</td>
    <td colspan="4" align="left" class="bttd">　　加：境外应税所得抵减境内亏损（填写A108000）</td>
    <td align="right"><input id="jwyssddjjnks" name="jwyssddjjnks"  value="0" ></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">19</td>
    <td colspan="4" align="left" class="bttd">四、纳税调整后所得（13-14+15-16-17+18）</td>
    <td align="right"><input id="nstzhsd" name="nstzhsd"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">20</td>
    <td colspan="4" align="left" class="bttd"> 　　减：所得减免（填写A107020）</td>
    <td align="right"><input id="sdjm" name="sdjm"  value="0"/></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">21</td>
    <td colspan="4" align="left" class="bttd">　　减：抵扣应纳税所得额（填写A107030）</td>
    <td align="right"><input id="dkynssde" name="dkynssde"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">22</td>
    <td colspan="4" align="left" class="bttd">　　减：弥补以前年度亏损（填写A106000）</td>
    <td align="right"><input id="mbyqndks" name="mbyqndks"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">23</td>
    <td colspan="4" align="left" class="bttd">五、应纳税所得额（19-20-21-22）</td>
    <td align="right"><input id="ynssde" name="ynssde"  value="0"></td>
  </tr>
  <tr height="19">
    <td align="center" class="bttd">24</td>
    <td width="118" height="285" rowspan="13" align="center" class="bttd">应纳税额计算</td>
    <td colspan="4" align="left" class="bttd">　　税率（25%）</td>
    <td align="right"><input id="sl" name="sl" readonly="readonly" value="25%"></td>
  </tr>
  
  <tr height="19">
    <td height="19" align="center" class="bttd">25</td>
    <td colspan="4" align="left" class="bttd">六、应纳所得税额（23×24）</td>
    <td align="right"><input id="ynsdse" name="ynsdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">26</td>
    <td colspan="4" align="left" class="bttd">　　减：减免所得税额（填写A107040）</td>
    <td align="right"><input id="jmsdse" name="jmsdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">27</td>
    <td colspan="4" align="left" class="bttd">　　减：抵免所得税额（填写A107050）</td>
    <td align="right"><input id="dmsdse" name="dmsdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">28</td>
    <td colspan="4" align="left" class="bttd">七、应纳税额（25-26-27）</td>
    <td align="right"><input id="ynse" name="ynse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">29</td>
    <td colspan="4" align="left" class="bttd">　　加：境外所得应纳所得税额（填写A108000）</td>
    <td align="right"><input id="jwsdynsdse" name="jwsdynsdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">30</td>
    <td colspan="4" align="left" class="bttd">　　减：境外所得抵免所得税额（填写A108000）</td>
    <td align="right"><input id="jwsddmsdse" name="jwsddmsdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">31</td>
    <td colspan="4" align="left" class="bttd">八、实际应纳所得税额（28+29-30）</td>
    <td align="right"><input id="sjynsdse" name="sjynsdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">32</td>
    <td colspan="4" align="left" class="bttd">　　减：本年累计实际已预缴的所得税额</td>
    <td align="right"><input id="bnljsjyyj_sdse" name="bnljsjyyj_sdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">33</td>
    <td colspan="4" align="left" class="bttd">九、本年应补（退）所得税额（31-32）</td>
    <td align="right"><input id="bnybt_sdse" name="bnybt_sdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">34</td>
    <td colspan="4" align="left" class="bttd">　　其中：总机构分摊本年应补（退）所得税额(填写A109000)</td>
    <td align="right"><input id="zjgftbnybtsdse" name="zjgftbnybtsdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">35</td>
    <td colspan="4" align="left" class="bttd">　　　财政集中分配本年应补（退）所得税额（填写A109000）</td>
    <td align="right"><input id="czjzfpbnybtsdse" name="czjzfpbnybtsdse"  value="0"></td>
  </tr>
  <tr height="19">
    <td height="19" align="center" class="bttd">36</td>
    <td colspan="4" align="left" class="bttd">　　 总机构主体生产经营部门分摊本年应补（退）所得税额(填写A109000)</td>
    <td align="right"><input id="zjgztscjybmftbnybtsdse" name="zjgztscjybmftbnybtsdse"  value="0"></td>
  </tr>
</tbody></table>

</div>

</body></html>

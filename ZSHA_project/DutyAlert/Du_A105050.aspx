<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_A105050.aspx.cs" Inherits="DutyAlert_Du_A105050" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="../Css/DutyAlert/bootstrap.min.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/funcmenu_nssb.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/lc_sq.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/zkpub.css" rel="stylesheet" />
    <title>职工薪酬纳税调整明细表</title>
</head>
<body>
  <div id="dy_div">
  <input type="hidden" id="bblx" value="SB_SDS_JMCZ_14ND_ZGXCNSTZMXB">
  <table border="0" width="820" align="center">
    <tbody><tr><td colspan="3" width="100%" align="left">A105050</td></tr>
    <tr>
      <td width="820" colspan="2" align="center"><b>职工薪酬纳税调整明细表</b></td>
      <td align="right">&nbsp;</td>
    </tr>
  </tbody></table>
  <table width="820" border="0" align="center">
    <tbody><tr>
      <td width="33%" align="center">&nbsp;</td>
      <td width="33%" align="center">所属时间：<span id="rq"><%=year%></span></td>
      <td width="34%" align="right">金额单位：元（列至角分）</td>
    </tr>
  </tbody></table>

  <table width="820" border="1" cellspacing="0" align="center" class="lc_table">
    <tbody><tr>
      <td rowspan="2" width="5%" align="center" class="bttd1">行次</td>
      <td rowspan="2" width="30%" align="center" class="bttd1">项目</td>
      <td width="9%" align="center" class="bttd1">账载金额</td>
      <td width="9%" align="center" class="bttd1">实际发生额</td>
      <td width="9%" align="center" class="bttd1">税收规定扣除率</td>
      <td width="9%" align="center" class="bttd1">以前年度累计结转扣除额</td>
      <td width="9%" align="center" class="bttd1">税收金额</td>
      <td width="9%" align="center" class="bttd1">纳税调整金额</td>
      <td width="9%" align="center" class="bttd1">累计结转以后年度扣除额</td>
    </tr>
    <tr>
      <td align="center">1</td>
      <td align="center">2</td>
      <td align="center">3</td>
      <td align="center">4</td>
      <td align="center">5</td>
      <td align="center">6（1-5）</td>
      <td align="center">7（1+4-5）</td>
    </tr>
    <tr>
      <td width="32" align="center" class="bttd1">1</td>
      <td width="270" class="bttd1">一、工资薪金支出</td>
      <td><input id="gzxjzczzje" value="0"  ></td>
      <td><input id="gzxjzcsjfse" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="gzxjzcssje" value="0"  ></td>
      <td><input type="text" id="gzxjzcnstzje" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">2</td>
      <td class="bttd1">&nbsp; 其中：股权激励</td>
      <td><input id="gqjlzzje" value="0"  ></td>
      <td><input id="gqjlsjfse" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="gqjlssje" value="0"  ></td>
      <td><input type="text" id="GQJLNSTZJE" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">3</td>
      <td class="bttd1">二、职工福利费支出</td>
      <td><input id="zgflfzczzje" value="0"  ></td>
      <td><input id="zgflfzcsjfse" value="0"  ></td>
      <td align="center"><input type="text" id="zgflfzcssgdkcl" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="zgflfzcssje" value="0"  ></td>
      <td><input type="text" id="zgflfzcnstzje" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">4</td>
      <td class="bttd1">三、职工教育经费支出</td>
      <td><input id="zgjyjfzczzje" value="0"  ></td>
      <td><input id="zgjyjfzcsjfse" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td align="center"><input type="text" id="zgjyjfzcjzkce" value="0"  ></td>
      <td><input type="text" id="zgjyjfzcssje" value="0"  ></td>
      <td><input type="text" id="zgjyjfzcnstzje" value="0"  ></td>
      <td align="center"><input type="text" id="zgjyjfzcndkce" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">5</td>
      <td class="bttd1"> &nbsp;其中:按税收规定比例扣除的职工教育经费</td>
      <td><input id="blkcjyjfzzje" value="0"  ></td>
      <td><input id="blkcjyjfsjfse" value="0"  ></td>
      <td align="center"><input type="text" id="blkcjyjfssgdkcl" value="0"  ></td>
      <td align="center"><input type="text" id="blkcjyjfjzkce" value="0"  ></td>
      <td><input type="text" id="blkcjyjfssje" value="0"  ></td>
      <td><input type="text" id="blkcjyjfnstzje" value="0"  ></td>
      <td align="center"><input type="text" id="blkcjyjfndkce" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">6</td>
      <td class="bttd1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 按税收规定全额扣除的职工培训费用</td>
      <td><input id="qekcpxfyzzje" value="0"  ></td>
      <td><input id="qekcpxfysjfse" value="0"  ></td>
      <td align="center"><input type="text" id="qekcpxfyssgdkcl" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="qekcpxfyssje" value="0"  ></td>
      <td><input type="text" id="qekcpxfynstzje" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr><tr>
      <td align="center" class="bttd1">7</td>
      <td class="bttd1">四、工会经费支出</td>
      <td><input id="ghjfzczzje" value="0"  ></td>
      <td><input id="ghjfzcsjfse" value="0"  ></td>
      <td align="center"><input type="text" id="ghjfzcssgdkcl" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="ghjfzcssje" value="0"  ></td>
      <td><input type="text" id="ghjfzcnstzje" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">8</td>
      <td class="bttd1">五、各类基本社会保障性缴款</td>
      <td><input id="bzxjkzzje" value="0"  ></td>
      <td><input id="bzxjksjfse" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="bzxjkssje" value="0"  ></td>
      <td><input type="text" id="bzxjknstzje" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">9</td>
      <td class="bttd1">六、住房公积金</td>
      <td><input id="zfgjjzzje" value="0"  ></td>
      <td><input id="zfgjjsjfse" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="zfgjjssje" value="0"  ></td>
      <td><input type="text" id="zfgjjnstzje" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">10</td>
      <td class="bttd1">七、补充养老保险</td>
      <td><input id="bcylbxzzje" value="0"  ></td>
      <td><input id="bcylbxsjfse" value="0"  ></td>
      <td align="center"><input type="text" id="bcylbxssgdkcl" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="bcylbxssje" value="0"  ></td>
      <td><input type="text" id="bcylbxnstzje" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">11</td>
      <td class="bttd1">八、补充医疗保险</td>
      <td><input id="bcylbxzzje1" value="0"  ></td>
      <td><input id="bcylbxsjfse1" value="0"  ></td>
      <td align="center"><input type="text" id="bcylbxssgdkcl1" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="bcylbxssje1" value="0"  ></td>
      <td><input type="text" id="bcylbxnstzje1" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">12</td>
      <td class="bttd1">九、其他</td>
      <td><input id="qtzzje" value="0"  ></td>
      <td><input id="qtsjfse" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td><input type="text" id="qtssje" value="0"  ></td>
      <td><input type="text" id="qtnstzje" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">13</td>
      <td class="bttd1">合计（1+3+4+7+8+9+10+11+12）</td>
      <td><input id="hjzzje" value="0"  ></td>
      <td><input id="hjsjfse" value="0"  ></td>
      <td align="center">*<input type="hidden" id="null" value="0"  ></td>
      <td align="center"><input type="text" id="hjjzkce" value="0"  ></td>
      <td><input type="text" id="hjssje" value="0"  ></td>
      <td><input type="text" id="hjnstzje" value="0"  ></td>
      <td align="center"><input type="text" id="hjndkce" value="0"  ></td>
    </tr>
  </tbody></table>
</div>
</body>
</html>

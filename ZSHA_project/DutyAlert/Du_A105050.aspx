<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Du_A105050.aspx.cs" Inherits="DutyAlert_Du_A105050" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="../Css/DutyAlert/bootstrap.min.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/funcmenu_nssb.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/lc_sq.css" rel="stylesheet" />
    <link href="../Css/DutyAlert/zkpub.css" rel="stylesheet" />
    <script type="text/javascript" src="../Js/jquery-3.3.1.min.js"></script>
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
  <form id="fm">
  <input id="year" name="year" type="hidden" value="<%=year %>"/>
  <input id="companysnumbers" name="companysnumbers" type="hidden" value="<%=companysnumbers %>"/>
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
      <td><input id="gzxjzczzje" name="gzxjzczzje" value="0"  /></td>
      <td><input id="gzxjzcsjfse" name="gzxjzcsjfse" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="gzxjzcssje"name="gzxjzcssje"  value="0"  /></td>
      <td><input type="text" id="gzxjzcnstzje" name="gzxjzcnstzje"  value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">2</td>
      <td class="bttd1">&nbsp; 其中：股权激励</td>
      <td><input id="gqjlzzje" name="gqjlzzje" value="0"  /></td>
      <td><input id="gqjlsjfse" name="gqjlsjfse" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="gqjlssje" name="gqjlssje" value="0"  /></td>
      <td><input type="text" id="gqjlnstzje" name="gqjlnstzje" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">3</td>
      <td class="bttd1">二、职工福利费支出</td>
      <td><input id="zgflfzczzje" name="zgflfzczzje" value="0"  /></td>
      <td><input id="zgflfzcsjfse" name="zgflfzcsjfse" value="0"  /></td>
      <td align="center"><input type="text" id="zgflfzcssgdkcl" name="zgflfzcssgdkcl" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="zgflfzcssje" name="zgflfzcssje" value="0"  /></td>
      <td><input type="text" id="zgflfzcnstzje" name="zgflfzcnstzje" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">4</td>
      <td class="bttd1">三、职工教育经费支出</td>
      <td><input id="zgjyjfzczzje" name="zgjyjfzczzje" value="0"  /></td>
      <td><input id="zgjyjfzcsjfse" name="zgjyjfzcsjfse"  value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td align="center"><input type="text" id="zgjyjfzcjzkce" name="zgjyjfzcjzkce" value="0"  /></td>
      <td><input type="text" id="zgjyjfzcssje" name="zgjyjfzcssje" value="0"  /></td>
      <td><input type="text" id="zgjyjfzcnstzje" name="zgjyjfzcnstzje" value="0"  /></td>
      <td align="center"><input type="text" id="zgjyjfzcndkce" name="zgjyjfzcndkce" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">5</td>
      <td class="bttd1"> &nbsp;其中:按税收规定比例扣除的职工教育经费</td>
      <td><input id="blkcjyjfzzje" name="blkcjyjfzzje" value="0"  /></td>
      <td><input id="blkcjyjfsjfse" name="blkcjyjfsjfse" value="0"  /></td>
      <td align="center"><input type="text" id="blkcjyjfssgdkcl" name="blkcjyjfssgdkcl" value="0" / ></td>
      <td align="center"><input type="text" id="blkcjyjfjzkce" name="blkcjyjfjzkce" value="0"  /></td>
      <td><input type="text" id="blkcjyjfssje" name="blkcjyjfssje" value="0"  /></td>
      <td><input type="text" id="blkcjyjfnstzje" name="blkcjyjfnstzje" value="0"  /></td>
      <td align="center"><input type="text" id="blkcjyjfndkce" name="blkcjyjfndkce" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">6</td>
      <td class="bttd1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 按税收规定全额扣除的职工培训费用</td>
      <td><input id="qekcpxfyzzje" name="qekcpxfyzzje" value="0"  /></td>
      <td><input id="qekcpxfysjfse" name="qekcpxfysjfse" value="0"  /></td>
      <td align="center"><input type="text" id="qekcpxfyssgdkcl" name="qekcpxfyssgdkcl" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="qekcpxfyssje" name="qekcpxfyssje" value="0"  /></td>
      <td><input type="text" id="qekcpxfynstzje" name="qekcpxfynstzje" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr><tr>
      <td align="center" class="bttd1">7</td>
      <td class="bttd1">四、工会经费支出</td>
      <td><input id="ghjfzczzje" name="ghjfzczzje" value="0"  /></td>
      <td><input id="ghjfzcsjfse" name="ghjfzcsjfse" value="0"  /></td>
      <td align="center"><input type="text" id="ghjfzcssgdkcl" name="ghjfzcssgdkcl" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="ghjfzcssje" name="ghjfzcssje" value="0"  /></td>
      <td><input type="text" id="ghjfzcnstzje" name="ghjfzcnstzje" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">8</td>
      <td class="bttd1">五、各类基本社会保障性缴款</td>
      <td><input id="bzxjkzzje" name="bzxjkzzje" value="0"  /></td>
      <td><input id="bzxjksjfse" name="bzxjksjfse" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="bzxjkssje" name="bzxjkssje" value="0"  /></td>
      <td><input type="text" id="bzxjknstzje" name="bzxjknstzje" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">9</td>
      <td class="bttd1">六、住房公积金</td>
      <td><input id="zfgjjzzje" name="zfgjjzzje" value="0"  /></td>
      <td><input id="zfgjjsjfse" name="zfgjjsjfse" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="zfgjjssje" name="zfgjjssje" value="0"  /></td>
      <td><input type="text" id="zfgjjnstzje" name="zfgjjnstzje" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">10</td>
      <td class="bttd1">七、补充养老保险</td>
      <td><input id="bcylbxzzje" name="bcylbxzzje" value="0"  /></td>
      <td><input id="bcylbxsjfse" name="bcylbxsjfse" value="0"  /></td>
      <td align="center"><input type="text" id="bcylbxssgdkcl" name="bcylbxssgdkcl" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="bcylbxssje" name="bcylbxssje" value="0"  /></td>
      <td><input type="text" id="bcylbxnstzje" name="bcylbxnstzje" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">11</td>
      <td class="bttd1">八、补充医疗保险</td>
      <td><input id="bcylbxzzje1" name="bcylbxzzje1" value="0"  /></td>
      <td><input id="bcylbxsjfse1" name="bcylbxsjfse1" value="0"  /></td>
      <td align="center"><input type="text" id="bcylbxssgdkcl1" name="bcylbxssgdkcl1" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="bcylbxssje1" name="bcylbxssje1" value="0"  /></td>
      <td><input type="text" id="bcylbxnstzje1" name="bcylbxnstzje1" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">12</td>
      <td class="bttd1">九、其他</td>
      <td><input id="qtzzje" name="qtzzje" value="0"  /></td>
      <td><input id="qtsjfse" name="qtsjfse" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td><input type="text" id="qtssje" name="qtssje" value="0"  /></td>
      <td><input type="text" id="qtnstzje" name="qtnstzje" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
    </tr>
    <tr>
      <td align="center" class="bttd1">13</td>
      <td class="bttd1">合计（1+3+4+7+8+9+10+11+12）</td>
      <td><input id="hjzzje" name="hjzzje" value="0"  /></td>
      <td><input id="hjsjfse" name="hjsjfse" value="0"  /></td>
      <td align="center">*<input type="hidden" id="null" value="0"  /></td>
      <td align="center"><input type="text" id="hjjzkce" name="hjjzkce" value="0"  /></td>
      <td><input type="text" id="hjssje" name="hjssje" value="0"  /></td>
      <td><input type="text" id="hjnstzje" name="hjnstzje" value="0"  /></td>
      <td align="center"><input type="text" id="hjndkce" name="hjndkce" value="0"  /></td>
    </tr>
  </tbody></table>
  </form>
    <div align="center"><button  onclick="saveTax()">提交</button></div>
</div>
</body>
<script type="text/javascript">
    function saveTax() {
        $.ajax({
            url: "../Ashx/DutyAlert/Du_A105050.ashx",
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

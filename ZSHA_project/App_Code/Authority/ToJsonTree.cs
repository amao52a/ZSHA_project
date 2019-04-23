using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
/// <summary>
/// ToJsonTree 的摘要说明
/// </summary>
public class ToJsonTree
{
    #region 根据DataTable生成EasyUI Tree Json树结构
    /// <summary>
    /// 根据DataTable生成EasyUI Tree Json树结构
    /// </summary>
    /// <param name="tabel">数据源</param>
    /// <param name="id">ID字段</param>
    /// <param name="rela">父ID字段</param>
    /// <param name="pId">父ID起始ID</param>
    /// text 树的text字段
    /// attributes 树的备用字段
    /// sort 树的排序字段
    StringBuilder result = new StringBuilder();
    StringBuilder sb = new StringBuilder();
    public string GetTreeJsonByTable(DataTable tabel, string id, string rela, object pId, string text, string attributes, string sort)
    {
        result.Append(sb.ToString());
        sb.Clear();
        if (tabel.Rows.Count > 0)
        {
            sb.Append("[");
            string filer = string.Format("{0}='{1}'", rela, pId);
            DataRow[] rows = tabel.Select(filer);
            if (rows.Length > 0)
            {
                foreach (DataRow row in rows)
                {
                    sb.Append("{\"id\":\"" + row[id] + "\",\"text\":\"" + row["" + text + ""] + "\",\"attributes\":\"" + row["" + attributes + ""] + "\",\"state\":\"open\",\"sort\":\"" + row["" + sort + ""] + "\"");
                    if (tabel.Select(string.Format("{0}='{1}'", rela, row[id])).Length > 0)
                    {
                        sb.Append(",\"children\":");
                        GetTreeJsonByTable(tabel, id, rela, row[id], text, attributes, sort);
                        result.Append(sb.ToString());
                        sb.Clear();
                    }
                    result.Append(sb.ToString());
                    sb.Clear();
                    sb.Append("},");
                }
                sb = sb.Remove(sb.Length - 1, 1);
            }
            sb.Append("]");
            result.Append(sb.ToString());
            sb.Clear();
        }
        return result.ToString();
    }
    #endregion 
}
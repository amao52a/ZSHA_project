using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class SqlHelper
{
    //读取配置文件中的连接字符串
    private static string connStr = LDCheck.ConnManageString();



    /// <summary>
    /// 参数说明:sql:需要执行的sql脚本，parameters:需要的参数集合
    /// 该方法主要是用于执行，删除、更新和插入操作，返回受影响的行数。
    /// </summary>
    /// <returns>受影响的行数</returns>
    public static int ExecuteNonQuery(string sql, params SqlParameter[] parameters)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandText = sql;
                cmd.Parameters.AddRange(parameters);
                return cmd.ExecuteNonQuery();
            }
        }
    }

    /// <summary>
    /// 执行sql，返回查询结果中的第一行第一列的值
    /// 该方法的返回值第object,所以当我们查询的数据不知道是什么类型的时候可以使用该类。
    /// </summary>
    /// <returns>受影响的行数</returns>
    public static object ExecuteScalar(string sql, params SqlParameter[] parameters)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandText = sql;
                cmd.Parameters.AddRange(parameters);
                return cmd.ExecuteScalar();
            }
        }
    }

    /// <summary>
    /// 执行sql 返回一个DataTable
    /// 该方法主要用于一些查询数据，dt将被填充查询出来的数据，然后返回数据。
    /// </summary>
    /// <returns>返回一个DataTable</returns>
    public static DataTable ExecuteDataTable(string sql, params SqlParameter[] parameters)
    {
        using (SqlDataAdapter adapter = new SqlDataAdapter(sql,connStr))
        {
            DataTable dt = new DataTable();
            adapter.SelectCommand.Parameters.AddRange(parameters);
            adapter.Fill(dt);
            return dt;
        }
    }

    ///<summary>
    ///SqlBulkCopy 大批量数据插入
    ///DataTable dt 和表名 tableNanme
    ///</summary>
    public static void SqlBulkCopyDomo(DataTable dt,string tableNanme)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
            {
                // 设置目标表名称
                bulkCopy.DestinationTableName = tableNanme;
                bulkCopy.BulkCopyTimeout = 3600;//超时时间设置
                bulkCopy.BatchSize = 1000;//分批提交记录数，可不设

                bulkCopy.WriteToServer(dt);
            }
        }

    }

    /// <summary>
    /// 执行sql脚本
    /// 该方法返回的SqlDataReader 类型对象需要一直使用SqlConnection对象，所以不能释放。该类型读取数据是一行一行的读取。
    /// 读取使用的是该类的Read()方法，返回值为bool判断数据是否为空(也就是是否读取到最后一行)，该方法将自动读取下到下一条记录。
    /// </summary>
    /// <returns>返回一个SqlDataReader</returns>
    public static SqlDataReader ExecuteReader(string sql, params SqlParameter[] parameters)
    {
        //SqlDataReader要求，它读取数据的时候有，它独占它的SqlConnection对象，而且SqlConnection必须是Open状态             
        SqlConnection conn = new SqlConnection(connStr);//不要释放连接，因为后面还需要连接打开状态
        SqlCommand cmd = conn.CreateCommand();
        conn.Open();
        cmd.CommandText = sql;
        cmd.Parameters.AddRange(parameters);
        //CommandBehavior.CloseConnection当SqlDataReader释放的时候，顺便把SqlConnection对象也释放掉
        return cmd.ExecuteReader(CommandBehavior.CloseConnection);  
    }


}


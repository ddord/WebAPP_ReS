using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApplication1.classL_common
{
    public class DataBase
    {
        public void ExecuteQuery(string query)
        {
            using (SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                SqlCommand sqlCommand = new SqlCommand(query, sqlCon);
                sqlCon.Open();
                sqlCommand.ExecuteNonQuery();            
            }
        }

        public object ExecuteQueryResult(string query)
        {
            using (SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                object val = null;
                SqlCommand sqlCommand = new SqlCommand(query, sqlCon);
                sqlCon.Open();
                val = sqlCommand.ExecuteScalar();

                return val;
            }
        }

        public DataTable ExecuteQueryDataTable(string query)
        {
            using (SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                DataSet dataSet = new DataSet();
                sqlCon.Open();
                SqlDataAdapter dataAdapter = new SqlDataAdapter(query, sqlCon);
                dataAdapter.Fill(dataSet, "tempDs");

                return dataSet.Tables[0];
            }                
        }

    }
}
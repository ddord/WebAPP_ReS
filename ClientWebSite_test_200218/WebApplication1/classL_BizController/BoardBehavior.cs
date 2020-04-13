using WebModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace WebApplication1
{
    public class BoardBehavior
    {

        public int insertUpdateBoardWrite(string userId, string userName, string category, string mainBoardTitle, string mainBoardContent, DateTime nowDate, string statementType)
        {
            int result = -1;

            BoardUserInfo boardUserInfo = new BoardUserInfo();

            boardUserInfo.userID = userId;
            boardUserInfo.userName = userName;
            boardUserInfo.category = category;
            boardUserInfo.mainBoardTitle = mainBoardTitle;
            boardUserInfo.mainBoardContent = mainBoardContent;
            boardUserInfo.mainBoardPwd = "";
            boardUserInfo.writeDate = nowDate;

            using (SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                string spName = "sp_MainBoard_CRUD";
                using (SqlCommand sqlComm = new SqlCommand(spName, sqlConn))
                {
                    sqlComm.Parameters.Add("@mainBoardNo", SqlDbType.NVarChar).Value = 0;
                    sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = userId;
                    sqlComm.Parameters.Add("@id_Name", SqlDbType.NVarChar).Value = userName;
                    sqlComm.Parameters.Add("@category", SqlDbType.NVarChar).Value = category;
                    sqlComm.Parameters.Add("@mainBoardTitle", SqlDbType.NVarChar).Value = mainBoardTitle;
                    sqlComm.Parameters.Add("@mainBoardContent", SqlDbType.NVarChar).Value = mainBoardContent;
                    sqlComm.Parameters.Add("@writeDate", SqlDbType.DateTime).Value = nowDate;
                    sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = statementType;
                    sqlComm.CommandType = CommandType.StoredProcedure;
                    sqlConn.Open();
                    int test = sqlComm.ExecuteNonQuery();
                    result = Convert.ToInt32(sqlComm.ExecuteScalar());
                }                
            }

            return result;
        }

        public DataTable SelectBoardView(string userId, string category, string boardNo, string statementType)
        {
            BoardUserInfo boardUserInfo = new BoardUserInfo();
            DataSet result = new DataSet();

            boardUserInfo.userID = userId;
            boardUserInfo.category = category;
            boardUserInfo.boardNo = boardNo;

            using (SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                string spName = "sp_MainBoard_CRUD";
                using (SqlCommand sqlComm = new SqlCommand(spName, sqlConn))
                {
                    using (SqlDataAdapter sqlAdt = new SqlDataAdapter(sqlComm))
                    {
                        sqlComm.Parameters.Add("@mainBoardNo", SqlDbType.NVarChar).Value = boardNo;
                        sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = userId;
                        sqlComm.Parameters.Add("@category", SqlDbType.NVarChar).Value = category;
                        sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = statementType;
                        sqlComm.CommandType = CommandType.StoredProcedure;
                        sqlConn.Open();

                        sqlAdt.Fill(result);                        
                    }
                }
            }

            if (result.Tables.Count >= 1)            
                return result.Tables[0];            
            else            
                return null;            
        }
    }
}
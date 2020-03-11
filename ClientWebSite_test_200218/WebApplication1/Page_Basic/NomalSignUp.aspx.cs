using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Page_Basic
{
    public partial class NomalSignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod()]
        public static bool IsPromoValid(string code)
        {
            string promoCode = "ABCDEFG";
            bool result = code.ToLower() == promoCode.ToLower();
            return result;
        }

        protected void SignUp_Click(object sender, EventArgs e)
        {
            using (SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {

                SqlCommand sqlComm = new SqlCommand();
                sqlConn.Open();
                sqlComm = new SqlCommand("pro_userInfo_CRUD", sqlConn);
                sqlComm.CommandType = CommandType.StoredProcedure;

                sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = txbUserID.Text;
                sqlComm.Parameters.Add("@userName", SqlDbType.NVarChar).Value = txbUserName.Text;
                sqlComm.Parameters.Add("@userPwd", SqlDbType.NVarChar).Value = txbPwd.Text;
                sqlComm.Parameters.Add("@userAddress", SqlDbType.NVarChar).Value = txbAddress.Text;
                sqlComm.Parameters.Add("@userEmail", SqlDbType.NVarChar).Value = txbEmail.Text;
                sqlComm.Parameters.Add("@userGrade", SqlDbType.NVarChar).Value = "FF";
                sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = "Insert";

                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlComm);
                

                sqlComm.ExecuteNonQuery();
            }
          
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Security;

namespace WebApplication1.Page_Basic
{
    public partial class LoginMain : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request)
                {
                    StatusText.Text = string.Format("환영합니다. !!");
                    LoginStatus.Visible = true;
                }
                else
                {
                    LoginForm.Visible = true;
                }
            }
        }

        protected void SignIn(object sender, System.EventArgs e)
        {
            var userId = txbUserID.Text;
            var userPw = txbPassword.Text;

            if (userId == "" || userPw == "")
            {
                lbl_error.Visible = true;
                lbl_error.Text = "아이디 또는 비밀번호를 입력해주시기 바랍니다.";
                txbUserID.Focus();
            }
            else
            {
                using (SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
                {

                    SqlCommand sqlComm = new SqlCommand("SELECT * FROM UserInfor WHERE userID = @userID and userPwd = @userPwd", sqlConn);
                    sqlConn.Open();
                    sqlComm.Parameters.AddWithValue("@userID", userId);
                    sqlComm.Parameters.AddWithValue("@userPwd", userPw);

                    SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlComm);
                    DataTable dt = new DataTable();
                    dataAdapter.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        string userName = dt.Rows[0].ItemArray[dt.Columns["userName"].Ordinal].ToString();
                        FormsAuthentication.SetAuthCookie(userName, true);
                        Session["userID"] = userId;
                        Session["userName"] = userName;
                        Response.Redirect("~/Main.aspx");
                    }
                    else
                    {
                        lbl_error.Visible = true;
                        lbl_error.Text = "아이디 또는 비밀번호를 입력해주시기 바랍니다.";
                    }
                }
            }




        }

    }
}
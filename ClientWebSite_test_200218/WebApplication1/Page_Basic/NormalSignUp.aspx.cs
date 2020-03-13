using Newtonsoft.Json.Linq;
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
    public class UserInfo
    {
        private string id;
        public string ID
        {
            get
            {
                return id;
            }
            set
            {
                id = value;
            }
        }

        private string name;
        public string Name
        {
            get
            {
                return name;
            }
            set
            {
                name = value;
            }
        }

        private string pwd;
        public string Pwd
        {
            get
            {
                return pwd;
            }
            set
            {
                pwd = value;
            }
        }

        private string pwdRe;
        public string PwdRe
        {
            get
            {
                return pwdRe;
            }
            set
            {
                pwdRe = value;
            }
        }

        private string addr;
        public string Addr
        {
            get
            {
                return addr;
            }
            set
            {
                addr = value;
            }
        }

        private string email;
        public string Email
        {
            get
            {
                return email;
            }
            set
            {
                email = value;
            }
        }

        private string idcheck;
        public string IDcheck
        {
            get
            {
                return idcheck;
            }
            set
            {
                idcheck = value;
            }
        }
    }
   
    public partial class NomalSignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public bool userExist = false;

        [WebMethod()]
        public static bool IsPromoValid(string code)
        {
            string promoCode = "ABCDEFG";
            bool result = code.ToLower() == promoCode.ToLower();
            return result;
        }

        [WebMethod()]
        public static string checkID(string id)
        {
            using (SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                if (id.Trim() == "")
                    return "아이디를 입력해주세요.";

                SqlCommand sqlComm = new SqlCommand();
                sqlConn.Open();
                sqlComm = new SqlCommand("SELECT * FROM UserInfor WHERE userID = @userID", sqlConn);
                sqlComm.Parameters.AddWithValue("@userID", id);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlComm);
                DataTable dt = new DataTable();
                dataAdapter.Fill(dt);
                
                if (dt.Rows.Count > 0)
                {
                    return "아이디가 존재합니다.";
                }
                return "아이디 생성이 가능합니다.";
            }
        }

        [WebMethod()]
        public static string[] SignUp_click(UserInfo userInfo)
        {
            int sum = 0;
            //string[] return_mun = new string[7];
            string[] return_mun = new string[7];

            for (int i = 0; i < 6; i++)
            {
                
                switch (i)
                {
                    case 0:
                        if (userInfo.ID == "")
                            return_mun[0] = "아이디 필수 입력.";
                        else if (userInfo.IDcheck == "false")
                            return_mun[0] = "아이디 중복확인을 해주세요.";
                        else
                        {
                            return_mun[0] = "";
                            sum += 1;
                        }
                        break;
                    case 1:
                        if (userInfo.Name == "")
                            return_mun[1] = "이름 필수 입력.";
                        else
                        {
                            return_mun[1] = "";
                            sum += 1;
                        }
                        break;
                    case 2:
                        if (userInfo.Pwd == "")
                            return_mun[2] = "비밀번호 필수 입력.";
                        else
                        {
                            return_mun[2] = "";
                            sum += 1;
                        }
                        break;
                    case 3:
                        if (userInfo.Pwd != userInfo.PwdRe)
                            return_mun[3] = "비밀번호를 다시 확인해주세요.";
                        else
                        {
                            return_mun[3] = "";
                            sum += 1;
                        }
                        break;
                    case 4:
                        if (userInfo.Addr == "")
                            return_mun[4] = "주소 필수 입력.";
                        else
                        {
                            return_mun[4] = "";
                            sum += 1;
                        }
                        break;
                    case 5:
                        if (userInfo.Email == "")
                            return_mun[5] = "이메일 필수 입력.";
                        else
                        {
                            return_mun[5] = "";
                            sum += 1;
                        }
                        break;
                }
            }

            if (sum == 6)
            {
                using (SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
                {
                    SqlCommand sqlComm = new SqlCommand();
                    sqlConn.Open();
                    sqlComm = new SqlCommand("pro_userInfo_CRUD", sqlConn);
                    sqlComm.CommandType = CommandType.StoredProcedure;

                    sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = userInfo.ID;
                    sqlComm.Parameters.Add("@userName", SqlDbType.NVarChar).Value = userInfo.Name;
                    sqlComm.Parameters.Add("@userPwd", SqlDbType.NVarChar).Value = userInfo.Pwd;
                    sqlComm.Parameters.Add("@userAddress", SqlDbType.NVarChar).Value = userInfo.Addr;
                    sqlComm.Parameters.Add("@userEmail", SqlDbType.NVarChar).Value = userInfo.Email;
                    sqlComm.Parameters.Add("@userGrade", SqlDbType.NVarChar).Value = "FF";
                    sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = "Insert";

                    SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlComm);
                    sqlComm.ExecuteNonQuery();

                    sqlComm = new SqlCommand("SELECT * FROM UserInfor WHERE userID = @userID", sqlConn);
                    sqlComm.Parameters.AddWithValue("@userID", userInfo.ID);

                    return_mun[6] = "회원가입 완료.";
                    return return_mun;
                }
            }
            else
            {
                return_mun[6] = "다시 확인 해주시기 바랍니다.";
                return return_mun;
            }
 
        }

        protected void SignUp_Click(object sender, EventArgs e)
        {
            using (SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                SqlCommand sqlComm = new SqlCommand();
                sqlConn.Open();
                sqlComm = new SqlCommand("pro_userInfo_CRUD", sqlConn);
                sqlComm.CommandType = CommandType.StoredProcedure;
                
                sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = txbUserID.ToString();
                sqlComm.Parameters.Add("@userName", SqlDbType.NVarChar).Value = txbUserName.Text;
                sqlComm.Parameters.Add("@userPwd", SqlDbType.NVarChar).Value = txbPwd.Text;
                sqlComm.Parameters.Add("@userAddress", SqlDbType.NVarChar).Value = txbAddress.Text;
                sqlComm.Parameters.Add("@userEmail", SqlDbType.NVarChar).Value = txbEmail.Text;
                sqlComm.Parameters.Add("@userGrade", SqlDbType.NVarChar).Value = "FF";
                sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = "Insert";

                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlComm);                
                sqlComm.ExecuteNonQuery();

                sqlComm = new SqlCommand("SELECT * FROM UserInfor WHERE userID = @userID", sqlConn);
                sqlComm.Parameters.AddWithValue("@userID", txbUserID.ToString());

                dataAdapter = new SqlDataAdapter(sqlComm);
                DataTable dt = new DataTable();
                dataAdapter.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    string script = @"<script type='text/javascript'>
                                              alert('회원가입 완료.');
                                              location.href = 'LoginMain.aspx';
                                          </script>";
                    this.ClientScript.RegisterClientScriptBlock(this.GetType(), "add", script);
                }
                else
                {
                    string script = @"<script type='text/javascript'>
                                              alert('입력 부분을 확인해주세요.');
                                          </script>";
                    this.ClientScript.RegisterClientScriptBlock(this.GetType(), "warning", script);
                }
            }          
        }
    }
}
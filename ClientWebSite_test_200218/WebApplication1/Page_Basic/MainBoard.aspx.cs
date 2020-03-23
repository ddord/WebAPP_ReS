using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Page_Basic
{


    public partial class MainBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
            {
                BindRepeator();

                if (Request.IsAuthenticated)
                {
                    btnBoardWrite.Visible = true;
                }
            }            
        }        
        private void BindRepeator()
        {
            using(SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                SqlCommand sqlComm = new SqlCommand("sp_MainBoard_CRUD", sqlCon);
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlCon.Open();
                sqlComm.Parameters.Add("@mainBoardNo", SqlDbType.Int).Value = 0;
                sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@category", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@id_Name", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@mainBoardTitle", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@mainBoardContent", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@writeDate", SqlDbType.DateTime).Value = DateTime.Now;
                sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = "Select";

                RepeaterMainBoardList.DataSource = sqlComm.ExecuteReader();
                RepeaterMainBoardList.DataBind();
            }
        }

        protected void lnkbDetails_Click(object sender, EventArgs e)
        {
            CheckLogining(sender);
        }

        private void CheckLogining(object sender)
        {
            if (Request.IsAuthenticated)
            {
                LinkButton link = sender as LinkButton;
                Session["Arg"] = link.CommandArgument.ToString();
                Response.Redirect("MainBoardView.aspx");
            }
            else
            {
                Response.Write("<script>alert('로그인이 필요합니다.') ; location.href= 'LoginMain.aspx'</script>");
            }
        }

        protected void btnBoardWrite_Click(object sender, EventArgs e)
        {
            Response.Redirect("MainBoardWrite.aspx");
        }
    }
}
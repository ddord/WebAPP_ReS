using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Page_Basic
{
    public partial class MainBoardWrite : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlBoardCategory.Items.Add("자유게시판");
                ddlBoardCategory.Items.Add("공지사항");
            }
        }

        protected void btnWrite_Click(object sender, EventArgs e)
        {
            using (SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                SqlCommand sqlComm = new SqlCommand();
                sqlConn.Open();
                sqlComm = new SqlCommand("sp_MainBoard_CRUD", sqlConn);
                sqlComm.CommandType = CommandType.StoredProcedure;

                sqlComm.Parameters.Add("@mainBoardNo", SqlDbType.Int).Value = 0;
                sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = Session["userID"].ToString();
                sqlComm.Parameters.Add("@category", SqlDbType.NVarChar).Value = ddlBoardCategory.SelectedValue.ToString();
                sqlComm.Parameters.Add("@id_Name", SqlDbType.NVarChar).Value = Session["userName"].ToString();
                sqlComm.Parameters.Add("@mainBoardTitle", SqlDbType.NVarChar).Value = txbBoardTitle.Text;
                sqlComm.Parameters.Add("@mainBoardContent", SqlDbType.NVarChar).Value = txbBoardContent.Text;
                sqlComm.Parameters.Add("@writeDate", SqlDbType.DateTime).Value = DateTime.Now;
                sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = "Insert";

                sqlComm.ExecuteNonQuery();

                Response.Write("<script>alert('글 작성 완료.') ; location.href= 'MainBoard.aspx'</script>");

            }
        }
    }
}
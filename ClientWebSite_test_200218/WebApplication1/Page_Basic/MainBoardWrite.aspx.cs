using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.classL_common;

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
                string previousUrl = Request.UrlReferrer.ToString();
                if (previousUrl.Contains("MainBoardView"))
                {
                    btnWrite.Text = "수정";

                    DataBase DB = new DataBase();
                    string query = String.Format("SELECT * FROM mainBoard WHERE mainBoardNo={0}", Session["mainBoardNo"].ToString());
                    DataTable dataTable = DB.ExecuteQueryDataTable(query);
                    DataRow dataRow = dataTable.Rows[0];

                    ddlBoardCategory.Text = dataRow["category"].ToString();
                    txbBoardTitle.Text = dataRow["mainBoardTitle"].ToString();
                    txbBoardContent.Text = dataRow["mainBoardContent"].ToString();
                }                    
                else
                    btnWrite.Text = "확인";
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

                string returnMessage = "", stateType = "";                
                if ((btnWrite.Text == "수정") && (Session["mainBoardNo"] != null))
                {
                    sqlComm.Parameters.Add("@mainBoardNo", SqlDbType.Int).Value = Session["mainBoardNo"].ToString();
                    returnMessage = "글 수정 완료.";
                    Session.Remove("mainBoardNo");
                    stateType = "Update";
                }
                else
                {
                    sqlComm.Parameters.Add("@mainBoardNo", SqlDbType.Int).Value = 0;
                    returnMessage = "글 작성 완료.";
                    stateType = "Insert";
                }
                
                sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = Session["userID"].ToString();
                sqlComm.Parameters.Add("@category", SqlDbType.NVarChar).Value = ddlBoardCategory.SelectedValue.ToString();
                sqlComm.Parameters.Add("@id_Name", SqlDbType.NVarChar).Value = Session["userName"].ToString();
                sqlComm.Parameters.Add("@mainBoardTitle", SqlDbType.NVarChar).Value = txbBoardTitle.Text;
                sqlComm.Parameters.Add("@mainBoardContent", SqlDbType.NVarChar).Value = txbBoardContent.Text;
                sqlComm.Parameters.Add("@writeDate", SqlDbType.DateTime).Value = DateTime.Now;
                sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = stateType;

                sqlComm.ExecuteNonQuery();
                
                Response.Write("<script>alert('" + returnMessage + "') ; location.href= 'MainBoardView.aspx'</script>");
            }
        }
    }
}
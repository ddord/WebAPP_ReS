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
    public partial class MainBoardView : System.Web.UI.Page
    {
        protected DataRow dataRow;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {/*
                DataTable dt = boardRead(Session["category"].ToString().Trim(), Session["boardNo"].ToString().Trim());
                dataRow = dt.Rows[0];

                lblBoardTilte.Text = dataRow["mainBoardTitle"].ToString();
                lblBoardDate.Text = String.Format("{0:yyyy.MM.dd. hh:mm}", dataRow["writeDate"]);
                lblBoardNickName.Text = dataRow["id_Name"].ToString();
                lblUserId.Text = "(" + String.Format("{0}****", dataRow["userID"].ToString().Substring(0, 3)) + ")";
                string dsd = dataRow["mainBoardContent"].ToString();
                string www = dsd.Replace("\r\n", "<br />");
                //lblBoardContent.Text = www;

                if (Request.IsAuthenticated && (dataRow["userID"].ToString() == Session["userID"].ToString()))
                {
                    btnBoardModify.Visible = true;
                    btnBoardDelete.Visible = true;
                }*/
            }
        }

        private DataTable boardRead(string category, string number)
        {
            DataBase DB = new DataBase();
            string query = String.Format("SELECT * FROM mainBoard WHERE category='{0}' AND mainBoardNo={1}", category, number);
            return DB.ExecuteQueryDataTable(query);
        }

        protected void btnListBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("MainBoard.aspx");
        }

        protected void btnBoardModify_Click(object sender, EventArgs e)
        {
            Response.Redirect("MainBoardWrite.aspx");
        }

        protected void btnBoardDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                SqlCommand sqlComm = new SqlCommand("sp_MainBoard_CRUD", sqlCon);
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlCon.Open();
                sqlComm.Parameters.Add("@mainBoardNo", SqlDbType.Int).Value = Session["mainBoardNo"].ToString();
                sqlComm.Parameters.Add("@userID", SqlDbType.NVarChar).Value = Session["userID"].ToString();
                sqlComm.Parameters.Add("@category", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@id_Name", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@mainBoardTitle", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@mainBoardContent", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@writeDate", SqlDbType.DateTime).Value = DateTime.Now;
                sqlComm.Parameters.Add("@StatementType", SqlDbType.NVarChar).Value = "Delete";

                sqlComm.ExecuteReader();

                Session.Remove("mainBoardNo");
            }

            Response.Redirect("MainBoard.aspx");
        }
    }
}
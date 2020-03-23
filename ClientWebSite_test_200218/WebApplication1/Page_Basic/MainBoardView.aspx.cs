using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.classL_common;

namespace WebApplication1.Page_Basic
{
    public partial class MainBoardView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            string temp_Arg = Session["Arg"].ToString();
            string[] temp_List = temp_Arg.Split('/');

            DataTable dt = Read(temp_List[0].Trim(), temp_List[1].Trim());

            DataRow dataRow = dt.Rows[0];

            lblBoardTilte.Text = dataRow["mainBoardTitle"].ToString();
            lblBoardDate.Text = String.Format("{0:yyyy.MM.dd. hh:mm}", dataRow["writeDate"]);
            lblBoardNickName.Text = dataRow["id_Name"].ToString();
            lblUserId.Text = "(" + String.Format("{0}****", dataRow["userID"].ToString().Substring(0, 3)) + ")";
            lblBoardContent.Text = dataRow["mainBoardContent"].ToString();            
        }

        public DataTable Read(string category, string number)
        {
            DataBase DB = new DataBase();
            string query = String.Format("SELECT * FROM mainBoard WHERE category='{0}' AND mainBoardNo={1}", category, number);
            return DB.ExecuteQueryDataTable(query);
        }

        protected void btnListBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("MainBoard.aspx");
        }
    }
}
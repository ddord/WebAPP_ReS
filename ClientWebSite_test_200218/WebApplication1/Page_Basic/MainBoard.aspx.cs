using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
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
            }            
        }        
        private void BindRepeator()
        {
            using(SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                SqlCommand sqlcomm = new SqlCommand("GetMainBoardList", sqlCon);
                sqlcomm.CommandType = CommandType.StoredProcedure;
                sqlCon.Open();
                RepeaterMainBoardList.DataSource = sqlcomm.ExecuteReader();
                RepeaterMainBoardList.DataBind();
            }
        }

        protected void lnkbDetails_Click(object sender, EventArgs e)
        {
            LinkButton link = sender as LinkButton;
            Session["Arg"] = link.CommandArgument.ToString();
            Response.Redirect("MainBoardView.aspx");
        }
    }
}
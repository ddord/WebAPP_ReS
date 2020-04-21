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
                int currentSartPageCounting = 1;
                ViewState["currentPageScope"] = 0;
                
                BindRepeator(currentSartPageCounting, int.Parse(ddlListCount.SelectedItem.ToString()));                
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

        private void BindRepeator(int pageIndex, int pageSize)
        {
            using (SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            {
                using (SqlCommand sqlCom = new SqlCommand("sp_GetMainboard_PageCount", sqlCon))
                {
                    sqlCom.CommandType = CommandType.StoredProcedure;
                    sqlCom.Parameters.AddWithValue("@pageIndex", pageIndex);
                    sqlCom.Parameters.AddWithValue("@pageSize", pageSize);
                    sqlCom.Parameters.Add("@recordCount", SqlDbType.Int, 4);
                    sqlCom.Parameters["@recordCount"].Direction = ParameterDirection.Output;
                    sqlCon.Open();
                    IDataReader idr = sqlCom.ExecuteReader();
                    RepeaterMainBoardList.DataSource = idr;
                    RepeaterMainBoardList.DataBind();
                    idr.Close();
                    int recordCount = Convert.ToInt32(sqlCom.Parameters["@recordCount"].Value);
                    this.PopulatePager(recordCount, pageIndex, pageSize);                  
                }
            }
        }

        private void PopulatePager(int recordCount, int currentPage, int pageSize)
        {
            double ddlPageCount = (double)((decimal)recordCount / Convert.ToDecimal(pageSize));
            int fullPageCount = (int)Math.Ceiling(ddlPageCount);
            bool endScope = false;
            int startPage = 0, endPage = 0;
            int prePage = 1, nextPage = fullPageCount;

            int maxPages = 5;

            if (currentPage < 1)
                currentPage = 1;              
            else if (currentPage > fullPageCount)
                currentPage = fullPageCount;

            if (fullPageCount <= maxPages)
            { 
                startPage = 1;
                endPage = fullPageCount;
            }
            else
            {
                if ((currentPage >= maxPages) && ((currentPage % maxPages) == 0))
                {
                    startPage = ((currentPage / maxPages) * maxPages) - 4;
                    endPage = startPage + 4;
                }
                else
                {
                    startPage = ((currentPage / maxPages) * maxPages) + 1;
                    endPage = startPage + 4;
                }

                prePage = startPage - 1;                
                nextPage = endPage + 1;

                if ((fullPageCount / maxPages) == (currentPage / maxPages) &&  (fullPageCount < endPage))
                { 
                    endPage = fullPageCount;
                    endScope = true;
                }
            }
            
            List<ListItem> pages = new List<ListItem>();
            if (fullPageCount > 0)
            {
                if (currentPage > maxPages)
                {
                    pages.Add(new ListItem(" << ", "1", currentPage > 1));
                    pages.Add(new ListItem(" < ", prePage.ToString(), currentPage > 1));
                }
                for (int i = startPage; i <= endPage; i++)
                {
                    pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                }
                if (!endScope)
                {
                    pages.Add(new ListItem(" > ", nextPage.ToString(), currentPage < fullPageCount));
                    pages.Add(new ListItem(" >> ", fullPageCount.ToString(), currentPage < fullPageCount));
                }
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();
        }

        protected void Page_Changed(object sender, EventArgs e)
        {
            LinkButton linkBtn = sender as LinkButton;
            linkBtn.Attributes.Add("class", "lnkBtnSelect");
            int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
            this.BindRepeator(pageIndex, int.Parse(ddlListCount.SelectedItem.ToString()));
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
                string temp_Arg = link.CommandArgument.ToString();
                string[] temp_List = temp_Arg.Split('/');
                
                Session["category"] = temp_List[0].Trim();
                Session["boardNo"] = temp_List[1].Trim();
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

        protected void ddlListCount_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindRepeator(1, int.Parse(ddlListCount.SelectedItem.ToString()));
        }
    }
}
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
                ViewState["currentPageList"] = currentSartPageCounting;
                
                BindRepeator(Convert.ToInt32(ViewState["currentPageList"]), int.Parse(ddlListCount.SelectedItem.ToString()));                
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
            int pageCount = (int)Math.Ceiling(ddlPageCount);

            if (currentPage < 1)
                currentPage = 1;
            else if (currentPage > pageCount)
                currentPage = pageCount;

            int startPage, endPage;
            if (totalPages <= maxPages)
            {
                // total pages less than max so show all pages
                startPage = 1;
                endPage = totalPages;
            }
            else
            {
                // total pages more than max so calculate start and end pages
                var maxPagesBeforeCurrentPage = (int)Math.Floor((decimal)maxPages / (decimal)2);
                var maxPagesAfterCurrentPage = (int)Math.Ceiling((decimal)maxPages / (decimal)2) - 1;
                if (currentPage <= maxPagesBeforeCurrentPage)
                {
                    // current page near the start
                    startPage = 1;
                    endPage = maxPages;
                }
                else if (currentPage + maxPagesAfterCurrentPage >= totalPages)
                {
                    // current page near the end
                    startPage = totalPages - maxPages + 1;
                    endPage = totalPages;
                }
                else
                {
                    // current page somewhere in the middle
                    startPage = currentPage - maxPagesBeforeCurrentPage;
                    endPage = currentPage + maxPagesAfterCurrentPage;
                }
            }

            List<ListItem> pages = new List<ListItem>();
            if (pageCount > 0)
            {
                pages.Add(new ListItem(" << ", "1", currentPage > 1));
                pages.Add(new ListItem(" < ", "1", currentPage > 1));
                for (int i = currentPage; i <= pageCount; i++)
                {
                    pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                }
                pages.Add(new ListItem(" > ", pageCount.ToString(), currentPage < pageCount));
                pages.Add(new ListItem(" >> ", pageCount.ToString(), currentPage < pageCount));
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
            BindRepeator(Convert.ToInt32(ViewState["currentPageList"]), int.Parse(ddlListCount.SelectedItem.ToString()));
        }

        protected void lnkPagePre_Click(object sender, EventArgs e)
        {

            int ds = 0;
            int pageIndexMinusTen = int.Parse((sender as LinkButton).CommandArgument);
            ViewState["currentPageList"] = Convert.ToInt32(ViewState["currentPageList"]) + pageIndexMinusTen;
            BindRepeator(Convert.ToInt32(ViewState["currentPageList"]), int.Parse(ddlListCount.SelectedItem.ToString()));
        }

        protected void lnkPageAfter_Click(object sender, EventArgs e)
        {
            int pageIndexPlusTen = int.Parse((sender as LinkButton).CommandArgument);
            ViewState["currentPageList"] = Convert.ToInt32(ViewState["currentPageList"]) + pageIndexPlusTen;
            BindRepeator(Convert.ToInt32(ViewState["currentPageList"]), int.Parse(ddlListCount.SelectedItem.ToString()));
        }
    }
}
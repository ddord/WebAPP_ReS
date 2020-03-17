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
    public class MainBoardList
    {
        public int Id { get; set; }
        public string Category { get; set; }
        public string Title { get; set; }
        public string Name { get; set; }                
        public string WirteDate { get; set; }
    }

    public partial class MainBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public void GetMainBoardList()
        {
            List<MainBoardList> mainBoardLists = new List<MainBoardList>();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetMainBoardList", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader sqlreader = cmd.ExecuteReader();
                while (sqlreader.Read())
                {
                    MainBoardList mainBoardList = new MainBoardList();
                    mainBoardList.Id = Convert.ToInt32(sqlreader["Id"]);
                    mainBoardList.Category = sqlreader["FirstName"].ToString();
                    mainBoardList.Title = sqlreader["LastName"].ToString();
                    mainBoardList.Name = sqlreader["Gender"].ToString();
                    string getDate = String.Format("yyyy.MM.dd.", sqlreader["HireDate"]);
                    if (DateTime.Now.ToString("yyyy.MM.dd") == getDate)
                        mainBoardList.WirteDate = String.Format("HH:mm", sqlreader["HireDate"]);
                    else
                        mainBoardList.WirteDate = getDate;

                    mainBoardLists.Add(mainBoardList);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(mainBoardLists));
        }
    }
}
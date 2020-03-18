using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace WebApplication1.Page_Basic
{
    public class MainBoardList
    {
        public string Id { get; set; }
        public string Category { get; set; }
        public string Title { get; set; }
        public string Name { get; set; }
        public string WirteDate { get; set; }
    }

    /// <summary>
    /// Summary description for Method_Basic
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Method_Basic : System.Web.Services.WebService
    {

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
                    mainBoardList.Id = sqlreader["userID"].ToString();
                    mainBoardList.Category = sqlreader["boardCategory"].ToString();
                    mainBoardList.Title = sqlreader["mainBoardTitle"].ToString();
                    mainBoardList.Name = sqlreader["id_Name"].ToString();
                    string getDate = String.Format("{0:yyyy.MM.dd.}", sqlreader["writeDate"]);
                    if (DateTime.Now.ToString("yyyy.MM.dd.") == getDate)
                        mainBoardList.WirteDate = String.Format("{0:HH:mm}", sqlreader["writeDate"]);
                    else
                        mainBoardList.WirteDate = getDate;

                    mainBoardLists.Add(mainBoardList);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(mainBoardLists));
        }

        [WebMethod]
        public string bind(string pageNo)
        {
            SqlConnection conn = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            DataSet dataSet = new DataSet();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            cmd.Connection = conn;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_GetProductByCustomPaging";
            cmd.Parameters.AddWithValue("@PageNo", pageNo);
            cmd.Parameters.AddWithValue("@pageSize", 10);

            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
            sqlDataAdapter.SelectCommand = cmd;
            sqlDataAdapter.Fill(dataSet);
            return dataSet.GetXml();
        }
    }
}

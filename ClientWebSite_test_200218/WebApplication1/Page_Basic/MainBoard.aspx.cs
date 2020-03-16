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
        public DateTime WirteDate { get; set; }
    }

    public partial class MainBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public void GetEmployees()
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            List<MainBoardList> employees = new List<MainBoardList>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetEmployees", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    MainBoardList employee = new MainBoardList();
                    employee.Id = Convert.ToInt32(rdr["Id"]);
                    employee.Category = rdr["FirstName"].ToString();
                    employee.Title = rdr["LastName"].ToString();
                    employee.Name = rdr["Gender"].ToString();    
                    employee.WirteDate = Convert.ToDateTime(rdr["HireDate"]);
                    employees.Add(employee);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(employees));
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Page_Basic
{
    public partial class MainBoardView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /*
        public DataTable Read(string category, int number)
        {
            string query = String.Format("SELECT * FROM mainBoard WHERE category='{0}' AND mainBoardNo={1}", category, number);
            return DB.ExecuteQueryDataTable(query);
        }
        */
    }
}
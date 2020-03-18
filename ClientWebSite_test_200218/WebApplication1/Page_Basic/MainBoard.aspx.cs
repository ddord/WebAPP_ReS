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
                //BindDummyRow();
            }
        }

        private void BindDummyRow()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("RowNum");
            dataTable.Columns.Add("ProductName");
            dataTable.Columns.Add("QuantityPerUnit");
            dataTable.Columns.Add("UnitPrice");
            dataTable.Columns.Add("UnitsInStock");
            dataTable.Rows.Add();
            grvMainBoard.DataSource = dataTable;
            grvMainBoard.DataBind();
        }
    }
}
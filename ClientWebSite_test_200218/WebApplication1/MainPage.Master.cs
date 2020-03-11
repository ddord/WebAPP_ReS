using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace WebApplication1
{
    public partial class MainPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SignOut(object sender, System.EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/Page_Basic/LoginMain.aspx");
        }
    }
}
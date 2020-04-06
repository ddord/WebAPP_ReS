using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace WebApplication1.Service
{
    /// <summary>
    /// Summary description for BoardCommon
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class BoardCommon : System.Web.Services.WebService
    {
        protected BoardBehavior boardBehavior = new BoardBehavior();

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public int InsertUpdateBoardWrite(string userId, string userName, string category, string mainBoardTitle, string mainBoardContent, string statementType)
        {
            int result = -1;
            result =  boardBehavior.insertUpdateBoardWrite(userId, userName, category, mainBoardTitle, mainBoardContent, DateTime.Now, statementType);
            if (result > 0)
            {
                Session["category"] = category;
                Session["boardNo"] = result.ToString();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string SelectBoardView(string userId, string category, string boardNo, string statementType)
        {
            DataTable dt = new DataTable();
            dt = boardBehavior.SelectBoardView(userId, category, boardNo, statementType);

            if (dt != null)
                return JsonConvert.SerializeObject(dt);
            else
                return "[]";
        }
    }
}

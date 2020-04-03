using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebModel
{
    public class BoardUserInfo
    {
        public string boardNo { get; set; }
        public string userID { get; set; }
        public string userName { get; set; }
        public string category { get; set; }
        public string mainBoardTitle { get; set; }
        public string mainBoardContent { get; set; }
        public DateTime writeDate { get; set; }
        public string mainBoardPwd { get; set; }
    }
}

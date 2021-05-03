using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region Additional Namespaces
using HTPSSystem.NJack.Entities;
using HTPSSystem.NJack.BLL;
#endregion

namespace BigPrintWebApp.ExercisePages
{

    public partial class Exercise7 : System.Web.UI.Page
    {
        List<string> errormsgs = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Message.DataSource = null;
            Message.DataBind();
        }

        protected void productSearchButton_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(modelNumberSearch.Text))
            {
                errormsgs.Add("Search is empty, please enter a value");
                LoadMessageDisplay(errormsgs, "alert alert-info");
            }

        }

        protected Exception GetInnerException(Exception ex)
        {
            while (ex.InnerException != null)
            {
                ex = ex.InnerException;
            }
            return ex;
        }

        protected void LoadMessageDisplay(List<string> errormsglist, string cssclass)
        {
            Message.CssClass = cssclass;
            Message.DataSource = errormsglist;
            Message.DataBind();
        }
    }
}
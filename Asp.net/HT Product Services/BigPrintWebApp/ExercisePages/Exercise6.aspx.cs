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
    public partial class Exercise6 : System.Web.UI.Page
    {
        List<string> errormsgs = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Message.DataSource = null;
            Message.DataBind();
            ProductName.Text = "";
            ModelNumber.Text = "";
            Discontinued.Checked = false;
            DiscontinuedDate.Text = "";
            if (!Page.IsPostBack)
            {
                BindProductList();
            }
        }

        protected void BindProductList()
        {
            try
            {
                ProductController sysmgr = new ProductController();
                List<Product> info = sysmgr.Product_List();
                info.Sort((x, y) => x.Name.CompareTo(y.Name));
                ProductList.DataSource = info;
                ProductList.DataTextField = nameof(Product.Name);
                ProductList.DataValueField = nameof(Product.ProductID);
                ProductList.DataBind();
                ProductList.Items.Insert(0, "select...");
            }
            catch (Exception ex)
            {
                errormsgs.Add(GetInnerException(ex).ToString());
                LoadMessageDisplay(errormsgs, "alert alert-danger");
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

        protected void ProductSearch_Click(object sender, EventArgs e)
        {
            if (ProductList.SelectedIndex == 0)
            {
                errormsgs.Add("Select a product to view it's information");
                LoadMessageDisplay(errormsgs, "alert alert-info");
                RegistrationList.DataSource = null;
                RegistrationList.DataBind();
            }
            else
            {
                try
                {
                    RegistrationList.DataSource = null;
                    RegistrationList.DataBind();
                    ProductController sysmgrProduct = new ProductController();
                    Product productInfo = sysmgrProduct.Product_Find(int.Parse(ProductList.SelectedValue));
                    ProductName.Text = productInfo.ProductID.ToString();
                    ModelNumber.Text = productInfo.ModelNumber.ToString();
                    Discontinued.Checked = productInfo.Discontinued;
                    if (productInfo.DiscontinuedDate.HasValue)
                    {
                        string preDateString = productInfo.DiscontinuedDate.ToString();
                        DateTime preDateDateTime = DateTime.Parse(preDateString);
                        string month = preDateDateTime.ToString("MMM");
                        string day = preDateDateTime.Day.ToString();
                        string year = preDateDateTime.Year.ToString();

                        DiscontinuedDate.Text = $"{month}, {day}, {year}";
                    }
                    else
                    {
                        DiscontinuedDate.Text = "";
                    }

                    RegistrationController sysmgrRegistration = new RegistrationController();
                    List<Registration> registrationInfo = sysmgrRegistration.Registration_GetByProduct(int.Parse(ProductList.SelectedValue));
                    if (registrationInfo.Any())
                    {
                        RegistrationList.DataSource = registrationInfo;
                        RegistrationList.DataBind();
                    }
                    else
                    {

                    }

                }
                catch (Exception ex)
                {
                    errormsgs.Add(GetInnerException(ex).ToString());
                    LoadMessageDisplay(errormsgs, "alert alert-danger");
                }
            }
        }

        protected void RegistationList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            RegistrationList.PageIndex = e.NewPageIndex;

            ProductSearch_Click(sender, new EventArgs());
        }
    }
}
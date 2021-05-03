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
    public partial class Exercise8 : System.Web.UI.Page
    {
        List<string> errormsgs = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Message.DataSource = null;
            Message.DataBind();
            if (!Page.IsPostBack)
            {
                BindProductList();
                emailDropDownView.Items.Insert(0, new ListItem("Select...", ""));
                emailDropdown.Items.Insert(0, new ListItem("Select...", ""));
                string currentDate = DateTime.Today.ToShortDateString();
                DateValidator.ValueToCompare = currentDate;
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

        protected void BindProductList()
        {
            try
            {
                ProductController productDDLoad = new ProductController();
                List<Product> productDropdownInfo = productDDLoad.Product_List();
                productDropdownInfo.Sort((x, y) => x.Name.CompareTo(y.Name));
                productDropDown.DataSource = productDropdownInfo;
                productDropDown.DataTextField = nameof(Product.Name);
                productDropDown.DataValueField = nameof(Product.ProductID);
                productDropDown.Items.Insert(0, new ListItem("Select...", ""));
                productDropDown.DataBind();
            }
            catch (Exception ex)
            {
                errormsgs.Add(GetInnerException(ex).ToString());
                LoadMessageDisplay(errormsgs, "alert alert-danger");
            }
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            productDropDown.SelectedIndex = 0;
            emailDropdown.SelectedIndex = 0;
            emailDropDownView.SelectedIndex = 0;
            province.SelectedIndex = 0;
            serialNumber.Text = "";
            dateOfPurchase.Text = "";
            retailer.Text = "";
            regLabel.Text = "";
            crudMessage.Text = "";
            RegistrationGridView.DataSource = null;
            RegistrationGridView.DataBind();

        }

        protected Registration GetFormData()
        {
            Registration item = new Registration();
            item.ProductID = int.Parse(productDropDown.SelectedValue);
            item.CustomerID = int.Parse(emailDropDownView.SelectedValue);
            item.SerialNumber = serialNumber.Text;
            item.DateOfPurchase = DateTime.Parse(dateOfPurchase.Text);
            item.PurchasedFrom = retailer.Text;
            item.PurchaseProvince = province.SelectedValue;
            return item;
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Registration item = GetFormData();
                try
                {
                    RegistrationController registrationManager = new RegistrationController();
                    int newregistrationid = registrationManager.Registration_Add(item);
                    crudMessage.Text = $"Adding registration: {item.RegistrationID} successful!";
                    RegisrationSearch_Click(sender, e);
                }
                catch (Exception ex)
                {
                    errormsgs.Add(GetInnerException(ex).ToString());
                    LoadMessageDisplay(errormsgs, "alert alert-danger");
                }
            }

        }
        protected void RegistrationGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow selectedRow = RegistrationGridView.Rows[RegistrationGridView.SelectedIndex];
                HiddenField controlledPointer = selectedRow.FindControl("RegistrationIDLabel") as HiddenField;
                string hiddenValue = controlledPointer.Value;
                int registrationid = int.Parse(hiddenValue);
                RegistrationController registrationFill = new RegistrationController();
                Registration registrationFillInfo = registrationFill.Registration_Find(registrationid);
                regLabel.Text = registrationFillInfo.RegistrationID.ToString();
                if (registrationFillInfo.ProductID == null)
                {
                    productDropDown.SelectedIndex = 0;
                }
                else
                {
                    string nullableIntValue = registrationFillInfo.ProductID.ToString();
                    productDropDown.SelectedValue = nullableIntValue;
                }
                if (registrationFillInfo.CustomerID == null)
                {
                    emailDropDownView.SelectedValue = "";
                }
                else
                {
                    emailDropDownView.SelectedValue = registrationFillInfo.CustomerID.ToString();
                }
                serialNumber.Text = registrationFillInfo.SerialNumber.ToString();
                dateOfPurchase.Text = registrationFillInfo.DateOfPurchase.ToString("yyyy-MM-dd");
                retailer.Text = registrationFillInfo.PurchasedFrom;
                province.SelectedValue = registrationFillInfo.PurchaseProvince;
            }
            catch (Exception ex)
            {
                errormsgs.Add(GetInnerException(ex).ToString());
                LoadMessageDisplay(errormsgs, "alert alert-danger");
            }
        }

        protected void RegisrationSearch_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrationGridView.DataSource = null;
                RegistrationGridView.DataBind();
                RegistrationController customerSysmgr = new RegistrationController();
                List<Registration> registrationInfo = customerSysmgr.Registration_GetByCustomer(int.Parse(emailDropdown.SelectedValue));
                RegistrationGridView.DataSource = registrationInfo;
                RegistrationGridView.DataBind();

            }
            catch (Exception ex)
            {
                errormsgs.Add(GetInnerException(ex).ToString());
                LoadMessageDisplay(errormsgs, "alert alert-danger");
            }
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (string.IsNullOrEmpty(regLabel.Text))
                {
                    crudMessage.Text = "There is no registration IDs present. You can only update existing registration IDs";
                }
                else
                {
                    Registration item = GetFormData();
                    try
                    {
                        item.RegistrationID = int.Parse(regLabel.Text);
                        RegistrationController registrationSysmgr = new RegistrationController();
                        int rowsaffected = registrationSysmgr.Registration_Update(item);
                        if (rowsaffected > 0)
                        {
                            crudMessage.Text = "Update successful!";
                        }
                        else
                        {
                            crudMessage.Text = "This registration does not exist or cannot be found. Please select another registration.";
                        }
                        emailDropdown.SelectedValue = item.CustomerID.ToString();
                        RegisrationSearch_Click(sender, e);
                    }
                    catch (Exception ex)
                    {
                        errormsgs.Add(GetInnerException(ex).ToString());
                        LoadMessageDisplay(errormsgs, "alert alert-danger");
                    }
                }
            }
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(regLabel.Text))
            {
                crudMessage.Text = "No registration id was found. Please select a registration.";
            }
            else
            {
                try
                {
                    RegistrationController registrationSysmgr = new RegistrationController();
                    int rowsaffected = registrationSysmgr.Registration_Delete(int.Parse(regLabel.Text));
                    if (rowsaffected > 0)
                    {
                        crudMessage.Text = "Delete successful";
                        regLabel.Text = "";
                    }
                    else
                    {
                        crudMessage.Text = "Registration cannot be found, please select another registration";
                    }
                    RegisrationSearch_Click(sender, e);
                }
                catch (Exception ex)
                {
                    errormsgs.Add(GetInnerException(ex).ToString());
                    LoadMessageDisplay(errormsgs, "alert alert-danger");
                }
            }
        }
    }
}
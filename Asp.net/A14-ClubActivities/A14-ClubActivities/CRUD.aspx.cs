using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region
using starTEDSystem.Entities;
using starTEDSystem.BLL;
#endregion

namespace A14_ClubActivities
{
    public partial class CRUD : System.Web.UI.Page
    {
        List<string> errormsgs = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Message.DataSource = null;
            Message.DataBind();
            if (!Page.IsPostBack)
            {
                queryStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                string currentDate = DateTime.Today.ToShortDateString();
                DateValidator.ValueToCompare = currentDate;
                campusVenue.Items.Insert(0, new ListItem("Select..."));
                clubID.Items.Insert(0, new ListItem("Select..."));
                queryClubDropDown.Items.Insert(0, new ListItem("Select..."));
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

        protected void ActivitySearch_Click(object sender, EventArgs e)
        {
            if(queryClubDropDown.SelectedIndex == 0)
            {
                errormsgs.Add("Please select a club");
                LoadMessageDisplay(errormsgs, "alert alert-info");
            }
            else
            {
                if (string.IsNullOrEmpty(queryStartDate.Text))
                {
                    errormsgs.Add("Please enter a date");
                    LoadMessageDisplay(errormsgs, "alert alert-info");
                }
                else
                {
                    try
                    {
                        activitiesGridView.DataSource = null;
                        activitiesGridView.DataBind();
                        ClubActivityController caSysmgr = new ClubActivityController();
                        List<ClubActivity> caInfo = caSysmgr.ClubActivities_FindByClubAndDate(queryClubDropDown.SelectedValue, DateTime.Parse(queryStartDate.Text));
                        activitiesGridView.DataSource = caInfo;
                        activitiesGridView.DataBind();
                    }
                    catch (Exception ex)
                    {
                        errormsgs.Add(GetInnerException(ex).ToString());
                        LoadMessageDisplay(errormsgs, "alert alert-danger");
                    }
                }
            }

        }

        protected void activitiesGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            activitiesGridView.PageIndex = e.NewPageIndex;
            ActivitySearch_Click(sender, new EventArgs());
        }

        protected void activitiesGridview_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow selectedRow = activitiesGridView.Rows[activitiesGridView.SelectedIndex];
                HiddenField controlledPointer = selectedRow.FindControl("hiddenClubActivity") as HiddenField;
                string hiddenValue = controlledPointer.Value;
                int activityid = int.Parse(hiddenValue);
                ClubActivityController activityFill = new ClubActivityController();
                ClubActivity activityInfo = activityFill.ClubActivity_Find(activityid);
                activityID.Text = activityInfo.ActivityID.ToString();
                clubID.SelectedValue = activityInfo.ClubID;
                activityName.Text = activityInfo.Name;
                if (string.IsNullOrEmpty(activityInfo.Description))
                {
                    description.Text = "";
                }   
                else
                {
                    description.Text = activityInfo.Description;
                }
                string tempDateString = activityInfo.StartDate.ToString();
                DateTime tempDate = DateTime.Parse(tempDateString);
                startDate.Text = tempDate.ToString("yyyy-MM-dd");
                if (string.IsNullOrEmpty(activityInfo.Location))
                {
                    location.Text = "";
                }
                else
                {
                    location.Text = activityInfo.Location;
                }
                offCampus.Checked = activityInfo.OffCampus;
                if(activityInfo.CampusVenueID == null)
                {
                    campusVenue.SelectedIndex = 0;
                }
                else
                {
                    campusVenue.SelectedValue = activityInfo.CampusVenueID.ToString();
                }
            }
            catch (Exception ex)
            {
                errormsgs.Add(GetInnerException(ex).ToString());
                LoadMessageDisplay(errormsgs, "alert alert-danger");
            }
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            queryClubDropDown.SelectedIndex = 0;
            queryStartDate.Text = "";
            activitiesGridView.DataSource = null;
            activitiesGridView.DataBind();
            activityID.Text = "";
            clubID.SelectedIndex = 0;
            activityName.Text = "";
            description.Text = "";
            startDate.Text = "";
            location.Text = "";
            CRUDMessage.Text = "";
            offCampus.Checked = false;
            campusVenue.SelectedIndex = 0;
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                CRUDMessage.Text = "";
                if (clubID.SelectedIndex == 0)
                {
                    errormsgs.Add("There is no club present. Please select a club.");
                    LoadMessageDisplay(errormsgs, "alert alert-info");
                }
                else
                {
                    ClubActivity item = GetFormData();
                    if (OffCampusValidation(item))
                    {
                        try
                        {
                            ClubActivityController activityManager = new ClubActivityController();
                            int newactivityid = activityManager.Activity_Add(item);
                            CRUDMessage.Text = $"Activity: {item.ActivityID} added";
                            ActivitySearch_Click(sender, e);
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

        protected bool OffCampusValidation(ClubActivity item)
        {
            if(item.OffCampus == true)
            {
                if(item.Location == null)
                {
                    errormsgs.Add("This event is marked as off campus. If it is off campus, a location must be provided.");
                    LoadMessageDisplay(errormsgs, "alert alert-info");
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                if (item.CampusVenueID == null)
                {
                    errormsgs.Add("This event is marked as on campus. Please select a campus venue.");
                    LoadMessageDisplay(errormsgs, "alert alert-info");
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        protected ClubActivity GetFormData()
        {
            ClubActivity item = new ClubActivity();
            item.ClubID = clubID.SelectedValue;
            item.Name = activityName.Text;
            if (string.IsNullOrEmpty(description.Text))
            {
                item.Description = null;
            }
            else
            {
                item.Description = description.Text;
            }

            if (startDate.Text == "")
            {
                string currentDate = DateTime.Today.ToShortDateString();
                item.StartDate = DateTime.Parse(currentDate);
            }
            else
            {
                string currentDate = startDate.Text;
                item.StartDate = DateTime.Parse(currentDate);
            }
            
            if (string.IsNullOrEmpty(location.Text))
            {
                item.Location = null;
            }
            else
            {
                item.Location = location.Text;
            }
            item.OffCampus = offCampus.Checked;

            if(campusVenue.SelectedIndex == 0)
            {
                item.CampusVenueID = null;
            }
            else
            {
                item.CampusVenueID = int.Parse(campusVenue.SelectedValue);
            }
           
            return item;
        }

        protected bool DateCheck(string activityid)
        {
            ClubActivityController dateSysmgr = new ClubActivityController();
            ClubActivity clubDate = dateSysmgr.ClubActivity_Find(int.Parse(activityid));
            if(clubDate.StartDate < DateTime.Today)
            {
                errormsgs.Add("The date of this activity ID is in the past. It cannot be updated or deleted.");
                LoadMessageDisplay(errormsgs, "alert alert-info");
                return false;
            }
            else
            {
                return true;
            }
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                CRUDMessage.Text = "";
                if (clubID.SelectedIndex == 0)
                {
                    errormsgs.Add("There is no club present. Please select a club.");
                    LoadMessageDisplay(errormsgs, "alert alert-info");
                }
                else
                {
                    if (DateCheck(activityID.Text))
                    {
                        ClubActivity item = GetFormData();
                        if (OffCampusValidation(item))
                        {
                            try
                            {
                                item.ActivityID = int.Parse(activityID.Text);
                                ClubActivityController activityManager = new ClubActivityController();
                                int rowsaffected = activityManager.Activity_Update(item);
                                if (rowsaffected > 0)
                                {
                                    CRUDMessage.Text = "Update successful!";
                                }
                                else
                                {
                                    CRUDMessage.Text = "This activity id cannot be found. Please select another activity id to update.";
                                }
                            }
                            catch (Exception ex)
                            {
                                errormsgs.Add(GetInnerException(ex).ToString());
                                LoadMessageDisplay(errormsgs, "alert alert-danger");
                            }
                            ActivitySearch_Click(sender, e);
                        }
                    }
                    else
                    {
                        CRUDMessage.Text = "";
                    }
                }
            }
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            CRUDMessage.Text = "";

            if (string.IsNullOrEmpty(activityID.Text))
            {
                CRUDMessage.Text = "No activity ID found. Select another activity.";
            }
            else
            {
                if (DateCheck(activityID.Text))
                {
                    try
                    {
                        ClubActivityController activityManager = new ClubActivityController();
                        int rowsaffected = activityManager.Activity_Delete(int.Parse(activityID.Text));
                        if (rowsaffected > 0)
                        {
                            CRUDMessage.Text = "Activity deleted";
                            activityID.Text = "";
                        }
                        else
                        {
                            CRUDMessage.Text = "The activity cannot be found. Select another activity";
                        }
                        ActivitySearch_Click(sender, e);
                    }
                    catch (Exception ex)
                    {
                        errormsgs.Add(GetInnerException(ex).ToString());
                        LoadMessageDisplay(errormsgs, "alert alert-danger");
                    }
                }
                else
                {
                    CRUDMessage.Text = "";
                }
            }
        }
    }
}
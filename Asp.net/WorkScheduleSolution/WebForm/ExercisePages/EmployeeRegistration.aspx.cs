using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region Additional Namespaces
using WorkScheduleSystem.BLL;
using WorkScheduleSystem.ViewModels;
#endregion

namespace WebForm.ExercisePages
{
    public partial class EmployeeRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            FirstName.Text = "";
            LastName.Text = "";
            Phone.Text = "";
            foreach (GridViewRow row in SkillItemGridView.Rows) 
            {
                CheckBox chkrow = (CheckBox)row.FindControl("SkillCheckbox");
                if (chkrow.Checked)
                {
                    chkrow.Checked = false;
                }

                RadioButtonList radioButtonList = (RadioButtonList)row.FindControl("LevelRadioButtonList");
                radioButtonList.ClearSelection();

                TextBox yoeTextBox = (TextBox)row.FindControl("YOE");
                yoeTextBox.Text = "";

                TextBox wageTextBox = (TextBox)row.FindControl("HourlyWage");
                wageTextBox.Text = "";
            }
        }

        protected void Register_Click(object sender, EventArgs e)
        {

            EmployeeItem newEmployee = new EmployeeItem();
            newEmployee.FirstName = FirstName.Text;
            newEmployee.LastName = LastName.Text;
            newEmployee.Phone = Phone.Text;
            bool skillWageBool = true;

            List<SkillSet> skills = new List<SkillSet>();
            foreach (GridViewRow row in SkillItemGridView.Rows)
            {
                CheckBox chkrow = (CheckBox)row.FindControl("SkillCheckbox");
                if (chkrow.Checked && skillWageBool == true)
                {
                    SkillSet skillRow = new SkillSet();

                    HiddenField label = (HiddenField)row.FindControl("SkillIDLabel");
                    skillRow.SkillID = int.Parse(label.Value);

                    RadioButtonList radioButtonList = (RadioButtonList)row.FindControl("LevelRadioButtonList");
                    skillRow.Level = int.Parse(radioButtonList.SelectedValue);

                    TextBox YOEText = (TextBox)row.FindControl("YOE");
                    if (YOEText.Text == "")
                    {
                        skillRow.YOE = 0;
                    }
                    else
                    {
                        skillRow.YOE = int.Parse(YOEText.Text);
                    }

                    TextBox HourlyWage = (TextBox)row.FindControl("HourlyWage");
                    if (HourlyWage.Text == "")
                    {
                        skillWageBool = false;
                    }
                    else 
                    {
                        skillRow.HourlyWage = decimal.Parse(HourlyWage.Text);
                    }

                    skills.Add(skillRow);
                }
            }
            if (skillWageBool == true)
            {
                MessageUserControl.TryRun(() =>
                {
                    EmployeeSkillController registerEmployee = new EmployeeSkillController();
                    registerEmployee.Register_Employee(newEmployee, skills);
                }, "Employee Registered", "Employee Added");
            }
            else 
            {
                MessageUserControl.ShowInfo("One of the employeeskills does not have an hourly wage. Hourly wage is required.");
            }

        }
    }
}
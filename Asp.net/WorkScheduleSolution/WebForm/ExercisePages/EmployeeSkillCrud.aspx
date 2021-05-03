<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeSkillCrud.aspx.cs" Inherits="WebForm.ExercisePages.EmployeeSkillCrud" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Employee Skills Crud</h1>
    <br />
    <br />
    <div>
        <div>
            <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
            <asp:ValidationSummary ID="ValidationSummaryEdit" runat="server" 
                 HeaderText="Following are concerns with your data:"
                 ValidationGroup="editgroup"/>
            <asp:ValidationSummary ID="ValidationSummaryInsert" runat="server" 
                 HeaderText="Following are concerns with your data:"
                 ValidationGroup="insertgroup"/>
        </div>
    </div>
    <div>
        <asp:ListView ID="SkillListView" runat="server" DataSourceID="SkillODS" InsertItemPosition="LastItem" DataKeyNames="EmployeeSkillID" OnSelectedIndexChanged="SkillListView_SelectedIndexChanged">
            <AlternatingItemTemplate>
                <tr style="background-color: #FFF8DC;">
                    <td>
                        <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" OnClientClick="return confirm('Are you sure you wish to delete this album')" CssClass="mb-2" />
                        <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" Width="67.63px" />
                    </td>
                    <td>
                        <asp:Label Text='<%# Eval("EmployeeSkillID") %>' runat="server" width="20px" ID="EmployeeSkillIDLabel" /></td>
                    <td>
                        <asp:DropDownList ID="EditEmployeeList" runat="server" Width="250px" DataSourceID="EmployeeDataSource" DataTextField="EmployeeFullName" DataValueField="EmployeeID" SelectedValue='<%# Bind("EmployeeID") %>' Enabled="false"></asp:DropDownList>
                        <asp:ObjectDataSource runat="server" ID="EmployeeDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="EmployeeSkills_GetEmployeeSkillEmployee" TypeName="WorkScheduleSystem.BLL.EmployeeSkillController"></asp:ObjectDataSource>
                    </td>
                    <td>
                        <asp:DropDownList ID="EditSkillList" runat="server" Enabled="false" DataSourceID="EmployeeDataSource" DataTextField="SkillName" DataValueField="SkillID" SelectedValue='<%# Bind("SkillID") %>'></asp:DropDownList>
                    </td>
                    <td>
                        <asp:RadioButtonList runat="server" ID="LevelRadioButtons" Enabled="false" SelectedValue='<%# Bind("Level") %>' Width="130px" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Novice" Value="1">
                                
                            </asp:ListItem>
                            <asp:ListItem Text="Proficient" Value="2">

                            </asp:ListItem>
                            <asp:ListItem Text="Expert" Value="3">

                            </asp:ListItem>
                        </asp:RadioButtonList></td>
                    <td>
                        <asp:Label Text='<%# Eval("YearsOfExperience") %>' runat="server" ID="YearsOfExperienceLabel" /></td>
                    <td>
                        <asp:Label Text='<%# String.Format("{0:0.00}", Eval("HourlyWage")) %>' runat="server" ID="HourlyWageLabel" /></td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <%-- Edit Item Validation --%>
                <asp:RequiredFieldValidator ID="RequiredEmployee" runat="server"
                    ErrorMessage="You must select an Employee."
                    ControlToValidate="EditEmployeeList" Display="None"
                    ValidationGroup="editgroup">
                </asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredSkill" runat="server"
                    ErrorMessage="You must select a Skill."
                    ControlToValidate="EditSkillList" Display="None"
                    ValidationGroup="editgroup">
                </asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredLevel" runat="server"
                    ErrorMessage="You must select a skill level"
                    ControlToValidate="LevelRadioButtons" Display="None"
                    ValidationGroup="editgroup">
                </asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredWage" runat="server"
                    ErrorMessage="An employee must have a wage"
                    ControlToValidate="HourlyWageTextBox" Display="None"
                    ValidationGroup="editgroup">
                </asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareYOE" runat="server"
                    ErrorMessage="Years of experience must be a number." Display="None"
                    ControlToValidate="YearsOfExperienceTextBox"
                    Operator="DataTypeCheck" Type="Integer"
                    ValidationGroup="editgroup">
                </asp:CompareValidator>
                <asp:CompareValidator ID="CompareWage" runat="server"
                    ErrorMessage="Hourly Wage must be a number" Display="None"
                    ControlToValidate="HourlyWageTextBox"
                    Operator="DataTypeCheck" Type="Double"
                    ValidationGroup="editgroup">
                </asp:CompareValidator>
                <tr style="background-color: #008A8C; color: #FFFFFF;">
                    <td>
                        <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" ValidationGroup="editgroup" />
                        <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                    </td>
                    <td>
                        <asp:Label Text='<%# Bind("EmployeeSkillID") %>' runat="server" width="20px" ID="SkillIDTextBox"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="EditEmployeeList" runat="server" Width="250px" DataSourceID="EmployeeDataSource" DataTextField="EmployeeFullName" DataValueField="EmployeeID" SelectedValue='<%# Bind("EmployeeID") %>'></asp:DropDownList>
                        <asp:ObjectDataSource runat="server" ID="EmployeeDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="EmployeeSkills_GetEmployeeSkillEmployee" TypeName="WorkScheduleSystem.BLL.EmployeeSkillController"></asp:ObjectDataSource>
                    </td>
                    <td>
                        <asp:DropDownList ID="EditSkillList" runat="server" DataSourceID="SkillDataSource" DataTextField="Description" DataValueField="SkillID" SelectedValue='<%# Bind("SkillID") %>'></asp:DropDownList>
                        <asp:ObjectDataSource runat="server" ID="SkillDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="Skills_List" TypeName="WorkScheduleSystem.BLL.SkillController"></asp:ObjectDataSource>
                    </td>

                    <td>
                        <asp:RadioButtonList runat="server" ID="LevelRadioButtons" SelectedValue='<%# Bind("Level") %>' RepeatDirection="Horizontal" Width="130px">
                            <asp:ListItem Text="Novice" Value="1">
                                
                            </asp:ListItem>
                            <asp:ListItem Text="Proficient" Value="2">

                            </asp:ListItem>
                            <asp:ListItem Text="Expert" Value="3">

                            </asp:ListItem>
                        </asp:RadioButtonList></td>
                    <td>
                        <asp:TextBox Text='<%# Bind("YearsOfExperience") %>' runat="server" Width="45px" ID="YearsOfExperienceTextBox" /></td>
                    <td>
                        <asp:TextBox Text='<%# Bind("HourlyWage") %>' runat="server" Width="70px" ID="HourlyWageTextBox" /></td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <%-- Edit Item Validation --%>
                <asp:RequiredFieldValidator ID="RequiredEmployee" runat="server"
                    ErrorMessage="You must select an Employee."
                    ControlToValidate="InsertEmployeeList" Display="None"
                    ValidationGroup="insertgroup">
                </asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredSkill" runat="server"
                    ErrorMessage="You must select a Skill."
                    ControlToValidate="InsertSkillList" Display="None"
                    ValidationGroup="insertgroup">
                </asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredLevel" runat="server"
                    ErrorMessage="You must select a skill level"
                    ControlToValidate="LevelRadioButtons" Display="None"
                    ValidationGroup="insertgroup">
                </asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredWage" runat="server"
                    ErrorMessage="An employee must have a wage"
                    ControlToValidate="HourlyWageTextBox" Display="None"
                    ValidationGroup="insertgroup">
                </asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareYOE" runat="server"
                    ErrorMessage="Years of experience must be a number." Display="None"
                    ControlToValidate="YearsOfExperienceTextBox"
                    Operator="DataTypeCheck" Type="Integer"
                    ValidationGroup="insertgroup">
                </asp:CompareValidator>
                <asp:CompareValidator ID="CompareWage" runat="server"
                    ErrorMessage="Hourly Wage must be a number" Display="None"
                    ControlToValidate="HourlyWageTextBox"
                    Operator="DataTypeCheck" Type="Double"
                    ValidationGroup="insertgroup">
                </asp:CompareValidator>
                <tr style="">
                    <td>
                        <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" ValidationGroup="insertgroup" />
                        <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                    </td>
                    <td>
                        <asp:TextBox Text='<%# Bind("EmployeeSkillID") %>' runat="server" width="40px" ID="EmployeeSkillIDTextBox" Enabled="false" /></td>

                    <td>
                        <asp:DropDownList ID="InsertEmployeeList" runat="server" Width="250px" AppendDataBoundItems="true" DataSourceID="EmployeeDataSource" DataTextField="EmployeeFullName" DataValueField="EmployeeID" SelectedValue='<%# Bind("EmployeeID") %>'>
                            <asp:ListItem Text="Select..." Value="" />
                        </asp:DropDownList>
                        <asp:ObjectDataSource runat="server" ID="EmployeeDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="EmployeeSkills_GetEmployeeSkillEmployee" TypeName="WorkScheduleSystem.BLL.EmployeeSkillController"></asp:ObjectDataSource>
                    </td>
                    <td>
                        <asp:DropDownList ID="InsertSkillList" runat="server" AppendDataBoundItems="true" DataSourceID="SkillDataSource" DataTextField="Description" DataValueField="SkillID" SelectedValue='<%# Bind("SkillID") %>'>
                            <asp:ListItem Text="Select..." Value="" />
                        </asp:DropDownList>
                        <asp:ObjectDataSource runat="server" ID="SkillDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="Skills_List" TypeName="WorkScheduleSystem.BLL.SkillController"></asp:ObjectDataSource>
                    </td>
                    <td>
                        <asp:RadioButtonList runat="server" ID="LevelRadioButtons" SelectedValue='<%# Bind("Level") %>' Width="130px" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Novice" Value="1">
                                
                            </asp:ListItem>
                            <asp:ListItem Text="Proficient" Value="2">

                            </asp:ListItem>
                            <asp:ListItem Text="Expert" Value="3">

                            </asp:ListItem>
                        </asp:RadioButtonList></td>
                    <td align="center">
                        <asp:TextBox Text='<%# Bind("YearsOfExperience") %>' runat="server" width="40px" ID="YearsOfExperienceTextBox" /></td>
                    <td>
                        <asp:TextBox Text='<%# Bind("HourlyWage") %>' Width="70px" runat="server" ID="HourlyWageTextBox" /></td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="background-color: #DCDCDC; color: #000000;">
                    <td>
                        <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" OnClientClick="return confirm('Are you sure you want to delete this Employee Skill?')" />
                        <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" width="67px"/>
                    </td>
                    <td>
                        <asp:Label Text='<%# Eval("EmployeeSkillID") %>' runat="server" ID="EmployeeSkillIDLabel" /></td>

                    <td>
                        <asp:DropDownList ID="EditEmployeeList" runat="server" Width="250px" Enabled="false" DataSourceID="EmployeeDataSource" DataTextField="EmployeeFullName" DataValueField="EmployeeID" SelectedValue='<%# Bind("EmployeeID") %>'></asp:DropDownList>
                        <asp:ObjectDataSource runat="server" ID="EmployeeDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="EmployeeSkills_GetEmployeeSkillEmployee" TypeName="WorkScheduleSystem.BLL.EmployeeSkillController"></asp:ObjectDataSource>
                    </td>
                    <td>
                        <asp:DropDownList ID="EditSkillList" runat="server" Enabled="false" DataSourceID="EmployeeDataSource" DataTextField="SkillName" DataValueField="SkillID" SelectedValue='<%# Bind("SkillID") %>'></asp:DropDownList>
                    </td>
                    <td>
                        <asp:RadioButtonList runat="server" ID="LevelRadioButtons" Enabled="false" SelectedValue='<%# Bind("Level") %>' Width="130px" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Novice" Value="1">
                                
                            </asp:ListItem>
                            <asp:ListItem Text="Proficient" Value="2">

                            </asp:ListItem>
                            <asp:ListItem Text="Expert" Value="3">

                            </asp:ListItem>
                        </asp:RadioButtonList></td>
                    <td>
                        <asp:Label Text='<%# Eval("YearsOfExperience") %>' runat="server" ID="YearsOfExperienceLabel" /></td>
                    <td>
                        <asp:Label Text='<%# String.Format("{0:0.00}", Eval("HourlyWage")) %>' runat="server" ID="HourlyWageLabel" /></td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                <tr runat="server" style="background-color: #DCDCDC; color: #000000;">
                                    <th runat="server"></th>
                                    <th runat="server">ID</th>
                                    <th runat="server">Employee</th>
                                    <th runat="server">Skill</th>
                                    <th runat="server">Level</th>
                                    <th runat="server">YOE</th>
                                    <th runat="server">Hourly Wage</th>
                                </tr>
                                <tr runat="server" id="itemPlaceholder"></tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                            <asp:DataPager runat="server" ID="DataPager1">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                    <asp:NumericPagerField></asp:NumericPagerField>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">
                    <td>
                        <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" OnClientClick="return confirm('Are you sure you wish to delete this album')" />
                        <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                    </td>
                    <td>
                        <asp:Label Text='<%# Eval("EmployeeSkillID") %>' runat="server" ID="EmployeeSkillIDLabel" /></td>

                    <td>
                        <asp:DropDownList ID="EditEmployeeList" runat="server" Width="250px" DataSourceID="EmployeeDataSource" DataTextField="EmployeeFullName" DataValueField="EmployeeID" SelectedValue='<%# Bind("EmployeeID") %>'></asp:DropDownList>
                        <asp:ObjectDataSource runat="server" ID="EmployeeDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="EmployeeSkills_GetEmployeeSkillEmployee" TypeName="WorkScheduleSystem.BLL.EmployeeSkillController"></asp:ObjectDataSource>
                    </td>
                    <td>
                        <asp:DropDownList ID="EditSkillList" runat="server" DataSourceID="EmployeeDataSource" DataTextField="SkillName" DataValueField="SkillID" SelectedValue='<%# Bind("SkillID") %>'></asp:DropDownList>
                    </td>
                    <td>
                        <asp:RadioButtonList runat="server" ID="LevelRadioButtons" SelectedValue='<%# Bind("Level") %>' RepeatDirection="Horizontal">
                            <asp:ListItem Text="Novice" Value="1">
                                
                            </asp:ListItem>
                            <asp:ListItem Text="Proficient" Value="2">

                            </asp:ListItem>
                            <asp:ListItem Text="Expert" Value="3">

                            </asp:ListItem>
                        </asp:RadioButtonList></td>
                    <td>
                        <asp:Label Text='<%# Eval("YearsOfExperience") %>' runat="server" ID="YearsOfExperienceLabel" /></td>
                    <td>
                        <asp:Label Text='<%# String.Format("{0:0.00}", Eval("HourlyWage")) %>' runat="server" ID="HourlyWageLabel" /></td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="SkillODS" runat="server" DataObjectTypeName="WorkScheduleSystem.ViewModels.EmployeeSkillItem" 
            DeleteMethod="EmployeeSkill_Delete" 
            InsertMethod="EmployeeSkill_Add" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="EmployeeSkills_GetEmployeeSkillEmployee" 
            TypeName="WorkScheduleSystem.BLL.EmployeeSkillController" 
            UpdateMethod="EmployeeSkill_Update"
            OnDeleted="DeleteCheckForException"
            OnInserted="InsertCheckForException"
            OnSelected="SelectCheckForException"
            OnUpdated="UpdateCheckForException">
        </asp:ObjectDataSource>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeRegistration.aspx.cs" Inherits="WebForm.ExercisePages.EmployeeRegistration" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Employee Registration</h1> <br />
    <div class="row">
        <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
        <asp:RequiredFieldValidator ID="RequiredFirstName" runat="server" 
                ErrorMessage="The employee must have a first name" Display="None" SetFocusOnError="true"
                 ForeColor="Firebrick" ControlToValidate="FirstName">
        </asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredLastName" runat="server" 
                ErrorMessage="The employee must have a last name" Display="None" SetFocusOnError="true"
                 ForeColor="Firebrick" ControlToValidate="LastName">
        </asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredPhone" runat="server" 
                ErrorMessage="The employee must have a phone number" Display="None" SetFocusOnError="true"
                 ForeColor="Firebrick" ControlToValidate="Phone">
        </asp:RequiredFieldValidator> 
        <asp:RegularExpressionValidator ID="PhoneRegularExpressionValidator" runat="server"
                ErrorMessage="The phone must follow this format: xxx.xxx.xxxx" Display="None" SetFocusOnError="true"
                ControlToValidate="Phone"
                ValidationExpression="^(\d{3})[.](\d{3})[.](\d{4})">
        </asp:RegularExpressionValidator>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                 HeaderText="Fix the following:" CssClass="alert alert-info"/>
    </div>
    <div class="container">
        <div class="row">
            <div>
                <asp:Label runat="server" Text="First Name" ID="FirstNameLabel"></asp:Label> &nbsp; &nbsp;
                <asp:TextBox runat="server" ID="FirstName"></asp:TextBox> <br /> <br />
                <asp:Label runat="server" Text="Last Name" ID="LastNameLabel"></asp:Label> &nbsp; &nbsp;
                <asp:TextBox runat="server" ID="LastName"></asp:TextBox> <br /> <br />
                <asp:Label runat="server" Text="Home Phone" ID="PhoneLabel"></asp:Label>
                <asp:TextBox runat="server" ID="Phone"></asp:TextBox>
            </div>
            <div class="row align-items-end ml-5">
                <asp:Button runat="server" Text="Register" ID="Register" class="btn-primary" OnClick="Register_Click"/> &nbsp; &nbsp;
                <asp:Button runat="server" Text="Clear" ID="Clear" OnClick="Clear_Click" CausesValidation="false" OnClientClick="return confirm('Are you sure you wish to clear the data. Once cleared, the data cannot be recovered.')"/>
            </div>
        </div>
    </div>
    <div>
        <br /><br />
        <asp:GridView ID="SkillItemGridView" runat="server" AutoGenerateColumns="False" DataSourceID="SkillItemDataSource">
            <Columns>
                <asp:TemplateField>
                    <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="SkillCheckbox" />
                        <asp:HiddenField runat="server" ID="SkillIDLabel" Value='<%# Eval("SkillID") %>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Description" HeaderText="Skill" SortExpression="Description"></asp:BoundField>
                <asp:TemplateField HeaderText="Level">
                    <ItemStyle Width="250px" VerticalAlign="Middle"/>
                    <ItemTemplate>
                        <asp:RadioButtonList runat="server" RepeatDirection="Horizontal" ID="LevelRadioButtonList">
                            <asp:ListItem Value="1">Novice&nbsp; &nbsp;</asp:ListItem>
                            <asp:ListItem Value="2">Proficient&nbsp; &nbsp;</asp:ListItem>
                            <asp:ListItem Value="3">Expert</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="YOE">
                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <ItemTemplate>
                        <asp:RangeValidator runat="server" Type="Integer"
                            MinimumValue="0" MaximumValue="50" ControlToValidate="YOE"
                            ErrorMessage="YOE must be a number between 0-50" Display="None">
                        </asp:RangeValidator>
                        <asp:TextBox runat="server" ID="YOE" Width="40px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hourly Wage">
                    <ItemStyle Width="110px" HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <ItemTemplate>
                        <asp:RangeValidator runat="server" Type="Double"
                            MinimumValue="15.00" MaximumValue="100.00" ControlToValidate="HourlyWage"
                            ErrorMessage="Hourly wage must be number between 15.00 and 100.00" Display="None">
                        </asp:RangeValidator>
                        <asp:TextBox runat="server" ID="HourlyWage" Width="100px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource runat="server" ID="SkillItemDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="Skills_List" TypeName="WorkScheduleSystem.BLL.SkillController"></asp:ObjectDataSource>
    </div>
</asp:Content>

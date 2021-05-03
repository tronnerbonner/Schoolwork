<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeSearch.aspx.cs" Inherits="WebForm.ExercisePages.EmployeeSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Search Employees by Employee Skill</h1>
    <div class="row">
        <div class="container">
            <asp:Label ID="SkillDropDownLabel" runat="server">Search By Employee Skill:</asp:Label>&nbsp;&nbsp;
                <asp:DropDownList ID="SkillDropDownList" runat="server" DataSourceID="EmployeeSkill" DataTextField="Description" DataValueField="SkillID"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="EmployeeSkill" OldValuesParameterFormatString="original_{0}"
                SelectMethod="Skills_List" TypeName="WorkScheduleSystem.BLL.SkillController">
            </asp:ObjectDataSource>
            <asp:LinkButton ID="SearchEmployees" runat="server" OnClick="SearchEmployees_Click">Search Employees</asp:LinkButton>
        </div>
        <div class="container">
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="EmployeeBySkill" AllowPaging="True" BorderStyle="None" GridLines="None" CellPadding="6" PageSize="5" CellSpacing="6">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone"></asp:BoundField>
                    <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:TemplateField HeaderText="Skill Level">
                        <ItemTemplate>
                            <asp:Label Text='<%# int.Parse(Eval("SkillLevel").ToString()) == 1 ? "Novice" :
                                    int.Parse(Eval("SkillLevel").ToString()) == 2 ? "Proficient" : "Expert"%>' runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="YOE" HeaderText="YOE" SortExpression="YOE">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    No Results Found
                </EmptyDataTemplate>
                <RowStyle BorderStyle="None" />
            </asp:GridView>
            <asp:ObjectDataSource runat="server" ID="EmployeeBySkill" OldValuesParameterFormatString="original_{0}" SelectMethod="EmployeeSkills_GetEmployeeBySkillID" TypeName="WorkScheduleSystem.BLL.EmployeeSkillController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SkillDropDownList" PropertyName="SelectedValue" Name="skillid" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>

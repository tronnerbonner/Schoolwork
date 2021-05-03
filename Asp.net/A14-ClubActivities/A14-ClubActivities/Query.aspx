<%@ Page Title="ODS - StarTED" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Query.aspx.cs" Inherits="A14_ClubActivities.Query" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>A14 - Club Activities: GridView</h1>
    </div>
    <asp:DataList ID="Message" runat="server" Enabled="false">
        <ItemTemplate>
            <%# Container.DataItem %>
        </ItemTemplate>
    </asp:DataList>

    <div class="row">
        <div>
            <asp:Label runat="server" ID="queryClubLabel" Text="Clubs"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList runat="server" ID="queryClubDropDown" DataSourceID="clubDropDownDataSource" DataTextField="ClubName" DataValueField="ClubID" Width="500px" ></asp:DropDownList>
            <asp:ObjectDataSource ID="clubDropDownDataSource" runat="server" SelectMethod="Club_List" TypeName="starTEDSystem.BLL.ClubController"></asp:ObjectDataSource>&nbsp;&nbsp;
            <asp:Button runat="server" ID="ActivitySearch" CssClass="btn btn-primary" Text="Activities?" OnClick="ActivitySearch_Click" />
        </div>
    </div>
    <br />
    <br />
   <div class="row">
       <div>
           <asp:Label ID="gridLabel" runat="server" Text="Activities"></asp:Label>&nbsp&nbsp;
       </div>
       <div>
    <asp:GridView ID="activitiesGridView" runat="server" AutoGenerateColumns="False"
        AllowPaging="True" 
        DataSourceID="gridViewDataSource">
        <Columns>
            <asp:TemplateField HeaderText="Activity ID">
                <ItemTemplate>
                    <asp:Label ID="gridActivityIDLabel" runat="server" 
                        Text='<%# Eval("ActivityID") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Activity">
                <ItemTemplate>
                    <asp:Label ID="gridActivityLabel" runat="server" 
                        Text='<%# Eval("Name") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" />
            </asp:TemplateField>
                        <asp:TemplateField HeaderText="ClubID">
                <ItemTemplate>
                    <asp:DropDownList ID="gridClubDropdown" runat="server" DataSourceID="gridClubDropDownSource" DataTextField="ClubName" DataValueField="ClubID" SelectedValue='<%# Eval("ClubID") %>'></asp:DropDownList>  
                    <asp:ObjectDataSource ID="gridClubDropDownSource" runat="server" SelectMethod="Club_List" TypeName="starTEDSystem.BLL.ClubController"></asp:ObjectDataSource>
                </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                <ItemTemplate>
                    <asp:Label ID="gridDescriptionLabel" runat="server" 
                        Text='<%# Eval("Description") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
                        <asp:TemplateField HeaderText="Location">
                <ItemTemplate>
                    <asp:Label ID="gridLocationLabel" runat="server" 
                        Text='<%# Eval("Location") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
                        <asp:TemplateField HeaderText="Off Campus">
                <ItemTemplate>
                    <asp:CheckBox ID="offCampusCheck" Checked='<%# Eval("OffCampus") %>' runat="server" /> 
                </ItemTemplate>

<ItemStyle Width="100px" HorizontalAlign="Center"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                    <asp:Label ID="gridDateLabel" runat="server"
                    Text='<%# string.Format("{0:MMM dd, yyyy}", Eval("StartDate")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            No Activities Found
        </EmptyDataTemplate>
        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Back" />
    </asp:GridView>
           <asp:ObjectDataSource ID="gridViewDataSource" runat="server" SelectMethod="ClubActivities_FindByClub" TypeName="starTEDSystem.BLL.ClubActivityController">
               <SelectParameters>
                   <asp:ControlParameter ControlID="queryClubDropDown" DefaultValue="139056" Name="clubid" PropertyName="SelectedValue" Type="String" />
               </SelectParameters>
           </asp:ObjectDataSource>
       </div>
   </div>
</asp:Content>

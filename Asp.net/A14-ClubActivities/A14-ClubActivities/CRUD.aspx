<%@ Page Title="CRUD - StarTED" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CRUD.aspx.cs" Inherits="A14_ClubActivities.CRUD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>A14 - Club Activities: CRUD Page</h1>
    </div>
    <asp:DataList ID="Message" runat="server" Enabled="false">
        <ItemTemplate>
            <%# Container.DataItem %>
        </ItemTemplate>
    </asp:DataList>

    <div class="row">
        <div class="col-4">
            <asp:Label runat="server" ID="queryClubLabel" Text="Clubs"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList runat="server" ID="queryClubDropDown" DataSourceID="clubDropDownDataSource" DataTextField="ClubName" DataValueField="ClubID" Width="500px" AppendDataBoundItems="true"></asp:DropDownList>
            <asp:ObjectDataSource ID="clubDropDownDataSource" runat="server" SelectMethod="Club_List" TypeName="starTEDSystem.BLL.ClubController"></asp:ObjectDataSource>
        </div>
    </div>
    <div class="row">
        <div class="col-4">
            <br />
            <asp:Label runat="server" ID="queryDateLabel" Text="Start Date"></asp:Label>&nbsp;
            <asp:TextBox ID="queryStartDate" runat="server" TextMode="Date"></asp:TextBox>
        </div>
        <div class="col-3">
            <asp:Button runat="server" ID="ActivitySearch" CssClass="btn btn-primary" Text="Activities?" OnClick="ActivitySearch_Click" CausesValidation="false" />
        </div>
    </div>
    <br />
    <br />
   <div class="row col-9">
       <div>
           <asp:Label ID="gridLabel" runat="server" Text="Activities"></asp:Label>
       </div>
       <div class="col-9">
    <asp:GridView ID="activitiesGridView" runat="server" AutoGenerateColumns="False"
        AllowPaging="true" PageSize="5" 
        OnPageIndexChanging="activitiesGridView_PageIndexChanging" OnSelectedIndexChanged="activitiesGridview_SelectedIndexChanged">
        <Columns>
            <asp:CommandField CausesValidation="False" SelectText="Select" 
                        ShowSelectButton="True" ButtonType="Link"></asp:CommandField>
            <asp:TemplateField HeaderText="Activity" ItemStyle-Width="300">
                <ItemTemplate>
                    <asp:HiddenField ID="hiddenClubActivity" runat="server" 
                        Value='<%# Eval("ActivityID") %>'/>
                    <asp:Label ID="gridActivityLabel" runat="server" 
                        Text='<%# Eval("Name") %>'></asp:Label>
                </ItemTemplate>

<ItemStyle Width="300px"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date" ItemStyle-Width="120">
                <ItemTemplate>
                    <asp:Label ID="gridDateLabel" runat="server"
                    Text='<%# string.Format("{0:MMM dd, yyyy}", Eval("StartDate")) %>'></asp:Label>
                </ItemTemplate>

<ItemStyle Width="120px"></ItemStyle>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            No Activities Found
        </EmptyDataTemplate>
        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Back" />
    </asp:GridView>
       </div>
   </div>
    <br />
    <br />
    <div class="row">
        <asp:RequiredFieldValidator ID="RequiredClub" runat="server"
            ErrorMessage="A club must be selected."
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="clubID"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredName" runat="server"
            ErrorMessage="An activity must have a name"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="activityName"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="DateValidator" runat="server"
            ErrorMessage="The date selected must be today or a future date. Past activities cannot be created, updated, or deleted."
            Type="Date" Operator="GreaterThanEqual"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="startDate"></asp:CompareValidator>
        <asp:ValidationSummary runat="server" ID="ValidationSummary" />
    </div>
    <div class="row">
        <div class="col-6">
            <table>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="activityIDLabel" Text="Activity ID:"></asp:Label>&nbsp;&nbsp;              
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:Label runat="server" ID="activityID"></asp:Label>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="clubLabel" Text="Club:"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="clubID" runat="server" DataSourceID="clubTableDropdown" DataTextField="ClubName" DataValueField="ClubID" AppendDataBoundItems="true"></asp:DropDownList>
                        <asp:ObjectDataSource ID="clubTableDropdown" runat="server" SelectMethod="Club_List" TypeName="starTEDSystem.BLL.ClubController"></asp:ObjectDataSource>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="nameLabel" Text="Activity Name:"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="activityName" runat="server" MaxLength="100"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="descriptionLabel" Text="Description:"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="description" runat="server" MaxLength="250"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="dateLabel" Text="Start Date:"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="startDate" runat="server" TextMode="Date"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="locationLabel" Text="Location:"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="location" runat="server" MaxLength="50"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="campusID" Text="Off Campus:"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:CheckBox ID="offCampus" runat="server" />
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label runat="server" ID="venueLabel" Text="Campus Venues:"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="campusVenue" runat="server" DataSourceID="venueDataSource" DataTextField="Location" DataValueField="CampusVenueID" AppendDataBoundItems="true"></asp:DropDownList>
                        <asp:ObjectDataSource ID="venueDataSource" runat="server" SelectMethod="CampusVenue_List" TypeName="starTEDSystem.BLL.CampusVenueController"></asp:ObjectDataSource>
                        <br />
                        <br />
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <asp:Button ID="Add" runat="server" Text="Add" OnClick="Add_Click"/>&nbsp&nbsp
            <asp:Button ID="Update" runat="server" Text="Update" OnClick="Update_Click"/>&nbsp&nbsp
            <asp:Button ID="Delete" runat="server" Text="Delete" OnClick="Delete_Click" CausesValidation="false"/>&nbsp&nbsp
            <asp:Button ID="Clear" runat="server" Text="Clear" OnClick="Clear_Click" CausesValidation="false"/>
        </div>
        <asp:Label ID="CRUDMessage" runat="server"></asp:Label>
    </div>
</asp:Content>

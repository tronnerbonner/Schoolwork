<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Exercise9.aspx.cs" Inherits="BigPrintWebApp.ExercisePages.Exercise8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h1>Exercise 9</h1>
    </div>
    <asp:DataList ID="Message" runat="server" Enabled="False">
        <ItemTemplate>
            <%# Container.DataItem %>
        </ItemTemplate>
    </asp:DataList>
        <div class="row">
        <div class="col-6">
            <asp:Label runat="server" ID="EmailSelectLabel">Enter Customer Email</asp:Label>&nbsp;&nbsp;

            <asp:DropDownList ID="emailDropdown" runat="server" DataSourceID="emailDataSource" DataTextField="Email" DataValueField="CustomerID" AppendDataBoundItems="true"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="emailDataSource" SelectMethod="Customer_List" TypeName="HTPSSystem.NJack.BLL.CustomerController"></asp:ObjectDataSource>&nbsp;&nbsp;
            <asp:Button ID="RegisrationSearch" runat="server" class="btn btn-primary" Text="Regs ?" OnClick="RegisrationSearch_Click" CausesValidation="false"/>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-3">
            <asp:Label runat="server" ID="CustomerGridLabel">Customer Registrations</asp:Label>
        </div>
        <div class="col-md-6">
            <asp:GridView ID="RegistrationGridView" runat="server" AutoGenerateColumns="false" OnSelectedIndexChanged="RegistrationGridView_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField HeaderText="Product">
                        <ItemTemplate>
                            <asp:HiddenField ID="RegistrationIDLabel" runat="server" 
                                 Value='<%# Eval("RegistrationID") %>'/>
                            <asp:DropDownList ID="productDropDownGrid" runat="server" Enabled="false" DataSourceID="productNameDataSource" DataTextField="Name" DataValueField="ProductID" SelectedValue='<%# Eval("ProductID") %>'></asp:DropDownList>
                            <asp:ObjectDataSource ID="productNameDataSource" runat="server" SelectMethod="Product_List" TypeName="HTPSSystem.NJack.BLL.ProductController"></asp:ObjectDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="regDateLabel" runat="server"
                                Text='<%# string.Format("{0:MMM dd, yyyy}", Eval("DateOfPurchase")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField CausesValidation="False" SelectText="Select" 
                        ShowSelectButton="True" ButtonType="Link"></asp:CommandField>
                </Columns>
                <EmptyDataTemplate>
                    No registrations found
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    <br />
    <br />
    <div class="row">
        <asp:RequiredFieldValidator ID="RequiredProductName" runat="server"
            ErrorMessage="You must select a product"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="productDropDown"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredEmail" runat="server"
            ErrorMessage="You must select an email"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="emailDropDownView"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredSerialNumber" runat="server"
            ErrorMessage="You must enter a serial number"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="serialNumber"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredDate" runat="server"
            ErrorMessage="You must enter a date"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="dateOfPurchase"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="SerialNumberValidator" runat="server"
            ErrorMessage="Serial number must be like AAANNNA-AA"
            ValidationExpression="([A-Z]){3}(\d){3}([A-Z])-([A-Z]){2}"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="serialNumber">
        </asp:RegularExpressionValidator>
        <asp:CompareValidator ID="DateValidator" runat="server"
            ErrorMessage="The date selected cannot be after today's date."
            Type="Date" Operator="LessThanEqual"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="dateOfPurchase"></asp:CompareValidator>
        <asp:RequiredFieldValidator ID="RequiredRetailer" runat="server"
            ErrorMessage="You must enter a retailer"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="retailer"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredProvince" runat="server"
            ErrorMessage="You must select a province"
            Display="None" SetFocusOnError="true" ForeColor="Firebrick"
            ControlToValidate="province"></asp:RequiredFieldValidator>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    </div>
    <div class="row">
        <div class="col-6">
            <table>
                <tr>
                    <td align="right">
                        <asp:Label ID="labelforRegLabel" runat="server" Text="Registration ID"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:Label ID="regLabel" runat="server" Text=""></asp:Label>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="productLabel" runat="server" Text="Product"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="productDropDown" AppendDataBoundItems="true" runat="server">
                        </asp:DropDownList>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="emailLabel" runat="server" Text="Email"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="emailDropDownView" runat="server" AppendDataBoundItems="true" DataSourceID="secondaryEmailDataSource" DataTextField="Email" DataValueField="CustomerID"></asp:DropDownList>
                        <asp:ObjectDataSource ID="secondaryEmailDataSource" runat="server" SelectMethod="Customer_List" TypeName="HTPSSystem.NJack.BLL.CustomerController"></asp:ObjectDataSource>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="snLabel" runat="server" Text="Serial Number"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="serialNumber" runat="server"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="dopLabel" runat="server" Text="Date of Purchase"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />  
                    <td align="left">
                        <asp:TextBox ID="dateOfPurchase" runat="server" TextMode="Date"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="retailerLabel" runat="server" Text="Retailer"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="retailer" runat="server"></asp:TextBox>
                        <br />
                        <br />
                    </td>                    
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="provinceLabel" runat="server" Text="Province"></asp:Label>&nbsp;&nbsp;
                        <br />
                        <br />
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="province" runat="server">
                            <asp:ListItem Value="">Select...</asp:ListItem>
                            <asp:ListItem Value="AB">Alberta</asp:ListItem>
                            <asp:ListItem Value="BC">British Columbia</asp:ListItem>
                            <asp:ListItem Value="MB">Manitoba</asp:ListItem>
                            <asp:ListItem Value="NB">New Brunswick</asp:ListItem>
                            <asp:ListItem Value="NL">Newfoundland</asp:ListItem>
                            <asp:ListItem Value="NT">Northwest Territories</asp:ListItem>
                            <asp:ListItem Value="NU">Nunavut</asp:ListItem>
                            <asp:ListItem Value="NS">Nova Scotia</asp:ListItem>
                            <asp:ListItem Value="ON">Ontario</asp:ListItem>
                            <asp:ListItem Value="PE">Prince Edward Island</asp:ListItem>
                            <asp:ListItem Value="QC">Quebec</asp:ListItem>
                            <asp:ListItem Value="SK">Saskatchewan</asp:ListItem>
                            <asp:ListItem Value="YT">Yukon</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                    </td>
                </tr>
            </table>                                             
            <br />
            <br />
            <asp:Button ID="Add" runat="server" Text="Add" OnClick="Add_Click" />&nbsp&nbsp
            <asp:Button ID="Update" runat="server" Text="Update" OnClick="Update_Click" />&nbsp&nbsp
            <asp:Button ID="Delete" runat="server" Text="Delete" OnClick="Delete_Click" OnClientClick="return DeleteVerify();" CausesValidation="false"/>&nbsp&nbsp
            <asp:Button ID="Clear" runat="server" Text="Clear" OnClick="Clear_Click" CausesValidation="false" />
        </div>
        <asp:Label runat="server" ID="crudMessage"></asp:Label>
    </div>
    <script type="text/javascript">
        function DeleteVerify() {
            if (confirm("Do you want to delete this registration?")) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
</asp:Content>

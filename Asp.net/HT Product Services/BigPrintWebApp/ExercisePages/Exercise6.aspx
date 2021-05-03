<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Exercise6.aspx.cs" Inherits="BigPrintWebApp.ExercisePages.Exercise6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div>
            <h1>HT Product Services Exercises: Product Registrations</h1>
        </div>
        <div>
            <blockquote class="col-md-12 alert alert-info"><b>About:</b> this page will demonstrate a multiple record query display to a GridView using code behind without using ObjectDataSource controls.
                The page will demonstrate customization of the GridView covering templates, column selection, column headers, caption (with Bootrwap formatting),
                dataset member referencing(Eval("")) and paging. The page will demonstrate the implementation of the paging event PageIndexChanging()</blockquote>
        </div>
        <asp:DataList ID="Message" runat="server" Enabled="False">
        <ItemTemplate>
            <%# Container.DataItem %>
        </ItemTemplate>
    </asp:DataList>
        <div class="row">
            <div class="col-md-7">
                <asp:Label ID="ProductsLabel" runat="server" Text="Products:"></asp:Label>
                &nbsp;&nbsp;
                <asp:DropDownList ID="ProductList" runat="server">
                </asp:DropDownList>
                &nbsp;&nbsp;
                <asp:LinkButton ID="ProductSearch" runat="server" OnClick="ProductSearch_Click">Search</asp:LinkButton>
                <br />
                <br />
                <table class="col-md-10">
                    <legend>Products:</legend>
                    <tr>
                        <td align="right">
                            <asp:Label ID="ProductNameLabel" runat="server" Font-Bold="true" Text="Product:"></asp:Label>&nbsp;&nbsp;&nbsp;   
                            <br />
                            <br />
                        </td>
                        <td align="left">
                            <asp:Label ID="ProductName" runat="server"></asp:Label>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="ModelNumberLabel" runat="server" Font-Bold="true" Text="Model Number:"></asp:Label>&nbsp;&nbsp;&nbsp;
                            <br />
                            <br />
                        </td>
                        <td align="left">
                            <asp:Label ID="ModelNumber" runat="server"></asp:Label>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="DiscontinuedLabel" runat="server" Font-Bold="true" Text="Discontinued:"></asp:Label>&nbsp;&nbsp;&nbsp;
                            <br />
                            <br />
                        </td>
                        <td align="left">
                            <asp:CheckBox id="Discontinued" runat="server" AutoPostBack="false"
                                Text="&nbsp;&nbsp;&nbsp;(discontinued if checked)" TextAlign="Right" />
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="DiscontinuedDateLabel" runat="server" Font-Bold="true" Text="Discontinued Date:"></asp:Label>&nbsp;&nbsp;&nbsp;
                            <br />
                            <br />
                        </td>
                        <td align="left">
                            <asp:Label ID="DiscontinuedDate" runat="server"></asp:Label>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <div class="col-md-9">
                    <legend>Registration:</legend>
                    <asp:GridView ID="RegistrationList" runat="server"
                    GridLines="Both" AutoGenerateColumns="false"
                    AllowPaging="true" PageSize="5" OnPageIndexChanging="RegistationList_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Serial Number">
                            <ItemTemplate>
                               <div style="width:175px">
                                   <asp:Label ID="SerialNumberLabel" runat="server" 
                                Text='<%# Eval("SerialNumber") %>'></asp:Label>
                               </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                               <div style="width:175px">
                                   <asp:Label ID="DateLabel" runat="server" 
                                Text='<%# string.Format("{0:MMM dd, yyyy}",Eval("DateOfPurchase"))%>'></asp:Label>
                               </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Source">
                            <ItemTemplate>
                               <div style="width:320px">
                                   <asp:Label ID="PurchasedFromLabel" runat="server" 
                                Text='<%# Eval("PurchasedFrom") %>'></asp:Label>
                               </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Province">
                            <ItemTemplate>
                               <div style="width:100px">
                                   <asp:Label ID="ProvinceLabel" runat="server" 
                                Text='<%# Eval("PurchaseProvince") %>'></asp:Label>
                               </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                        <EmptyDataTemplate>
                            <div style="width:720px">
                                No data available for product selection
                            </div>
                        </EmptyDataTemplate>
                </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

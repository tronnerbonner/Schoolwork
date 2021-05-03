<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Exercise7.aspx.cs" Inherits="BigPrintWebApp.ExercisePages.Exercise7" %>
<%@ Register assembly="Microsoft.AspNet.EntityDataSource" namespace="Microsoft.AspNet.EntityDataSource" tagprefix="ef" %>
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
                <asp:TextBox ID="modelNumberSearch" runat="server"></asp:TextBox>
                <asp:LinkButton ID="productSearchButton" runat="server" OnClick="productSearchButton_Click">
                    Search
                </asp:LinkButton>
                <br />
                <br />
                <div class="col-md-9">
                    <legend>Registration:</legend>
                    <asp:GridView ID="RegistrationList" runat="server"
                    AutoGenerateColumns="False" GridLines="None"
                    AllowPaging="True" PageSize="5" DataSourceID="ObjectDataSource1">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                               <div style="width:30px">
                                   <asp:Label ID="RegistrationIDLabel" runat="server" 
                                Text='<%# Eval("RegistrationID") %>'></asp:Label>
                               </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product">
                            <ItemTemplate>
                                <asp:DropDownList ID="ProductList" runat="server" Enabled="false" DataSourceID="ProductDataSource" DataTextField="ProductFullName" DataValueField="ProductID" SelectedValue='<%# Eval("ProductID") %>'></asp:DropDownList>
                                <asp:ObjectDataSource ID="ProductDataSource" runat="server" SelectMethod="Product_List" TypeName="HTPSSystem.NJack.BLL.ProductController"></asp:ObjectDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Customer">
                            <ItemTemplate>
                                <asp:DropDownList ID="CustomerList" runat="server" Enabled="false" DataSourceID="CustomerDataSource" DataTextField="FullName" DataValueField="CustomerID" SelectedValue='<%# Eval("CustomerID") %>'></asp:DropDownList>
                                <asp:ObjectDataSource ID="CustomerDataSource" runat="server" SelectMethod="Customer_List" TypeName="HTPSSystem.NJack.BLL.CustomerController"></asp:ObjectDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Serial Number">
                            <ItemTemplate>
                                <div style="width:150px">
                                    <asp:Label ID="SerialNumberLabel" runat="server"
                                        Text='<%# Eval("SerialNumber") %>'>
                                    </asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DofP">
                            <ItemTemplate>
                               <div style="width:150px">
                                   <asp:Label ID="DateLabel" runat="server" 
                                Text='<%# string.Format("{0:MMM dd, yyyy}",Eval("DateOfPurchase"))%>'></asp:Label>
                               </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Store">
                            <ItemTemplate>
                               <div style="width:320px">
                                   <asp:Label ID="PurchasedFromLabel" runat="server" 
                                Text='<%# Eval("PurchasedFrom") %>'></asp:Label>
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
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="Registration_GetByModelNumber" TypeName="HTPSSystem.NJack.BLL.RegistrationController">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="modelNumberSearch" DefaultValue="yuopey" Name="partialmodelnumber" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

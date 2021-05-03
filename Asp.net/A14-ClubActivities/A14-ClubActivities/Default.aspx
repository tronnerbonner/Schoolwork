<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="A14_ClubActivities._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>A14 - Club Activities</h1>
        <p class="lead">This page is for lab documentation</p>
    </div>

    <div class="col-md-4">
        <h2>Known Problems/Missing Items:</h2>
        <p>Off campus validation does not reject a location or campus venue depending on what is checked.</p>
        <p>Error messages appear in inapropriate places.</p>
    </div>
    <div class="col-md-4">
        <h2>Form Descriptions:</h2>
        <br />
        <h3>Query Page:</h3>
        <p>Displays a gridview showing club activities by searching for club name and the activity start date.</p>
        <br />
        <h3>CRUD Page:</h3>
        <p>Allows the user to add, update, or delete club activities and club activity information.</p>
    </div>
    <div class="col-md-4">
        <h2>Entity Relationship Diagram:</h2>
        <asp:Image ID="ERD" src="img/ERD.png" runat="server" />
    </div>
    <div class="col-md-4">
        <h2>Entities Class Diagram:</h2>
        <asp:Image ID="ClassDiagram" src="img/ClassDiagram.png" runat="server" />
    </div>
    <div class="col-md-4">
        <h2>Stored Procedures:</h2><br />
        <ul>
            <li>ClubActivities_FindByCludAndDate: Returns zero or more ClubActivities records matching the club id and is on/after the supplied date</li>
            <li>ClubActivities_FindByClub: Returns zero or more ClubActivities records matching the club id</li>
        </ul>
    </div>
    

</asp:Content>

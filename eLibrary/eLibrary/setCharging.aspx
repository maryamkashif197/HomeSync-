<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="setCharging.aspx.cs" Inherits="eLibrary.setCharging" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-5">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Device</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <i class="fa-solid fa-laptop fa-beat fa-2xl"></i>
                                </center>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <asp:Button ID="Button2" class="btn btn-lg btn-block btn-primary" runat="server" Text="Set Devices to Charging" OnClick="Charging" />
                            </div>
                        </div>
                    <div class="row">
                        <div class="col-md-5">
                            <asp:Label ID="successLabel" runat="server" ForeColor="Green" Visible="false"></asp:Label>
                        </div>
                    </div>
                    </div>
                </div>
                <a href="homepage.aspx"> Back to Home</a><br>
                <br>
            </div>
        </div>
    </div>
</asp:Content>

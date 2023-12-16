<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="roomAv.aspx.cs" Inherits="eLibrary.roomAv" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <!-- Left Column (Tasks) -->
            <div class="col-md-5">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Room</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                   <i class="fa-solid fa-house-user fa-2xl"></i>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>Room Location</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="location" runat="server" placeholder="Room id"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Status</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="status" runat="server" placeholder="Status"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <asp:Button ID="Button2" class="btn btn-lg btn-block btn-primary" runat="server" Text="Change Status" OnClick="RoomAvailability" />
                            </div>
                             <div class="bg-light rounded p-2 mb-2">
                                <asp:Label ID="errorLabel" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                                 <br />
                                <asp:Label ID="LabelRes" runat="server" CssClass="text-dark" Text="Result of Query:"></asp:Label>
                                <asp:Label ID="LabelVal" runat="server" CssClass="text-primary ml-2" Text=""></asp:Label>
                            </div>
                        </div>
                       
                    </div>
                </div>
                <br>
            </div>
        </div>
    </div>
</asp:Content>
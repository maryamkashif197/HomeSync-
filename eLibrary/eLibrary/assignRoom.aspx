<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="assignRoom.aspx.cs" Inherits="eLibrary.assignRoom" %>
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
                                    <h4>Room</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="60" src="imgs/6194029.png" />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                           
                            <div class="col-md-8">
                                <label>Room ID</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="roomid" runat="server" placeholder="Room id"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <asp:Button ID="Button2" class="btn btn-lg btn-block btn-primary" runat="server" Text="Book Room" OnClick="AssignRoom" />
                            </div>
                        </div>
                         <div class="bg-light rounded p-2 mb-2">
                            <asp:Label ID="LabelRes" runat="server" CssClass="text-dark" Text="Result of Query:"></asp:Label>
                            <asp:Label ID="LabelVal" runat="server" CssClass="text-primary ml-2" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
                <a href="homepage.aspx"> Back to Home</a><br>
                <br>
            </div>
            
        </div>
    </div>
</asp:Content>

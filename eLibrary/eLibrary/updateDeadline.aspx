<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="updateDeadline.aspx.cs" Inherits="eLibrary.updateDeadline" %>
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
                                    <h4>Tasks</h4>
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
                                <label>Task ID</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="taskid" runat="server" placeholder="Task ID"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>DeadLine</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="deadline" runat="server" placeholder="" TextMode="DateTimeLocal"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <asp:Button ID="Button2" class="btn btn-lg btn-block btn-primary" runat="server" Text="Updade Deadline" OnClick="UpdateDeadline" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-5">
                                <asp:Label ID="errorLabel" runat="server" ForeColor="Red" Visible="false"></asp:Label>
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
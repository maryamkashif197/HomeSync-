<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="userLogin.aspx.cs" Inherits="eLibrary.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="">
            <div class="col-md-6 mx-auto">
                <div class="card">
                      <div class="card-body">
                          <div class="row">
                              <div class="col">
                                  <center>
                                      <img width="150" src="imgs/login.png"/>
                                  </center>
                              </div>
                          </div>

                         <div class="row">
                              <div class="col">
                                  <center>
                                      <h3>Login ya3m el Hacker</h3>
                                  </center>
                              </div>
                          </div>

                         <div class="row">
                              <div class="col">

                                <label>Email yabn(t)y</label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="username" runat="server" placeholder="email el hacker"></asp:TextBox>
                                </div>

                                <label>Password</label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="password" runat="server" placeholder="passwo3rd" TextMode="Password"></asp:TextBox>
                                </div>
                                  <br />
                                <div class="form-group d-md-grid gap-2">
                                    <asp:Button ID="Button1" class="btn btn-success" runat="server" Text="Login" OnClick="Button1_Click" />
                                </div>
                                  <br />
                                <div class="form-group d-grid">
                                    <a href="register.aspx">
                                      <input id="Button2" class="btn btn-primary" type="button" value="Register" /></a>
                                </div>
                              </div>
                          </div>
                      </div>
                    </div>
                <a href="homepage.aspx">return to home</a>
            </div>
        </div>
    </div>
</asp:Content>

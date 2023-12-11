<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="eLibrary.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>My Profile</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="60" src="imgs/login.png" />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <asp:Button ID="Button2" class="btn btn-lg btn-block btn-primary" runat="server" Text="View Profile" OnClick="ViewProfile" />
                            </div>
                        </div>
                    </div>
                </div>
                <br />
            </div>
             <div class="col-md-2">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Get number of Guests</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="60" src="imgs/login.png" />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <asp:Button ID="Button3" class="btn btn-lg btn-block btn-primary" runat="server" Text="Get Guests" OnClick="GuestNumber" />
                            </div>
                        </div>
                    </div>
                </div>
                <br />
            </div>
            <div class="col-md-2">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Manage guests</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="60" src="imgs/login.png" />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <label>Guest ID</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="guestid" runat="server" placeholder="Guest ID"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <asp:Button ID="Button1" class="btn btn-lg btn-block btn-primary" runat="server" Text="Remove Guest" OnClick="GuestRemove" Visible="true" />
                            </div> 
                        </div>
               <div class="row">
                   <div class="col-md-8">
                       <label>N.Of.Guests</label>
                       <div class="form-group">
                           
                           <div class="input-group">
                                <asp:TextBox CssClass="form-control" ID="numberofguests" runat="server" placeholder="NofGuests"></asp:TextBox>
                           </div>
                       </div>
                   </div>
              <div class="col">
                 <asp:Button ID="Button5" class="btn btn-lg btn-block btn-primary" runat="server" Text="Set N.Guests" OnClick="GuestsAllowed" Visible="true" />
              </div>
               </div>
                    </div>
                </div>
                <br />
            </div>
         <div class="col-md-5">
                  <div class="card">
                      <div class="card-body">
                          <div class="row">
                              <div class="col">
                                 <label>Number of Guests:-</label>
                              </div>
                          </div>
                        <div class="row">
                           <div class="col">
                             <hr />
                          </div>
                          </div>
                          <div class="row">
                              <div class="col">
                                 <asp:Label ID="StatusLabel" runat="server" Visible="false"></asp:Label>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>My Profile</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <asp:GridView class="table table-striped table-bordered" ID="GridView1" runat="server"></asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

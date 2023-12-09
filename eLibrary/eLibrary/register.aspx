<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="eLibrary.register" %>
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
                                   <h3>Register your account</h3>
                               </center>
                           </div>
                       </div>

                      <div class="row">
                           <div class="col">
                             <label>User Type</label>
                             <div class="form-group">
                                 <asp:TextBox class="form-control" ID="usertype" runat="server" placeholder="Admin or Guest"></asp:TextBox>
                             </div>
                             <label>Email</label>
                             <div class="form-group">
                                 <asp:TextBox class="form-control" ID="email" runat="server" placeholder="email"></asp:TextBox>
                             </div>

                             <label>Password</label>
                             <div class="form-group">
                                 <asp:TextBox class="form-control" ID="password" runat="server" placeholder="password" TextMode="Password"></asp:TextBox>
                             </div>
                            <label>Firstname</label>    
                             <div class="form-group">
                                 <asp:TextBox class="form-control" ID="firstname" runat="server" placeholder="firstname"></asp:TextBox>
                             </div>
                             <label>Lastname</label>
                             <div class="form-group">
                                 <asp:TextBox class="form-control" ID="lastname" runat="server" placeholder="lastname"></asp:TextBox>
                             </div>
                             <label>Brith Date</label>
                             <div class="form-group">
                                 <asp:TextBox class="form-control" ID="brithdate" runat="server" placeholder="brithdate" TextMode="Date"></asp:TextBox>
                             </div>

                               <br />
                             <div class="form-group d-grid gap-2">
                                 <asp:Button ID="Button1" class="btn btn-success" runat="server" Text="Register" OnClick="UserRegister" />
                             </div>
                           </div>
                       </div>
                   </div>
                 </div>
             <p>Already have an account? <a href="userLogin.aspx">login</a></p>
         </div>
     </div>
 </div>
</asp:Content>

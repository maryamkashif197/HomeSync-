<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="setTasks.aspx.cs" Inherits="eLibrary.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
    <div class="row">
        <div class="col-md-5">

            <div class="card">
                <div class="card-body">

                    <div class="row">
                        <div class="col">
                            <center>
                                    <h4>Enter the number of guests : </h4>
                                </center>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <center>
                                <img width="60" src="imgs/666201.png" />
                                   
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
                            <label> Admin ID</label>
                            <div class="form-group">
                                <div class="input-group">
                                    <asp:TextBox CssClass="form-control" ID="admin" runat="server" placeholder="ID"></asp:TextBox>
                                    
                                </div>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <label>Number of guests :</label>
                            <div class="form-group">
                                <asp:TextBox CssClass="form-control" ID="number_of_guests" runat="server" placeholder=""></asp:TextBox>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <asp:Button ID="Button2" class="btn btn-lg btn-block btn-success" runat="server" Text="Add" />
                        
                       
                        </div>
                    </div>


                </div>
            </div>

            <a href="homepage.aspx">Back to Home</a><br>
            <br>
        </div>

        <div class="col-md-7">

            <div class="card">
                <div class="card-body">



                    <div class="row">
                        <div class="col">
                            <center>
                                    <h4>Admin list</h4>
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
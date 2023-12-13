<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="viewCharge.aspx.cs" Inherits="eLibrary.viewCharge" %>
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
                                <label>Device ID</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="deviceid" runat="server" placeholder="Device ID"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <asp:Button ID="Button2" class="btn btn-lg btn-block btn-primary" runat="server" Text="View" OnClick="ViewMyDeviceCharge" />
                            </div>
                        </div>
                         <div class="bg-light rounded p-2 mb-2">
                            <asp:Label ID="LabelCharge" runat="server" CssClass="text-dark" Text="Charge:"></asp:Label>
                            <asp:Label ID="LabelChargeValue" runat="server" CssClass="text-primary ml-2" Text=""></asp:Label>
                        </div>
                        <div class="bg-light rounded p-2">
                                 <asp:Label ID="LabelLocation" runat="server" CssClass="text-dark" Text="Location:"></asp:Label>
                                 <asp:Label ID="LabelLocationValue" runat="server" CssClass="text-primary ml-2" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="addDevice.aspx.cs" Inherits="eLibrary.addDevice" %>
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
                            <div class="col-md-4">
                                <label>DeviceID</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="deviceid" runat="server" placeholder="Device ID"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Status</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="status" runat="server" placeholder="BatteryStatus"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Battery</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="battery" runat="server" placeholder="Battery %" ReadOnly="false" ></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Location</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="location" runat="server" placeholder="Room Number" ReadOnly="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Type</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="type" runat="server" placeholder="Type" ReadOnly="false"></asp:TextBox>
                                </div>
                            </div>
                            <br />
                            
                        <div class="row">

                            <div class="col-md-5">
                                <asp:Button ID="Button2" class="btn btn-lg btn-block btn-primary" runat="server" Text="Add Device" OnClick="AddDevice" />
                            </div>
                        </div>
                       
                    </div>
                </div>
                <br>
            </div>
        </div>
    </div>
</asp:Content>
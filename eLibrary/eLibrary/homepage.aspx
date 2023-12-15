<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="homepage.aspx.cs" Inherits="eLibrary.MainWebsite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/syle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <title>HomeSync</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  
    <section class="main" id="home">
        <div>
            <div class="typeout">
                <h2>Welcome To HomeSync<br></h2>
                <br>
            </div>
            <div class="typeout"></div>
            <!-- <h2><span class="job">Back-End Developer</span></h2> -->
            <!-- <h3>I'm working behind the scenes</h3> -->
            <a href="#Interests" class="main-btn">View our project</a>
            <div class="social">
                <a href="https://www.facebook.com/AhmedAlaa989/"><i class="fa-brands fa-facebook"></i></a>
                <!-- <a href="https://www.instagram.com"><i class="fa-brands fa-instagram"></i></a> -->
                <a href="https://github.com/D-Ace0/DatabaseWEBSITE"><i class="fa-brands fa-github"></i></a>
                <!--<a href="https://twitter.com/AhmedMouad9"><i class="fa-brands fa-x"></i></a>-->
            </div>
        </div>
    </section>

    <section class="cards" id="services">
        <h2 class="title">What will you find?</h2>
        <div class="content">
            <div class="card one">
                <div class="icon"> <i class="fa-solid fa-desktop"></i></div>
                <div class="info programming">
                    <h3>Programming</h3>
                    <p>Project built using ASP.NET</p>
                </div>
            </div>

            <div class="card two">
                <div class="icon"><i class="fa-solid fa-database"></i></div>
                <div class="info db">
                    <h3>Databases</h3>
                    <p>Project built using MS-SQl</p>
                </div>
            </div>

            <div class="card three">
                <div class="icon"><i class="fa-solid fa-shield-halved"></i></div>

                <div class="info security">
                    <h3>Security</h3>
                    <p>Defended against multiple IDORs scenarios</p>
                </div>
            </div>
        </div>

    </section>
    <section class="Interests" id="Interests">
        <!-- projects mustn be here not interests 'no projects yet'-->
        <h2 class="title">Team Members & Achievements</h2>
        <div class="content">
            <div class="Interests-card">
                <div class="card-img">
                    <img class="card-img" src="images/ahmed.jpg">
                </div>
                <div class="Interests-info">
                    <p class="Interests-text">Ahmed Alaaelden</p>
                    <strong class="Interests-title">
                        <span>View GitHub</span>
                        <a href="https://github.com/D-Ace0" class="Interests-link">Github</a>
                    </strong>
                </div>
            </div>
            <div class="Interests-card">
                <div class="card-img">
                    <img class="card-img" src="images/jimmu.jpg">
                </div>
                <div class="Interests-info">
                    <p class="Interests-text">Mohamed Gamal</p>
                    <strong class="Interests-title">
                        <span>Known as Jimmy</span>
                        <a href="https://github.com/JimmyDevvvvv" class="Interests-link">Github</a>
                    </strong>
                </div>
            </div>
            <div class="Interests-card">
                <div class="card-img">
                    <img class="card-img" src="images/cert.jpg">
                </div>
                <div class="Interests-info">
                    <p class="Interests-text">Meta BackEnd Certificate</p>
                    <strong class="Interests-title">
                        <span>View Certificate</span>
                        <a href="https://www.coursera.org/account/accomplishments/verify/QRN7CC85NECG"
                            class="Interests-link">more details</a>
                    </strong>
                </div>
            </div>
            <div class="Interests-card">
                <div class="card-img">
                    <img class="card-img" src="images/maryam.jpeg">
                </div>
                <div class="Interests-info">
                    <p class="Interests-text">Maryam Elkashif</p>
                    <strong class="Interests-title">
                        <span>Design Lord</span>
                        <a href="#" class="Interests-link">Github</a>
                    </strong>
                </div>
            </div>

        </div>

    </section>

    <section class="cards" id="contact">
        <h2 class="title">Contact us</h2>
        <div class="contact">
            <div class="card contact-one">
                <div class="icon"> <i class="fa-solid fa-phone"></i></div>
                <div class="phne">
                    <h3>Mobile</h3>
                    <p>01119895247</p>
                </div>
            </div>
            <div class="card contact-two">
                <div class="icon"> <i class="fa-solid fa-envelope"></i></div>
                <div class="email">
                    <h3>Email</h3>
                    <p>ahmed.abdelhameed@student.giu-uni.de</p>
                </div>
            </div>
            <div class="card contact-three">
                <div class="icon"> <i class="fa-solid fa-phone"></i></div>
                <div class="email">
                    <h3>Mobile</h3>
                    <p>01012255651</p>
                </div>
            </div>
            <div class="card contact-four">
                <div class="icon"> <i class="fa-solid fa-envelope"></i></div>
                <div class="email">
                    <h3>Email</h3>
                    <p>mohamed.eissawy@student.giu-uni.de</p>
                </div>
            </div>
            <div class="card contact-five">
                <div class="icon"> <i class="fa-solid fa-phone"></i></div>
                <div class="email">
                    <h3>Mobile</h3>
                    <p>01102938111</p>
                </div>
            </div>
            <div class="card contact-six">
                <div class="icon"> <i class="fa-solid fa-envelope"></i></div>
                <div class="email">
                    <h3>Email</h3>
                    <p>marayam.mirag@student.giu-uni.de</p>
                </div>
            </div>
        </div>

    </section>

    <footer class="foot">
        <p>Copyrights @<span>Team #</span></p>
        <div class="social">
            <a href="https://www.facebook.com/AhmedAlaa989"><i class="fa-brands fa-facebook"></i></a>
            <a href="https://github.com/D-Ace0"><i class="fa-brands fa-github"></i></a>
        </div>
    </footer>

</asp:Content>

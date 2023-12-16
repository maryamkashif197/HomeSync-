using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["type"] != null)
                {
                    LinkButton1.Visible = false; // login
                    LinkButton2.Visible = false;// sign up
                    navbarDropdownTasks.Visible = true;//tasks downmenu
                    LinkButton3.Visible = true; //sign out
                    LinkButton9.Visible = true; //profile
                    navbarDropdownDevice.Visible = true;//device drownmenu
                    LinkButton14.Visible = true; // view charge
                    LinkButton15.Visible = true; //view room
                    LinkButton16.Visible = true; // assign room
                    navbarDropdownRoom.Visible = true;
                    if (Session["type"].ToString() == "Admin")
                    {
                        navbarDropdownTasks.Visible = true;
                        LinkButton4.Visible = true;//add task
                        LinkButton5.Visible = true;//add reminder
                        LinkButton6.Visible = true;//update deadline
                        LinkButton7.Visible = true; // view Task
                        LinkButton8.Visible = true; //finish task
                        LinkButton10.Visible=true; // Add device
                        LinkButton11.Visible = true; // Location of device
                        LinkButton12.Visible = true; // Status device
                        LinkButton13.Visible = true; // Location of 2 died devices
                        LinkButton17.Visible = true;
                        LinkButton18.Visible = true;
                        LinkButton19.Visible = true;

                    }
                }
                else
                {
                    LinkButton1.Visible = true; // login
                    LinkButton2.Visible = true;// sign up
                    LinkButton3.Visible = false; //sign out
                    LinkButton4.Visible=false; //add task
                    LinkButton5.Visible=false; //add reminder
                    LinkButton6.Visible=false;//update deadline
                    LinkButton7.Visible=false;
                    LinkButton8.Visible=false;//finish task
                    navbarDropdownTasks.Visible = false; // tasks downmenu
                    LinkButton9.Visible=false;
                }
            }
            catch (Exception ex){
                Response.Write(ex.Message);
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e) //log in
        {
            Response.Redirect("userLogin.aspx");
        }
        protected void LinkButton2_Click(object sender, EventArgs e) //register
        {
            Response.Redirect("register.aspx");
        }
        protected void LinkButton3_Click(object sender, EventArgs e) //log out
        {
            Session["type"] = null;
            Response.Redirect("homepage.aspx");
        }
        protected void LinkButton4_Click(object sender, EventArgs e) //add task
        {
            Response.Redirect("addTask.aspx");
        }
        protected void LinkButton5_Click(object sender, EventArgs e) //add task
        {
            Response.Redirect("addReminder.aspx");
        }
        protected void LinkButton6_Click(object sender, EventArgs e) //add task
        {
            Response.Redirect("updateDeadline.aspx");
        }
        protected void LinkButton7_Click(object sender, EventArgs e) //add task
        {
            Response.Redirect("viewTask.aspx");
        }

        protected void LinkButton8_Click(object sender, EventArgs e) //add task
        {
            Response.Redirect("finishTasks.aspx");
        }
        protected void LinkButton9_Click(object sender, EventArgs e) //add task
        {
            Response.Redirect("profile.aspx");
        }
        protected void LinkButton10_Click(object sender, EventArgs e) //add Device
        {
            Response.Redirect("addDevice.aspx");
        }
        protected void LinkButton11_Click(object sender, EventArgs e) //Location of device
        {
            Response.Redirect("locationOfDevice.aspx");
        }
        protected void LinkButton12_Click(object sender, EventArgs e) //Set charging
        {
            Response.Redirect("setCharging.aspx");
        }
        protected void LinkButton13_Click(object sender, EventArgs e) //need charge
        {
            Response.Redirect("needCharge.aspx");
        }
        protected void LinkButton14_Click(object sender, EventArgs e) //view charge
        {
            Response.Redirect("viewCharge.aspx");
        }
        protected void LinkButton15_Click(object sender, EventArgs e) //view charge
        {
            Response.Redirect("ViewRooms.aspx");
        }
        protected void LinkButton16_Click(object sender, EventArgs e) //view charge
        {
            Response.Redirect("assignRoom.aspx");
        }
        protected void LinkButton17_Click(object sender, EventArgs e) //view charge
        {
            Response.Redirect("createSchedule.aspx");
        }
        protected void LinkButton18_Click(object sender, EventArgs e) //view charge
        {
            Response.Redirect("roomAv.aspx");
        }
        protected void LinkButton19_Click(object sender, EventArgs e) //view charge
        {
            Response.Redirect("viewRoom.aspx");
        }
    }
}
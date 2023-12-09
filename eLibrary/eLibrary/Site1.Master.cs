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
                    LinkButton3.Visible = true; //sign out
                }
                else
                {
                    LinkButton1.Visible = true; // login
                    LinkButton2.Visible = true;// sign up
                    LinkButton3.Visible = false; //sign out
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
        

    }
}
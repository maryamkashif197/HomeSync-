using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class setCharging : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null || string.IsNullOrEmpty(Session["adminid"].ToString()))
            {
                Response.Redirect("homepage.aspx");
            }
        }
        protected void Charging(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand Charging = new SqlCommand("Charging", conn);
            Charging.CommandType = CommandType.StoredProcedure;



            conn.Open();
            Charging.ExecuteNonQuery();
            conn.Close();
            successLabel.Text = "All devices now are charging.";
            successLabel.Visible = true;
        }
    }
}
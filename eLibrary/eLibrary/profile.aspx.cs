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
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void GuestRemove(object sender, EventArgs e)
        {
            if (Session["adminid"] == null)
            {
                Button1.Visible = false;
                ShowStatusMessage("You have to be an admin to be able to remove a guest.", "error");
                return;
            }    
   
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand GuestRemove = new SqlCommand("GuestRemove", conn);
            GuestRemove.CommandType = CommandType.StoredProcedure;

            GuestRemove.Parameters.Add("@admin_id", SqlDbType.Int).Value = int.Parse(Session["adminid"].ToString());

            if (!string.IsNullOrEmpty(guestid.Text))
            {
                GuestRemove.Parameters.Add("@guest_id", SqlDbType.Int).Value = int.Parse(guestid.Text);

                SqlParameter nofag = GuestRemove.Parameters.Add("@number_of_allowed_guests", SqlDbType.Int);
                nofag.Direction = ParameterDirection.Output;

                conn.Open();
                GuestRemove.ExecuteNonQuery();
                conn.Close();

                int numberOfAllowedGuests = Convert.ToInt32(nofag.Value);

                if (numberOfAllowedGuests >= 0)
                {
                    ShowStatusMessage("Guest removed successfully.", "success");
                }
                else
                {
                    ShowStatusMessage("Failed to remove guest.", "error");
                }
            }else
            {
                ShowStatusMessage("Please provide guest id.", "error");
            }
          
        }

        private void ShowStatusMessage(string message, string messageType)
        {
            StatusLabel.Text = message;
            StatusLabel.CssClass = $"status-label status-{messageType}";
            StatusLabel.Visible = true;

            // Hide the status label after 4 seconds
            ScriptManager.RegisterStartupScript(this, GetType(), "HideStatusLabel", "setTimeout(function(){ document.getElementById('" + StatusLabel.ClientID + "').style.display='none'; }, 4000);", true);
        }

       
        protected void GuestsAllowed(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand GuestsAllowed = new SqlCommand("GuestsAllowed", conn);
            GuestsAllowed.CommandType = CommandType.StoredProcedure;
            if (Session["userid"] == null && Session["adminid"] != null && numberofguests.Text != null)
            {
                GuestsAllowed.Parameters.Add("@admin_id", SqlDbType.Int).Value = int.Parse(Session["adminid"].ToString());
                if (!string.IsNullOrEmpty(numberofguests.Text) && int.TryParse(numberofguests.Text, out int numberOfGuests))
                {
                    GuestsAllowed.Parameters.Add("@number_of_guests", SqlDbType.Int).Value = numberOfGuests;
                }
                else
                {
                    ShowStatusMessage("Please enter a valid number of guests.", "error");
                    return;
                }
            }
            else if (Session["userid"] != null && Session["adminid"] ==null)
            {
                ShowStatusMessage("You have to be an admin to be able to Set number of guests allowed.", "error");
                Button5.Visible = false;
                return;
            }
            else
            {
                ShowStatusMessage("You have to sign in first", "error");
                Button5.Visible = false;
                return;
            }

            conn.Open();
            GuestsAllowed.ExecuteNonQuery();
            conn.Close();

        }
        protected void ViewProfile(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand ViewProfile = new SqlCommand("ViewProfile", conn);
            ViewProfile.CommandType = CommandType.StoredProcedure;
            if (Session["userid"] == null)
            {
                ViewProfile.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(Session["adminid"].ToString());

            }
            else
            {
                ViewProfile.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(Session["userid"].ToString());

            }
            DataTable dt = new DataTable();

            conn.Open();

            using (SqlDataAdapter adapter = new SqlDataAdapter(ViewProfile))
            {
                adapter.Fill(dt);
            }

            conn.Close();

            GridView1.DataSource = dt;
            GridView1.DataBind();

        }

    }
}
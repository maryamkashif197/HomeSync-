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
    public partial class addDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null || string.IsNullOrEmpty(Session["adminid"].ToString()))
            {
                Response.Redirect("homepage.aspx");
            }
        }

        protected void AddDevice(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand AddDevice = new SqlCommand("AddDevice", conn);
            AddDevice.CommandType = CommandType.StoredProcedure;

            try
            {
                if(string.IsNullOrEmpty(deviceid.Text) || string.IsNullOrEmpty(status.Text) ||
                    string.IsNullOrEmpty(battery.Text) || string.IsNullOrEmpty(location.Text) ||
                    string.IsNullOrEmpty(type.Text))
                {
                    errorLabel.Text = "Please provide all parameters.";
                    errorLabel.Visible = true;
                    successLabel.Visible = false;
                    return;
                }
                AddDevice.Parameters.Add("@device_id", SqlDbType.Int).Value = int.Parse(deviceid.Text);
                AddDevice.Parameters.Add("@status", SqlDbType.VarChar).Value = status.Text;
                AddDevice.Parameters.Add("@battery", SqlDbType.Int).Value = int.Parse(battery.Text);
                AddDevice.Parameters.Add("@location", SqlDbType.Int).Value = int.Parse(location.Text);
                AddDevice.Parameters.Add("@type", SqlDbType.VarChar).Value = type.Text;
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
                errorLabel.Visible = true;
                successLabel.Visible = false;
                return;
            }

            try
            {
                conn.Open();
                AddDevice.ExecuteNonQuery();
                conn.Close();
                successLabel.Text = "Deviced Added Successfully";
                successLabel.Visible = true;
                errorLabel.Visible = false;
            }
            catch(Exception ex)
            {
                errorLabel.Text = ex.Message;
                errorLabel.Visible = true;
                successLabel.Visible = false;
                return;
            }




        }
    }
}
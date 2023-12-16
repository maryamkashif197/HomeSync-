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
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null && Session["userid"] == null)
            {
                Response.Redirect("homepage.aspx");
            }
        }

        protected void AddReminder(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand AddReminder = new SqlCommand("AddReminder", conn);
            AddReminder.CommandType = CommandType.StoredProcedure;
            try
            {
                if(string.IsNullOrEmpty(taskid.Text) || string.IsNullOrEmpty(reminder.Text))
                {
                    errorLabel.Text = "Please provide all parameters !";
                    errorLabel.Visible = true;
                    successLabel.Visible = false;
                    return;
                }
                AddReminder.Parameters.Add("@task_id", SqlDbType.Int).Value = int.Parse(taskid.Text);
                AddReminder.Parameters.Add("@reminder", SqlDbType.DateTime).Value = reminder.Text;
            }
            catch(Exception ex) 
            {
                errorLabel.Text = ex.Message;
                errorLabel.Visible = true;
                successLabel.Visible = false;
                return;
            }

            try
            {
                conn.Open();
                AddReminder.ExecuteNonQuery();
                conn.Close();
                successLabel.Text = "Date added successfully!";
                successLabel.Visible = true;
                errorLabel.Visible = false;

            }
            catch (Exception ex2)
            {
                errorLabel.Text = ex2.Message;
                errorLabel.Visible = true;
                successLabel.Visible = false;
                return;
            }
        }

    }
}
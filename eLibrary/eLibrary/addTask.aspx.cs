using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null && Session["userid"] == null)
            {
                Response.Redirect("homepage.aspx");
            }
        }

        protected void AdminAddTask(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand AddTask = new SqlCommand("AdminAddTask", conn);
            AddTask.CommandType = CommandType.StoredProcedure;

            if (Session["adminid"] != null)
            {
                AddTask.Parameters.Add("@creator", SqlDbType.Int).Value = int.Parse(Session["adminid"].ToString());
            }
            else
            {
                errorLabel.Text = "Only admins can add tasks";
                errorLabel.Visible = true;
                successLabel.Visible = false;
                return;
            }

            try
            {
                if(string.IsNullOrEmpty(userid.Text) || string.IsNullOrEmpty(taskname.Text ) ||   
                   string.IsNullOrEmpty(category.Text) || string.IsNullOrEmpty(priority.Text) ||
                   string.IsNullOrEmpty(status.Text) || string.IsNullOrEmpty(reminder.Text) ||
                   string.IsNullOrEmpty(deadline.Text))
                {
                    errorLabel.Text = "Please provide all parameters. ";
                    errorLabel.Visible = true;
                    successLabel.Visible = false;
                    return;
                }
                AddTask.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(userid.Text);
                AddTask.Parameters.Add("@name", SqlDbType.VarChar).Value = taskname.Text;
                AddTask.Parameters.Add("@category", SqlDbType.VarChar).Value = category.Text;
                AddTask.Parameters.Add("@priority", SqlDbType.Int).Value = int.Parse(priority.Text);
                AddTask.Parameters.Add("@status", SqlDbType.VarChar).Value = status.Text;
                AddTask.Parameters.Add("@reminder", SqlDbType.DateTime).Value = reminder.Text;
                AddTask.Parameters.Add("@deadline", SqlDbType.DateTime).Value = deadline.Text;
            }
            catch(Exception ex)
            {
                errorLabel.Text = "Missing parameter. ";
                errorLabel.Visible = true;
                successLabel.Visible = false;
                return;
            }

            if (otheruser==null || string.IsNullOrEmpty(otheruser.Text))
            {
                AddTask.Parameters.Add("@other_user", SqlDbType.Int).Value = DBNull.Value;
            }
            else
            {
                AddTask.Parameters.Add("@other_user", SqlDbType.Int).Value = int.Parse(otheruser.Text);
            }

            try
            {
                conn.Open();
                AddTask.ExecuteNonQuery();
                conn.Close();

                successLabel.Text = "Task added successfully!";
                successLabel.Visible = true;
                errorLabel.Visible = false;
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
                errorLabel.Visible = true;
                successLabel.Visible = false;
            }

        }

    }

}
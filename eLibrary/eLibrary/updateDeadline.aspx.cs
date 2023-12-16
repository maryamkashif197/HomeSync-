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
    public partial class updateDeadline : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null && Session["userid"] == null)
            {
                Response.Redirect("homepage.aspx");
            }
        }
        protected void UpdateDeadline(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand UpdateTaskDeadline = new SqlCommand("UpdateTaskDeadline", conn);
            UpdateTaskDeadline.CommandType = CommandType.StoredProcedure;
            try
            {
                if(string.IsNullOrEmpty(taskid.Text) || string.IsNullOrEmpty(deadline.Text))
                {
                    errorLabel.Text = "Please provide all Parameters.";
                    errorLabel.Visible = true;
                    successLabel.Visible = false;
                    return;
                }
                UpdateTaskDeadline.Parameters.Add("@task_id", SqlDbType.Int).Value = int.Parse(taskid.Text);
                UpdateTaskDeadline.Parameters.Add("@deadline", SqlDbType.DateTime).Value = deadline.Text;
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
                UpdateTaskDeadline.ExecuteNonQuery();
                conn.Close();
                successLabel.Text = "Deadline updated !";
                successLabel.Visible = true;
                errorLabel.Visible = false;
            }
            catch(Exception ex2)
            {
                errorLabel.Text = ex2.Message;
                errorLabel.Visible = true;
                successLabel.Visible = false;
                return;
            }

        }

    }
}
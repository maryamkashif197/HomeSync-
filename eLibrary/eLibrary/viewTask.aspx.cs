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
    public partial class viewTask : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null && Session["userid"] == null)
            {
                Response.Redirect("homepage.aspx");
            }
        }

        protected void ViewTask(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand ViewTask = new SqlCommand("ViewTask", conn);
            ViewTask.CommandType = CommandType.StoredProcedure;

            try
            {
                if(string.IsNullOrEmpty(userid.Text))
                {
                    errorLabel.Text = "Please provide all Parameters.";
                    errorLabel.Visible = true;
                    successLabel.Visible = false;
                    return;
                }
                ViewTask.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(userid.Text);
                ViewTask.Parameters.Add("@creator", SqlDbType.Int).Value = int.Parse(Session["adminid"].ToString());
            }
            catch(Exception ex)
            {
                errorLabel.Text = ex.Message;
                errorLabel.Visible = true;
                successLabel.Visible = false;

                return;
            }

            DataTable dt = new DataTable();

            conn.Open();

            using (SqlDataAdapter adapter = new SqlDataAdapter(ViewTask))
            {
                adapter.Fill(dt);
            }

            conn.Close();

            GridView1.DataSource = dt;
            GridView1.DataBind();
            successLabel.Text = "Query executed successfully";
            successLabel.Visible = true;
            errorLabel.Visible = false;
        }

    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class finishTasks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null && Session["userid"] == null)
            {
                Response.Redirect("homepage.aspx");
            }
        }

        protected void FinishTasks(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand FinishMyTask = new SqlCommand("FinishMyTask", conn);
            FinishMyTask.CommandType = CommandType.StoredProcedure;
            try
            {
                if(string.IsNullOrEmpty(title.Text))
                {
                    errorLabel.Text = "Please provide all parameters.";
                    errorLabel.Visible = true;
                    successLabel.Visible = false;
                    return;
                }
                FinishMyTask.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(Session["adminid"].ToString());
                FinishMyTask.Parameters.Add("@title", SqlDbType.VarChar).Value = title.Text;
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
                errorLabel.Visible = true;
                successLabel.Visible = false;
            }

            conn.Open();
            FinishMyTask.ExecuteNonQuery();
            conn.Close();
            successLabel.Text = "Task has been set to finished";
            successLabel.Visible = true;
            errorLabel.Visible = false;
        }
    }
}
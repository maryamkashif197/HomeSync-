using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class register : System.Web.UI.Page
    {

        //string strcon = ConfigurationManager.ConnectionStrings["HomeSync"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        

        protected void UserRegister(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
           
            SqlConnection con = new SqlConnection(connStr);
            
            SqlCommand cmd = new SqlCommand("UserRegister", con);

            if (string.IsNullOrEmpty(usertype.Text) ||
                string.IsNullOrEmpty(email.Text) ||
                string.IsNullOrEmpty(firstname.Text) ||
                string.IsNullOrEmpty(lastname.Text) ||
                string.IsNullOrEmpty(brithdate.Text) ||
                string.IsNullOrEmpty(password.Text))
            {
                errorLabel.Text = "Please provide all information!";
                errorLabel.Visible = true;
                successLabel.Visible = false;
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorDiv", "showDiv('errorDiv');", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "hideErrorDiv", "hideDiv('errorDiv');", true);
                return;
            }
            cmd.Parameters.Add("@usertype", SqlDbType.VarChar).Value = usertype.Text;
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email.Text;
            cmd.Parameters.Add("@first_name", SqlDbType.VarChar).Value = firstname.Text;
            cmd.Parameters.Add("@last_name", SqlDbType.VarChar).Value = lastname.Text;
            cmd.Parameters.Add("@birth_date", SqlDbType.Date).Value = brithdate.Text;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password.Text;

            SqlParameter userId = new SqlParameter("@user_id", SqlDbType.Int);
            userId.Direction = ParameterDirection.Output;

            cmd.Parameters.Add(userId);
            cmd.CommandType = CommandType.StoredProcedure;                  
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            if (userId.Value.ToString() != "")
            {

                successLabel.Text = "thanks for register, your id is: " + userId.Value.ToString();
                successLabel.Visible = true;
                errorLabel.Visible=false;
                ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessDiv", "showDiv('successDiv');", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "hideSuccessDiv", "hideDiv('successDiv');", true);

            }
            else
            {
                errorLabel.Text = "something went wrong, please try again later.";
                errorLabel.Visible = true;
                successLabel.Visible = false;
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorDiv", "showDiv('errorDiv');", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "hideErrorDiv", "hideDiv('errorDiv');", true);

            }


        }
    }
}
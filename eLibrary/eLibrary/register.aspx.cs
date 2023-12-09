using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class register : System.Web.UI.Page
    {

        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void UserRegister(object sender, EventArgs e)
        {
            
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    SqlCommand cmd = new SqlCommand("UserRegister", con);

                    cmd.Parameters.Add("@usertype", SqlDbType.VarChar).Value = usertype.Text;
                    cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email.Text;
                    cmd.Parameters.Add("@first_name", SqlDbType.VarChar).Value = usertype.Text;
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

                    if(userId.Value.ToString() != "")
                    {

                        Response.Write("thanks for register, your id is: " + userId.Value.ToString());

                    }
                    else
                    {
                        Response.Write("something went wrong");
                    }
                }
                

               
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
            }

        }
    }
}
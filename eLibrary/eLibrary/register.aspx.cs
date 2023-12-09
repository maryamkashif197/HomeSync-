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
        string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

        //string strcon = ConfigurationManager.ConnectionStrings["HomeSync"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /**        protected void select(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Admin", con);
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        Response.Write("<table border='1'>");
                        Response.Write("<tr><th>Admin ID</th><th>No. of Guests Allowed</th><th>Salary</th></tr>");

                        while (reader.Read())
                        {
                            int adminId = reader.GetInt32(reader.GetOrdinal("admin_id"));
                            int guestsAllowed = reader.GetInt32(reader.GetOrdinal("no_of_guests_allowed"));
                            decimal salary = reader.GetDecimal(reader.GetOrdinal("salary"));

                            Response.Write("<tr>");
                            Response.Write("<td>" + adminId + "</td>");
                            Response.Write("<td>" + guestsAllowed + "</td>");
                            Response.Write("<td>" + salary + "</td>");
                            Response.Write("</tr>");
                        }

                        Response.Write("</table>");
                    }
                    else
                    {
                        Response.Write("<script>alert('No data found');</script>");
                    }

                    reader.Close();
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
                Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
            }
        } **/

        protected void UserRegister(object sender, EventArgs e)
        {
            
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("UserRegister", con);

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

                    if(userId.Value.ToString() != "")
                    {

                        Response.Write("thanks for register, your id is: " + userId.Value.ToString());
                        //SESSION['type'] = usertype.Text;

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
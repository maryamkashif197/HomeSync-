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
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            string LoginEmail = username.Text;
            string usrpassword = password.Text;

            SqlCommand loginProc = new SqlCommand("UserLogin", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@email", LoginEmail));
            loginProc.Parameters.Add(new SqlParameter("@password", usrpassword)); //parameter lines

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Bit);  //output lines
            success.Direction = ParameterDirection.Output;

            SqlParameter userid = loginProc.Parameters.Add("@user_id", SqlDbType.Int);  //output lines
            userid.Direction = ParameterDirection.Output;
            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if ((bool)success.Value)
            {
                Response.Write("welcome ");
                SqlConnection con = new SqlConnection(connStr);
                
                con.Open();

                SqlCommand getTypeCommand = new SqlCommand("SELECT * FROM Users WHERE password = '" + usrpassword.Trim() + "' AND email = '" + LoginEmail.Trim() + "'", con);
                SqlDataReader dr = getTypeCommand.ExecuteReader();

                if (dr.HasRows)
                {
                   while (dr.Read())
                     {
                        Session["type"] = dr.GetValue(7).ToString();
                        Response.Write(Session["type"]);
                     }
                }
                else
                {
                    Response.Write("<script>alert('invalid query');</script>");
                }
                
            }
            else
                Response.Write("Invaid username or password");
        }


    }
}
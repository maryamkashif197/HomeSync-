using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class viewRoom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"]== null && Session["userid"] == null)
            {
                Response.Redirect("homepage.aspx");
            }
        }

        protected void ViewRoom(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand ViewRoom = new SqlCommand("ViewRoom", conn);
            ViewRoom.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            conn.Open();
            using(SqlDataAdapter reader = new SqlDataAdapter(ViewRoom))
            {
                reader.Fill(dt);
            }
            conn.Close();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}
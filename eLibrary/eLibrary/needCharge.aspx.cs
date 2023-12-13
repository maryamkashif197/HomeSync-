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
    public partial class needCharge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null || string.IsNullOrEmpty(Session["adminid"].ToString()))
            {
                Response.Redirect("homepage.aspx");
            }
        }

        protected void NeedCharge(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand NeedCharge = new SqlCommand("NeedCharge", conn);
            NeedCharge.CommandType = CommandType.StoredProcedure;


            DataTable dt = new DataTable();

            conn.Open();

            using (SqlDataAdapter adapter = new SqlDataAdapter(NeedCharge))
            {
                adapter.Fill(dt);
            }

            conn.Close();

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}
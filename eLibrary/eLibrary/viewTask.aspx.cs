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

        }

        protected void ViewTask(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand ViewTask = new SqlCommand("ViewTask", conn);
            ViewTask.CommandType = CommandType.StoredProcedure;

            ViewTask.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(userid.Text);
            ViewTask.Parameters.Add("@creator", SqlDbType.Int).Value = int.Parse(creator.Text);

            DataTable dt = new DataTable();

            conn.Open();

            using (SqlDataAdapter adapter = new SqlDataAdapter(ViewTask))
            {
                adapter.Fill(dt);
            }

            conn.Close();

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

    }
}
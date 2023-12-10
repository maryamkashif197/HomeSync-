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
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddReminder(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand AddReminder = new SqlCommand("AddReminder", conn);
            AddReminder.CommandType = CommandType.StoredProcedure;
            AddReminder.Parameters.Add("@task_id", SqlDbType.Int).Value = int.Parse(taskid.Text);
            AddReminder.Parameters.Add("@reminder", SqlDbType.DateTime).Value = reminder.Text;;

            conn.Open();
            AddReminder.ExecuteNonQuery();
            conn.Close();
        }

    }
}
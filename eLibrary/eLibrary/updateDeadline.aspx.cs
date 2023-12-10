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
    public partial class updateDeadline : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void UpdateDeadline(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand UpdateTaskDeadline = new SqlCommand("UpdateTaskDeadline", conn);
            UpdateTaskDeadline.CommandType = CommandType.StoredProcedure;
            UpdateTaskDeadline.Parameters.Add("@task_id", SqlDbType.Int).Value = int.Parse(taskid.Text);
            UpdateTaskDeadline.Parameters.Add("@deadline", SqlDbType.DateTime).Value = deadline.Text;

            conn.Open();
            UpdateTaskDeadline.ExecuteNonQuery();
            conn.Close();
        }

    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AdminAddTask(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand AddTask = new SqlCommand("AdminAddTask", conn);
            AddTask.CommandType = CommandType.StoredProcedure;
            if (Session["userid"].ToString() != "")
            {
                string creator = Session["userid"].ToString();
                adminid.Text = creator;
                AddTask.Parameters.Add("@creator", SqlDbType.Int).Value = int.Parse(creator);
            }
            AddTask.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(userid.Text);
            AddTask.Parameters.Add("@name", SqlDbType.VarChar).Value = taskname.Text;
            AddTask.Parameters.Add("@category", SqlDbType.VarChar).Value = category.Text;
            AddTask.Parameters.Add("@priority", SqlDbType.Int).Value = int.Parse(priority.Text);
            AddTask.Parameters.Add("@status", SqlDbType.VarChar).Value = status.Text;
            AddTask.Parameters.Add("@reminder", SqlDbType.DateTime).Value = reminder.Text;
            AddTask.Parameters.Add("@deadline", SqlDbType.DateTime).Value = deadline.Text;
            if (otheruser.Text == "")
            {
                AddTask.Parameters.Add("@other_user", SqlDbType.Int).Value = null;
            }
            else
            {
                AddTask.Parameters.Add("@other_user", SqlDbType.Int).Value = int.Parse(otheruser.Text);
            }
         
            conn.Open();
            AddTask.ExecuteNonQuery();
            conn.Close();

        }

    }

}
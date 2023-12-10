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

            string userIds = userid.Text;
            string creator = Session["userid"].ToString();
            string taskName = taskname.Text;
            string Category = category.Text;
            string Priority = priority.Text;
            string Status = status.Text;
            string Remidner = reminder.Text;
            string deadLine = deadline.Text;
            string otherUser = otheruser.Text;

            SqlCommand AddTask = new SqlCommand("AdminAddTask", conn);
            AddTask.CommandType = CommandType.StoredProcedure;

            AddTask.Parameters.Add("@user_id", SqlDbType.Int).Value = userIds;
            AddTask.Parameters.Add("@creator", SqlDbType.Int).Value = creator;
            AddTask.Parameters.Add("@name", SqlDbType.VarChar).Value = taskName;
            AddTask.Parameters.Add("@category", SqlDbType.VarChar).Value = Category;
            AddTask.Parameters.Add("@priority", SqlDbType.Int).Value = Priority;
            AddTask.Parameters.Add("@status", SqlDbType.VarChar).Value = Status;
            AddTask.Parameters.Add("@reminder", SqlDbType.DateTime).Value = Remidner;
            AddTask.Parameters.Add("@deadline", SqlDbType.DateTime).Value = deadLine;
            AddTask.Parameters.Add("@other_user", SqlDbType.Int).Value = otherUser;

            conn.Open();
            AddTask.ExecuteNonQuery();
            conn.Close();

        }
        protected void Button4_Click(object sender, EventArgs e)
        {

        }
        protected void Button5_Click(object sender, EventArgs e)
        {

        }
        

    }

}
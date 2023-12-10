using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eLibrary
{
    public partial class finishTasks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FinishTasks(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand FinishMyTask = new SqlCommand("FinishMyTask", conn);
            FinishMyTask.CommandType = CommandType.StoredProcedure;
            FinishMyTask.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(userid.Text);
            FinishMyTask.Parameters.Add("@title", SqlDbType.VarChar).Value = title.Text;

            conn.Open();
            FinishMyTask.ExecuteNonQuery();
            conn.Close();
        }
    }
}
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
    public partial class createSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminid"] == null && Session["userid"] == null)
            {
                Response.Redirect("homepage.aspx");
            }
        }

        protected void CreateSchedule(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand CreateSchedule = new SqlCommand("CreateSchedule", conn);
            CreateSchedule.CommandType = CommandType.StoredProcedure;
            if (Session["adminid"] == null || string.IsNullOrEmpty(Session["adminid"].ToString()))
            {
                LabelVal.Text = "You are not allowed to do such an action !"; // anta keda mesh admin
                return;
            }
            else
            {
                CreateSchedule.Parameters.Add("@creator_id", SqlDbType.Int).Value = int.Parse(Session["adminid"].ToString());
            }
            CreateSchedule.Parameters.Add("@room_id", SqlDbType.Int).Value = int.Parse(roomid.Text);
            CreateSchedule.Parameters.Add("@start_time", SqlDbType.DateTime).Value = start_time.Text;
            CreateSchedule.Parameters.Add("@end_time", SqlDbType.DateTime).Value = end_time.Text;
            CreateSchedule.Parameters.Add("@action", SqlDbType.VarChar).Value = action.Text;

            try
            {
                conn.Open();
                CreateSchedule.ExecuteNonQuery();
                conn.Close();
                LabelVal.Text = "Query executed Successfully !"; //ay 5edma
            }catch (Exception ex)
            {
                LabelVal.Text = "something went wrong with the execution of the query.";
            }
        }
    }
}
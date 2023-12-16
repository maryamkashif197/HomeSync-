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
    public partial class assignRoom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null && Session["adminid"] == null)
            {
                Response.Redirect("userLogin.aspx");
            }
        }

        protected void AssignRoom(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand AssignRoom = new SqlCommand("AssignRoom", conn);
            AssignRoom.CommandType = CommandType.StoredProcedure;

            if (Session["userid"] != null)
            {
                AssignRoom.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(Session["userid"].ToString());
            }
            else
            {
                AssignRoom.Parameters.Add("@user_id", SqlDbType.Int).Value = int.Parse(Session["adminid"].ToString());
            }
            if (string.IsNullOrEmpty(roomid.Text))
            {
                errorLabel.Text = "Please provide all parameters.";
                errorLabel.Visible = true;
                return;
            }
            AssignRoom.Parameters.Add("@room_id", SqlDbType.Int).Value = int.Parse(roomid.Text);

            conn.Open();
            AssignRoom.ExecuteNonQuery();
            conn.Close();
            LabelVal.Text = "Room booked successfully !";
            errorLabel.Visible = false;
        }
    }
}
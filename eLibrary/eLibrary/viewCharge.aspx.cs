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
    public partial class viewCharge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null && Session["adminid"] == null)
            {
                Response.Redirect("userLogin.aspx");
            }
        }

        protected void ViewMyDeviceCharge(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand ViewMyDeviceCharge = new SqlCommand("ViewMyDeviceCharge", conn);
            ViewMyDeviceCharge.CommandType = CommandType.StoredProcedure;

            ViewMyDeviceCharge.Parameters.Add("@device_id", SqlDbType.Int).Value = int.Parse(deviceid.Text);
            ViewMyDeviceCharge.Parameters.Add("@charge", SqlDbType.Int).Direction = ParameterDirection.Output;
            ViewMyDeviceCharge.Parameters.Add("@location", SqlDbType.Int).Direction = ParameterDirection.Output;

            conn.Open();
            ViewMyDeviceCharge.ExecuteNonQuery();
            conn.Close();

            int charge = (int)ViewMyDeviceCharge.Parameters["@charge"].Value;
            int location = (int)ViewMyDeviceCharge.Parameters["@location"].Value;

            LabelChargeValue.Text = charge.ToString();
            LabelLocationValue.Text =  location.ToString();
        }

    }
}
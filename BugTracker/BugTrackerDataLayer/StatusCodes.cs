using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BugTrackerDataLayer
{
    class StatusCodes
    {
        public List<StatusCode> ListAllStatusCodes()
        {

            List<StatusCode> statusCodes = new List<StatusCode>();

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"ListAllStatusCodes";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        StatusCode s = new StatusCode();
                        s.Load(reader);
                        statusCodes.Add(s);
                    }
                }
            }

            return statusCodes;
        }
    }

    public class StatusCode
    {

        public int StatusCodeID { get; set; }
        public string StatusCodeDesc { get; set; }



        public void Load(SqlDataReader reader)
        {
            StatusCodeID = Int32.Parse(reader["StatusCodeID"].ToString());
            StatusCodeDesc = reader["StatusCodeDesc"].ToString();

        }

    }
}

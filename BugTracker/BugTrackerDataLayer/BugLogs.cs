using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BugTrackerDataLayer
{
    class BugLogs
    {
        public List<BugLog> ListAllUsers()
        {

            List<BugLog> bugLogs = new List<BugLog>();

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"GetBugLogInformation";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        BugLog bl = new BugLog();
                        bl.Load(reader);
                        bugLogs.Add(bl);
                    }
                }
            }

            return bugLogs;
        }
    }

    public class BugLog
    {

        public int BugLogID { get; set; }
        public string BugLogDate { get; set; }
        public int StatusCodeID { get; set; }
        public int UserID { get; set; }
        public string BugLogDesc { get; set; }
        public int BugID { get; set; }



        public void Load(SqlDataReader reader)
        {
            BugLogID = Int32.Parse(reader["BugLogID"].ToString());
            BugLogDate = reader["BugLogDate"].ToString();
            StatusCodeID = Int32.Parse(reader["StatusCodeID"].ToString());
            UserID = Int32.Parse(reader["UserID"].ToString());
            BugLogDesc = reader["BugLogDesc"].ToString();
            BugID = Int32.Parse(reader["BugID"].ToString());

        }

    }
}

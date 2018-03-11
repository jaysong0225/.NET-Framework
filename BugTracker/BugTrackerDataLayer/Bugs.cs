using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BugTrackerDataLayer
{
    class Bugs
    {
        public List<Bug> ListAllUsers(int appId, int statusCodeId)
        {

            List<Bug> bugs = new List<Bug>();

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"ListAllBugs";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter parameter1 = new SqlParameter("AppID", System.Data.SqlDbType.Int);
                    parameter1.Value = appId;
                    command.Parameters.Add(parameter1);

                    SqlParameter parameter2 = new SqlParameter("StatusCodeID", System.Data.SqlDbType.Int);
                    parameter2.Value = statusCodeId;
                    command.Parameters.Add(parameter2);

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        Bug b = new Bug();
                        b.Load(reader);
                        bugs.Add(b);
                    }
                }
            }

            return bugs;
        }

        public BugInfo GetBugInformation(int bugId)
        {
            BugInfo b = new BugInfo();

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"GetBugInformation";
                    command.CommandType = System.Data.CommandType.StoredProcedure;


                    SqlParameter parameter1 = new SqlParameter("BugID", System.Data.SqlDbType.Int);
                    parameter1.Value = bugId;

                    command.Parameters.Add(parameter1);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        b.Load(reader);
                    }

                }

            }

            return b;
        }

        public int AddNewBug(int userId, int appId, string bugDesc, string bugDetails, string repSteps)
        {
            int result = -1;
            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"AddNewBug";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter parameter1 = new SqlParameter("UserID", System.Data.SqlDbType.Int);
                    parameter1.Value = userId;
                    command.Parameters.Add(parameter1);

                    SqlParameter parameter2 = new SqlParameter("AppID", System.Data.SqlDbType.Int);
                    parameter2.Value = appId;
                    command.Parameters.Add(parameter2);

                    SqlParameter parameter3 = new SqlParameter("BugDate", System.Data.SqlDbType.DateTime);
                    parameter3.Value = DateTime.Now;
                    command.Parameters.Add(parameter3);

                    SqlParameter parameter4 = new SqlParameter("BugDesc", System.Data.SqlDbType.VarChar, 40);
                    parameter4.Value = bugDesc;
                    command.Parameters.Add(parameter4);

                    SqlParameter parameter5 = new SqlParameter("BugDetails", System.Data.SqlDbType.Text);
                    parameter5.Value = bugDetails;
                    command.Parameters.Add(parameter5);

                    SqlParameter parameter6 = new SqlParameter("RepSteps", System.Data.SqlDbType.Text);
                    parameter2.Value = repSteps;
                    command.Parameters.Add(parameter6);

                    result = command.ExecuteNonQuery();
                }
            }
            return result;
        }

        public void UpdateBugInformation(int bugId, int appId, int userId, int bugSignOff, DateTime bugDate,
                                           string bugDesc, string bugDetails, string repSteps, DateTime fixDate, 
                                           string bugLogDesc, int statusCodeId)
        {

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"UpdateBug";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter parameter1 = new SqlParameter("BugID", System.Data.SqlDbType.Int);
                    parameter1.Value = bugId;
                    command.Parameters.Add(parameter1);

                    SqlParameter parameter2 = new SqlParameter("AppID", System.Data.SqlDbType.Int);
                    parameter2.Value = appId;
                    command.Parameters.Add(parameter2);

                    SqlParameter parameter3 = new SqlParameter("UserID", System.Data.SqlDbType.Int);
                    parameter3.Value = userId;
                    command.Parameters.Add(parameter3);

                    SqlParameter parameter4 = new SqlParameter("BugSignOff", System.Data.SqlDbType.Int);
                    parameter4.Value = bugSignOff;
                    command.Parameters.Add(parameter4);

                    SqlParameter parameter5 = new SqlParameter("BugDate", System.Data.SqlDbType.DateTime);
                    parameter5.Value = bugDate;
                    command.Parameters.Add(parameter5);

                    SqlParameter parameter6 = new SqlParameter("BugDesc", System.Data.SqlDbType.VarChar, 40);
                    parameter6.Value = bugDesc;
                    command.Parameters.Add(parameter6);

                    SqlParameter parameter7 = new SqlParameter("RepSteps", System.Data.SqlDbType.Text);
                    parameter7.Value = bugDetails;
                    command.Parameters.Add(parameter7);

                    SqlParameter parameter8 = new SqlParameter("RepSteps", System.Data.SqlDbType.Text);
                    parameter8.Value = repSteps;
                    command.Parameters.Add(parameter8);

                    SqlParameter parameter9 = new SqlParameter("FixDate", System.Data.SqlDbType.DateTime);
                    parameter9.Value = bugDate;
                    command.Parameters.Add(parameter9);

                    SqlParameter parameter10 = new SqlParameter("BugLogDesc", System.Data.SqlDbType.Text);
                    parameter10.Value = bugLogDesc;
                    command.Parameters.Add(parameter10);

                    SqlParameter parameter11 = new SqlParameter("StatusCodeID", System.Data.SqlDbType.Int);
                    parameter11.Value = statusCodeId;
                    command.Parameters.Add(parameter11);

                    command.ExecuteNonQuery();

                }
            }
        }

        public void DeleteBug(int bugId)
        {
            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"DeleteBug";
                    command.CommandType = System.Data.CommandType.StoredProcedure;


                    SqlParameter parameter1 = new SqlParameter("BugID", System.Data.SqlDbType.Int);
                    parameter1.Value = bugId;

                    command.Parameters.Add(parameter1);

                    command.ExecuteNonQuery();

                }
            }
        }
    }

    class Bug
    {
        public int BugID { get; set; }
        public string BugDesc { get; set; }

        public void Load(SqlDataReader reader)
        {
            BugID = Int32.Parse(reader["BugID"].ToString());
            BugDesc = reader["BugDesc"].ToString();
        }
    }

    class BugInfo
    {
        public string BugDate { get; set; }
        public string BugDesc { get; set; }
        public string BugDetails { get; set; }
        public string RepSteps { get; set; }
        public string FixDate { get; set; }

        public void Load(SqlDataReader reader)
        {
            BugDate = reader["BugDate"].ToString();
            BugDesc = reader["BugDesc"].ToString();
            BugDetails = reader["BugDetails"].ToString();
            RepSteps = reader["RepSteps"].ToString();
            FixDate = reader["FixDate"].ToString();
        }
    }

}

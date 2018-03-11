using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BugTrackerDataLayer
{
    class Applications
    {
        public List<Application> ListAllApplications()
        {

            List<Application> applications = new List<Application>();

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"ListAllAppliations";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        Application a = new Application();
                        a.Load(reader);
                        applications.Add(a);
                    }
                }
            }

            return applications;
        }

        public Application GetApplicationInformation(int appId)
        {
            Application a = new Application();

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"GetApplicationInformation";
                    command.CommandType = System.Data.CommandType.StoredProcedure;


                    SqlParameter parameter1 = new SqlParameter("AppID", System.Data.SqlDbType.Int);
                    parameter1.Value = appId;

                    command.Parameters.Add(parameter1);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        a.Load(reader);
                    }

                }

            }

            return a;
        }

        public int AddNewApplication(string appName, string appVersion, string appDesc)
        {
            int result = -1;
            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"AddNewApplication";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter parameter1 = new SqlParameter("AppName", System.Data.SqlDbType.VarChar, 40);
                    parameter1.Value = appName;
                    command.Parameters.Add(parameter1);

                    SqlParameter parameter2 = new SqlParameter("AppVersion", System.Data.SqlDbType.VarChar, 40);
                    parameter2.Value = appVersion;
                    command.Parameters.Add(parameter2);

                    SqlParameter parameter3 = new SqlParameter("AppDesc", System.Data.SqlDbType.VarChar, 40);
                    parameter3.Value = appDesc;
                    command.Parameters.Add(parameter3);

                    result = command.ExecuteNonQuery();
                }
            }
            return result;
        }

        public void UpdateAppInformation(int appId, string appName, string appVersion, string appDesc)
        {

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"UpdateApplication";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter parameter1 = new SqlParameter("AppID", System.Data.SqlDbType.Int);
                    parameter1.Value = appId;
                    command.Parameters.Add(parameter1);

                    SqlParameter parameter2 = new SqlParameter("AppName", System.Data.SqlDbType.VarChar, 40);
                    parameter2.Value = appName;
                    command.Parameters.Add(parameter2);

                    SqlParameter parameter3 = new SqlParameter("AppVersion", System.Data.SqlDbType.VarChar, 40);
                    parameter2.Value = appVersion;
                    command.Parameters.Add(parameter3);

                    SqlParameter parameter4 = new SqlParameter("AppDesc", System.Data.SqlDbType.VarChar, 40);
                    parameter2.Value = appDesc;
                    command.Parameters.Add(parameter4);

                    command.ExecuteNonQuery();

                }
            }
        }

        public void DeleteApplication(int appId)
        {
            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"DeleteApplication";
                    command.CommandType = System.Data.CommandType.StoredProcedure;


                    SqlParameter parameter1 = new SqlParameter("AppID", System.Data.SqlDbType.Int);
                    parameter1.Value = appId;

                    command.Parameters.Add(parameter1);

                    command.ExecuteNonQuery();

                }
            }
        }
    }

    public class Application
    {

        public int AppID { get; set; }
        public string AppName { get; set; }
        public string AppVersion { get; set; }
        public string AppDesc { get; set; }



        public void Load(SqlDataReader reader)
        {
            AppID = Int32.Parse(reader["AppID"].ToString());
            AppName = reader["AppName"].ToString();
            AppVersion = reader["AppVersion"].ToString();
            AppDesc = reader["AppDesc"].ToString();

        }

    }
}

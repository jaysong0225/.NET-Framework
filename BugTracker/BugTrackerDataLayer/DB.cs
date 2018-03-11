using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BugTrackerDataLayer
{

    public class DB
    {

        public static string ConnectionString
        {
            get
            {
                string connectionString
                    = ConfigurationManager.ConnectionStrings["BugTrackerConnection"].ConnectionString;

                SqlConnectionStringBuilder stringBuilder = new SqlConnectionStringBuilder(connectionString);
                stringBuilder.ApplicationName = ApplicationName ?? stringBuilder.ApplicationName;
                stringBuilder.ConnectTimeout = (ConnectionTimeout > 0) ? ConnectionTimeout : stringBuilder.ConnectTimeout;

                return stringBuilder.ToString();
            }
        }

        public static SqlConnection GetSqlConnection()
        {
            SqlConnection connection = new SqlConnection(ConnectionString);
            connection.Open();

            return connection;
        }

        /// <summary>
        /// Overrides the connection timeout
        /// </summary>
        public static int ConnectionTimeout { get; set; }

        /// <summary>
        /// Property used to override the name of the application
        /// </summary>
        public static string ApplicationName { get; set; }

    }
}

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BugTrackerDataLayer
{
    public class Users
    {
        public List<User> ListAllUsers()
        {

            List<User> users = new List<User>();

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"ListAllUsers";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        User u = new User();
                        u.Load(reader);
                        users.Add(u);
                    }
                }
            }

            return users;
        }

        public User GetUserInformation(int userId)
        {
            User u = new User();

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"GetUserInformation";
                    command.CommandType = System.Data.CommandType.StoredProcedure;


                    SqlParameter parameter1 = new SqlParameter("UserID", System.Data.SqlDbType.Int);
                    parameter1.Value = userId;

                    command.Parameters.Add(parameter1);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        u.Load(reader);
                    }

                }

            }

            return u;
        }

        public int ConfirmUserName(string userName)
        {
            int result = -1;

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"ConfirmUserName";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter parameter1 = new SqlParameter("UserEmail", System.Data.SqlDbType.VarChar, 80);
                    parameter1.Value = userName;
                    command.Parameters.Add(parameter1);

                    //SqlDataReader reader = command.ExecuteReader();
                    result = command.ExecuteNonQuery();

                }

            }

            return result;
        }

        public int AddNewUser(string userName, string userEmail, string userTel)
        {
            int result = -1;
            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"AddNewUser";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter parameter1 = new SqlParameter("UserName", System.Data.SqlDbType.VarChar, 80);
                    parameter1.Value = userName;
                    command.Parameters.Add(parameter1);

                    SqlParameter parameter2 = new SqlParameter("UserEmail", System.Data.SqlDbType.VarChar, 80);
                    parameter2.Value = userEmail;
                    command.Parameters.Add(parameter2);

                    SqlParameter parameter3 = new SqlParameter("userTel", System.Data.SqlDbType.VarChar, 40);
                    parameter3.Value = userTel;
                    command.Parameters.Add(parameter3);

                    result = command.ExecuteNonQuery();                      
                }
            }
            return result;
        }

        public void UpdateUserInformation(int userId, string userName, string userEmail, string userTel)
        {

            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"UpdateUser";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter parameter1 = new SqlParameter("UserID", System.Data.SqlDbType.Int);
                    parameter1.Value = userId;
                    command.Parameters.Add(parameter1);

                    SqlParameter parameter2 = new SqlParameter("UserName", System.Data.SqlDbType.VarChar, 80);
                    parameter2.Value = userName;
                    command.Parameters.Add(parameter2);

                    SqlParameter parameter3 = new SqlParameter("UserEmail", System.Data.SqlDbType.VarChar, 80);
                    parameter2.Value = userEmail;
                    command.Parameters.Add(parameter3);

                    SqlParameter parameter4 = new SqlParameter("UserTel", System.Data.SqlDbType.VarChar, 40);
                    parameter2.Value = userTel;
                    command.Parameters.Add(parameter4);

                    command.ExecuteNonQuery();

                }
            }
        }

        public void DeleteUser(int userId)
        {
            using (SqlConnection connection = DB.GetSqlConnection())
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = @"DeleteUser";
                    command.CommandType = System.Data.CommandType.StoredProcedure;


                    SqlParameter parameter1 = new SqlParameter("UserID", System.Data.SqlDbType.Int);
                    parameter1.Value = userId;

                    command.Parameters.Add(parameter1);

                    command.ExecuteNonQuery();

                }
            }
        }
    }

    public class User
    {

        public int UserID { get; set; }
        public string UserName { get; set; }
        public string UserEmail { get; set; }
        public string UserTel { get; set; }



        public void Load(SqlDataReader reader)
        {
            UserID = Int32.Parse(reader["UserID"].ToString());
            UserName = reader["UserName"].ToString();
            UserEmail = reader["UserEmail"].ToString();
            UserTel = reader["UserTel"].ToString();

        }

    }
}

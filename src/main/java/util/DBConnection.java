package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import io.github.cdimascio.dotenv.Dotenv;

public class DBConnection {
  private static final Dotenv dotenv = Dotenv.configure().load();
  private static final String URL = String.format("jdbc:mysql://%s:%s/%s",
      dotenv.get("DB_HOST"), dotenv.get("DB_PORT"), dotenv.get("DB_NAME"));
  private static final String USERNAME = dotenv.get("DB_USERNAME");
  private static final String PASSWORD = dotenv.get("DB_PASSWORD");

  public static Connection getConnection() throws SQLException {
    try {
      Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException err) {
      throw new SQLException("MySQL Driver not found", err);
    }
    return DriverManager.getConnection(URL, USERNAME, PASSWORD);
  }
}

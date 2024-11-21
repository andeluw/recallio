package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.User;
import util.Password;

public class UserRepository {
  private Connection connection;

  public UserRepository(Connection connection) {
    this.connection = connection;
  }

  public boolean registerUser(User user) throws SQLException {
    String query = "INSERT INTO users (username, password) VALUES (?, ?)";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setString(1, user.getUsername());
      stmt.setString(2, user.getPassword());
      int result = stmt.executeUpdate();
      return result > 0;
    } catch (SQLException err) {
      throw new SQLException("Error registering user", err);
    }
  }

  public boolean usernameExists(String username) throws SQLException {
    String query = "SELECT COUNT(*) FROM users WHERE username = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setString(1, username);
      ResultSet res = stmt.executeQuery();
      if (res.next()) {
        return res.getInt(1) > 0;
      }
    } catch (SQLException err) {
      throw new SQLException("Error checking username", err);
    }
    return false;
  }

  public int loginUser(User user) throws SQLException {
    String query = "SELECT user_id, password FROM users WHERE username = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setString(1, user.getUsername());
      ResultSet res = stmt.executeQuery();
      String password = "";
      if (res.next()) {
        password = res.getString("password");
      }
      if (Password.checkPassword(password, user.getPassword())) {
        return res.getInt("user_id");
      } else
        return -1;
    } catch (SQLException err) {
      throw new SQLException("Error logging in user", err);
    }
  }
}

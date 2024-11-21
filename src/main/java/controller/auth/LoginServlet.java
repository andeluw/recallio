package controller.auth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;
import repository.UserRepository;
import util.DBConnection;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/login.jsp");
    dispatcher.forward(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (password == null || password.trim().isEmpty() || username == null || username.trim().isEmpty()) {
      request.setAttribute("errorMessage", "Username and password are required");
      RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/login.jsp");
      dispatcher.forward(request, response);
      return;
    }

    try {
      Connection connection = DBConnection.getConnection();
      UserRepository userRepository = new UserRepository(connection);

      User user = new User();
      user.setUsername(username);
      user.setPassword(password);

      int userId = userRepository.loginUser(user);

      if (userId != -1) {
        HttpSession session = request.getSession(true);
        session.setAttribute("username", username);
        session.setAttribute("userId", userId);
        response.sendRedirect(request.getContextPath() + "/profile");
      } else {
        request.setAttribute("errorMessage", "Invalid username or password");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/login.jsp");
        dispatcher.forward(request, response);
      }
    } catch (SQLException err) {
      err.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occured.");
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
    }
  }
}

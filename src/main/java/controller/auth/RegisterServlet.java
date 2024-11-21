package controller.auth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import model.User;
import repository.UserRepository;
import util.DBConnection;
import util.Password;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/register.jsp");
    dispatcher.forward(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String hashedPassword = Password.hashPassword(password);
    try {
      Connection connection = DBConnection.getConnection();
      UserRepository userRepository = new UserRepository(connection);

      if (userRepository.usernameExists(username)) {
        request.setAttribute("errorMessage", "Username already exists");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/register.jsp");
        dispatcher.forward(request, response);
      } else {
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(hashedPassword);

        boolean isRegistered = userRepository.registerUser(newUser);
        if (isRegistered) {
          response.sendRedirect(request.getContextPath() + "/login");
        } else {
          request.setAttribute("errorMessage", "Registration failed. Try again!");
          RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/register.jsp");
          dispatcher.forward(request, response);
        }
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

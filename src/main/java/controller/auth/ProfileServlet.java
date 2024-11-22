package controller.auth;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Deck;
import model.User;
import repository.DeckRepository;
import util.DBConnection;

@WebServlet(name = "ProfileServlet", urlPatterns = "/profile")
public class ProfileServlet extends HttpServlet {
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    if (session.getAttribute("userId") == null || session == null) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    try {
      Connection connection = DBConnection.getConnection();
      DeckRepository deckRepository = new DeckRepository(connection);
      User user = new User();
      int userId = (int) session.getAttribute("userId");
      user.setUserId(userId);
      Deck deck = new Deck();
      deck.setUserId(userId);

      List<Deck> userDecks = deckRepository.getDecksByUserId(deck);
      request.setAttribute("userDecks", userDecks);
    } catch (Exception e) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }
    RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/profile.jsp");
    dispatcher.forward(request, response);
  }
}

package controller.deck;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Deck;
import repository.DeckRepository;
import util.DBConnection;

@WebServlet(name = "DeleteDeckServlet", urlPatterns = "/decks/delete/*")
public class DeleteDeckServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String pathInfo = request.getPathInfo();
      if (pathInfo == null || pathInfo.equals("/")) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Deck not found");
        return;
      }

      int deckId = Integer.parseInt(pathInfo.substring(1));

      HttpSession session = request.getSession();
      int userId = (int) session.getAttribute("userId");

      if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
      }

      Connection connection = DBConnection.getConnection();
      DeckRepository deckRepository = new DeckRepository(connection);
      Deck deck = deckRepository.getDeckById(deckId);
      if (deck == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Deck not found");
        return;
      } else if (deck.getUserId() != userId) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "You are not authorized to delete this deck");
        return;
      } else {
        deckRepository.deleteDeck(deck);
        response.sendRedirect(request.getContextPath() + "/");
      }
    } catch (Exception e) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }
  }
}

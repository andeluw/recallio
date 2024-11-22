package controller.deck;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Deck;
import repository.DeckRepository;
import util.DBConnection;

@WebServlet(name = "SearchDeck", urlPatterns = "/decks/search")
public class SearchDeck extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String deckName = request.getParameter("deckName");
    deckName = deckName.trim();
    deckName.toLowerCase();
    String deckCategory = request.getParameter("deckCategory");
    boolean withCategory = !"All".equals(deckCategory);

    try {
      Connection connection = DBConnection.getConnection();
      DeckRepository deckRepository = new DeckRepository(connection);

      Deck deck = new Deck();
      deck.setDeckName(deckName);
      deck.setDeckCategory(deckCategory);

      List<Deck> decks = deckRepository.getDeckByName(deck, withCategory);
      request.setAttribute("decks", decks);
      request.getRequestDispatcher("/deck/search.jsp").forward(request, response);
    } catch (SQLException err) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
      return;
    } catch (Exception e) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }
  }
}

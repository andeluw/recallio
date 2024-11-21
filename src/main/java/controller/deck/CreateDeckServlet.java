package controller.deck;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Deck;
import repository.DeckRepository;
import util.DBConnection;

@WebServlet(name = "CreateDeckServlet", urlPatterns = "/decks/create")
public class CreateDeckServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    RequestDispatcher dispatcher = request.getRequestDispatcher("/deck/createdeck.jsp");
    dispatcher.forward(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String deckName = request.getParameter("deckName");
    String deckCategory = request.getParameter("deckCategory");
    String deckDescription = request.getParameter("deckDescription");

    Deck deck = new Deck();
    deck.setDeckName(deckName);
    deck.setDeckCategory(deckCategory);
    deck.setDeckDescription(deckDescription);
    deck.setUserId((int) request.getSession().getAttribute("userId"));

    try {
      Connection connection = DBConnection.getConnection();
      DeckRepository deckRepository = new DeckRepository(connection);

      int newDeckId = deckRepository.createDeck(deck);

      if (newDeckId != -1) {
        response.sendRedirect(request.getContextPath() + "/decks/detail/" + newDeckId);
      } else {
        request.setAttribute("errorMessage", "Deck creation failed. Try again!");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/deck/createdeck.jsp");
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

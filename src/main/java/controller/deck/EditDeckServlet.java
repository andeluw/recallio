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
import javax.servlet.http.HttpSession;

import model.Deck;
import repository.DeckRepository;
import util.DBConnection;

@WebServlet(name = "EditDeckServlet", urlPatterns = "/decks/edit/*")
public class EditDeckServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();

    if (session == null || session.getAttribute("userId") == null) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    int userId = (int) session.getAttribute("userId");

    try {
      String pathInfo = request.getPathInfo();
      if (pathInfo == null || pathInfo.equals("/")) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Deck not found");
        return;
      }

      int deckId = Integer.parseInt(pathInfo.substring(1));

      Connection connection = DBConnection.getConnection();
      DeckRepository deckRepository = new DeckRepository(connection);
      Deck deck = deckRepository.getDeckById(deckId);
      if (deck == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Deck not found");
        return;
      } else if (deck.getUserId() != userId) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "You are not authorized to edit this deck");
        return;
      } else {
        request.setAttribute("deck", deck);
      }
    } catch (Exception e) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }

    RequestDispatcher dispatcher = request.getRequestDispatcher("/deck/editdeck.jsp");
    dispatcher.forward(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      int deckId = Integer.parseInt(request.getParameter("deckId"));
      String deckName = request.getParameter("deckName");
      String deckCategory = request.getParameter("deckCategory");
      String deckDescription = request.getParameter("deckDescription");

      Connection connection = DBConnection.getConnection();
      DeckRepository deckRepository = new DeckRepository(connection);

      Deck deck = new Deck();
      deck.setDeckId(deckId);
      deck.setDeckName(deckName);
      deck.setDeckCategory(deckCategory);
      deck.setDeckDescription(deckDescription);

      boolean isUpdated = deckRepository.updateDeck(deck);
      if (isUpdated) {
        response.sendRedirect(request.getContextPath() + "/decks/detail/" + deckId);
      } else {
        request.setAttribute("errorMessage", "Deck update failed. Try again!");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/deck/editdeck.jsp");
        dispatcher.forward(request, response);
      }
    } catch (NumberFormatException err) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid deck id");
      return;
    } catch (SQLException err) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
      return;
    } catch (Exception e) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }
  }
}

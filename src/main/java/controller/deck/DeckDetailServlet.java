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

@WebServlet(name = "DeckDetailServlet", urlPatterns = "/decks/detail/*")
public class DeckDetailServlet extends HttpServlet {
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
      } else {
        request.setAttribute("deck", deck);

        Object sessionUserId = request.getSession().getAttribute("userId");
        if (sessionUserId != null && sessionUserId.equals(deck.getUserId())) {
          request.setAttribute("isOwner", true);
        } else {
          request.setAttribute("isOwner", false);
        }
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

    RequestDispatcher dispatcher = request.getRequestDispatcher("/deck/deckdetail.jsp");
    dispatcher.forward(request, response);
  }
}

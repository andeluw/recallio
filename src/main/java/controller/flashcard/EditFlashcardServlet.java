package controller.flashcard;

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

import model.Flashcard;
import repository.FlashcardRepository;
import util.DBConnection;

@WebServlet(name = "EditFlashcardServlet", urlPatterns = "/flashcards/edit/*")
public class EditFlashcardServlet extends HttpServlet {
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
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Flashcard not found");
        return;
      }

      int flashcardId = Integer.parseInt(pathInfo.substring(1));

      Connection connection = DBConnection.getConnection();
      FlashcardRepository flashcardRepository = new FlashcardRepository(connection);
      Flashcard flashcard = flashcardRepository.getFlashcardById(flashcardId);
      if (flashcard == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Flashcard not found");
        return;
      } else if (flashcard.getUserId() != userId) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "You are not authorized to edit this deck");
        return;
      } else {
        request.setAttribute("flashcard", flashcard);
      }
    } catch (Exception e) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }

    RequestDispatcher dispatcher = request.getRequestDispatcher("/flashcard/editflashcard.jsp");
    dispatcher.forward(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      int deckId = Integer.parseInt(request.getParameter("deckId"));
      int flashcardId = Integer.parseInt(request.getParameter("flashcardId"));
      String flashcardTitle = request.getParameter("flashcardTitle");
      String flashcardDetail = request.getParameter("flashcardDetail");

      Connection connection = DBConnection.getConnection();
      FlashcardRepository flashcardRepository = new FlashcardRepository(connection);

      Flashcard flashcard = new Flashcard();
      flashcard.setFlashcardId(flashcardId);
      flashcard.setFlashcardTitle(flashcardTitle);
      flashcard.setFlashcardDetail(flashcardDetail);

      boolean isUpdated = flashcardRepository.updateFlashcard(flashcard);
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

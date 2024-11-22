package controller.flashcard;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Flashcard;
import repository.DeckRepository;
import repository.FlashcardRepository;
import util.DBConnection;

@WebServlet(name = "DeleteFlashcardServlet", urlPatterns = "/flashcards/delete/*")
public class DeleteFlashcardServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String pathInfo = request.getPathInfo();
      if (pathInfo == null || pathInfo.equals("/")) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Flashcard not found");
        return;
      }

      int flashcardId = Integer.parseInt(pathInfo.substring(1));

      HttpSession session = request.getSession();
      int userId = (int) session.getAttribute("userId");

      if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
      }

      Connection connection = DBConnection.getConnection();
      FlashcardRepository flashcardRepository = new FlashcardRepository(connection);
      DeckRepository deckRepository = new DeckRepository(connection);

      Flashcard flashcard = flashcardRepository.getFlashcardById(flashcardId);
      if (flashcard == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Flashcard not found");
        return;
      }

      int flashcardOwnerId = deckRepository.getDeckById(flashcard.getDeckId()).getUserId();

      if (flashcardOwnerId != userId) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "You are not authorized to delete this flashcard");
        return;
      } else {
        flashcardRepository.deleteFlashcard(flashcard);
        response.sendRedirect(request.getContextPath() + "/decks/detail/" + flashcard.getDeckId());
      }
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }
  }
}

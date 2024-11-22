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
import repository.FlashcardRepository;
import util.DBConnection;

@WebServlet(name = "CreateFlashcardServlet", urlPatterns = "/flashcards/create/*")
public class CreateFlashcardServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();

    if (session == null || session.getAttribute("userId") == null) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    String title = request.getParameter("flashcardTitle");
    String detail = request.getParameter("flashcardDetail");

    try {
      String pathInfo = request.getPathInfo();
      if (pathInfo == null || pathInfo.equals("/")) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Deck not found");
        return;
      }
      int deckId = Integer.parseInt(pathInfo.substring(1));

      Connection connection = DBConnection.getConnection();
      FlashcardRepository flashcardRepository = new FlashcardRepository(connection);
      Flashcard flashcard = new Flashcard();
      flashcard.setDeckId(deckId);
      flashcard.setFlashcardTitle(title);
      flashcard.setFlashcardDetail(detail);
      boolean isCreated = flashcardRepository.createFlashcard(flashcard);
      if (isCreated) {
        response.sendRedirect(request.getContextPath() + "/decks/detail/" + deckId);
      } else {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      }

    } catch (Exception e) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }
  }
}

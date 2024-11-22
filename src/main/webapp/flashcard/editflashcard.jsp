<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Edit Flashcard</title>
  </head>
  <body>
    <h1>Edit Flashcard</h1>
    <form
      action="<%= request.getContextPath()%>/flashcards/edit/${flashcard.getFlashcardId()}"
      method="post">
      <input type="hidden" name="deckId" value="${flashcard.deckId}" />
      <input
        type="hidden"
        name="flashcardId"
        value="${flashcard.flashcardId}" />
      <div>
        <label for="flashcardTitle">Title:</label>
        <input
          type="text"
          id="flashcardTitle"
          name="flashcardTitle"
          value="${flashcard.flashcardTitle}" />
      </div>
      <div>
        <label for="flashcardDetail">Detail:</label>
        <textarea id="flashcardDetail" name="flashcardDetail" required>
${flashcard.flashcardDetail}</textarea
        >
      </div>

      <button type="submit">Save Changes</button>
    </form>
  </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Edit Deck</title>
  </head>
  <body>
    <h1>Edit Deck</h1>
    <form
      action="<%= request.getContextPath()%>/decks/edit/${deck.deckId}"
      method="post">
      <input type="hidden" name="deckId" value="${deck.deckId}" />
      <input type="hidden" name="deckUserId" value="${deck.userId}" />
      <label for="deckName">Deck Name:</label>
      <input
        type="text"
        id="deckName"
        name="deckName"
        value="${deck.deckName}"
        required />

      <div>
        <label for="deckCategory">Deck Category: </label>
        <select id="deckCategory" name="deckCategory">
            <option value="Math" ${'Math'.equals(deck.deckCategory) ? 'selected' : ''}>Math</option>
            <option value="Science" ${'Science'.equals(deck.deckCategory) ? 'selected' : ''}>Science</option>
            <option value="History" ${'History'.equals(deck.deckCategory) ? 'selected' : ''}>History</option>
            <option value="Languages" ${'Languages'.equals(deck.deckCategory) ? 'selected' : ''}>Languages</option>
            <option value="Exam-preparation" ${'Exam-prep'.equals(deck.deckCategory) ? 'selected' : ''}>Exam Preparation</option>
            <option value="Technology" ${'Technology'.equals(deck.deckCategory) ? 'selected' : ''}>Technology</option>
            <option value="Business" ${'Business'.equals(deck.deckCategory) ? 'selected' : ''}>Business</option>
            <option value="Personal" ${'Personal'.equals(deck.deckCategory) ? 'selected' : ''}>Personal</option>
        </select>
      </div>


      <label for="deckDescription">Description:</label>
      <textarea id="deckDescription" name="deckDescription" required>
${deck.deckDescription}</textarea
      >

      <button type="submit">Save Changes</button>
    </form>
  </body>
</html>

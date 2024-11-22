<%@ page session="true" %> <%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ page import="model.Flashcard" %> <%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Deck details</title>
  </head>
  <body>
    <h1>Deck details</h1>
    <div>
      <h2>${deck.deckName}</h2>
      <p>Category: ${deck.deckCategory}</p>
      <p>Description: ${deck.deckDescription}</p>
      <p>Created At: ${deck.createdAt}</p>
      <p>Updated At: ${deck.updatedAt}</p>
    </div>

    <% Boolean isOwner = (Boolean) request.getAttribute("isOwner"); if(isOwner) { %>
    <a href="${pageContext.request.contextPath}/decks/edit/${deck.deckId}">
      <button>Edit Deck</button>
    </a>
    <form action="${pageContext.request.contextPath}/decks/delete/${deck.deckId}" method="post" onsubmit="return confirmDeleteDeck()">
      <button type="submit">Delete Deck</button>
    </form>

    <button id="toggleFlashcardFormButton">Add Flashcard</button>

    <form id="addFlashcardForm" action="${pageContext.request.contextPath}/flashcards/create/${deck.deckId}" method="post" style="display: none">
      <input type="hidden" name="deckId" value="${deck.deckId}" />
      <div>
        <label for="flashcardTitle">Title:</label>
        <input type="text" id="flashcardTitle" name="flashcardTitle" required />
      </div>
      <div>
        <label for="flashcardDetail">Detail:</label>
        <textarea id="flashcardDetail" name="flashcardDetail" required></textarea>
      </div>
      <button type="submit">Create</button>
    </form>
    <% } %>

    <h2>Flashcards</h2>
    <ul>
      <%
        List<Flashcard> flashcards = ((model.Deck) request.getAttribute("deck")).getFlashcards();
        if (flashcards != null && !flashcards.isEmpty()) {
          for (Flashcard flashcard : flashcards) {
      %>
      <li>
        <strong><%= flashcard.getFlashcardTitle() %></strong><br />
        <%= flashcard.getFlashcardDetail() %>

        <% if (isOwner) { %>
        <a href="${pageContext.request.contextPath}/flashcards/edit/<%= flashcard.getFlashcardId() %>">
          <button>Edit Flashcard</button>
        </a>
        <form action="${pageContext.request.contextPath}/flashcards/delete/<%= flashcard.getFlashcardId() %>" method="post" onsubmit="return confirmDeleteFlashcard()">
          <button type="submit">Delete Flashcard</button>
        </form>
        <% } %>
      </li>
      <% 
          }
        }
      %>
    </ul>

    <script>
      function confirmDeleteDeck() {
        return confirm("Are you sure you want to delete this deck?");
      }

      function confirmDeleteFlashcard() {
        return confirm("Are you sure you want to delete this flashcard?");
      }

      const toggleFlashcardForm = document.getElementById("toggleFlashcardFormButton");
      const addFlashcardForm = document.getElementById("addFlashcardForm");
      toggleFlashcardForm.addEventListener("click", () => {
        addFlashcardForm.style.display = addFlashcardForm.style.display === "none" ? "block" : "none";
      });
    </script>
  </body>
</html>

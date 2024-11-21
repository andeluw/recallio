<%@ page session="true" %> <%@ page language="java" contentType="text/html;
charset=UTF-8" %>

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
    <% Boolean isOwner = (Boolean) request.getAttribute("isOwner"); if(isOwner)
    { %>
    <a href="${pageContext.request.contextPath}/decks/edit/${deck.deckId}">
      <button>Edit Deck</button>
    </a>
    <form
      action="${pageContext.request.contextPath}/decks/delete/${deck.deckId}"
      method="post"
      onsubmit="return confirmDelete()">
      <button type="submit">Delete Deck</button>
    </form>

    <script>
      function confirmDelete() {
        return confirm("Are you sure you want to delete this deck?");
      }
    </script>
    <% } %>
  </body>
</html>

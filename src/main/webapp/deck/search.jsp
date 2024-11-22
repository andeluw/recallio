<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Deck" %>
<%@ page import="java.util.List" %> 

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Search Results</title>
</head>
<body>
  <h2>Search Results</h2>
  
  <%
    List<Deck> decks = (List<Deck>) request.getAttribute("decks");
    if (decks != null && !decks.isEmpty()) {
  %>
    <ul>
    <% for (Deck deck : decks) { %>
      <li>
        <strong><%= deck.getDeckName() %></strong><br>
        Category: <%= deck.getDeckCategory() %><br>
        Description: <%= deck.getDeckDescription() %><br>
        Created At: <%= deck.getCreatedAt() %><br>
        <a href="<%= request.getContextPath() %>/decks/detail/<%= deck.getDeckId() %>">View Deck</a>
      </li>
    <% } %>
    </ul>
  <%
    } else {
  %>
    <p>No decks found matching your search.</p>
  <%
    }
  %>
  
</body>
</html>

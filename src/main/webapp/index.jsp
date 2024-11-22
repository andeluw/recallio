<%@ include file="/components/navbar.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Deck, java.util.List, repository.DeckRepository, java.sql.Connection, util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Recallio | Home</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/styles.css">
</head>
<body class="bg-darkPrimary text-white font-sans">

<div class="container mx-auto p-6">
  <h2 class="text-3xl font-semibold mb-4 text-lightPrimary">Search</h2>
  <form action="<%= request.getContextPath() %>/decks/search" method="get" class="mb-8 bg-darkSecondary p-4 rounded-lg">
    <div class="mb-4">
      <input type="text" name="deckName" placeholder="Search decks by name" class="w-full px-4 py-2 bg-darkPrimary border border-highlight rounded text-white">
    </div>
    <div class="mb-4">
      <label for="deckCategory" class="block mb-2 text-white">Deck Category</label>
      <select id="deckCategory" name="deckCategory" class="w-full px-4 py-2 bg-darkPrimary border border-highlight rounded text-white">
        <option value="All">All</option>
        <option value="Math">Math</option>
        <option value="Science">Science</option>
        <option value="History">History</option>
        <option value="Languages">Languages</option>
        <option value="Exam-preparation">Exam Preparation</option>
        <option value="Technology">Technology</option>
        <option value="Business">Business</option>
        <option value="Personal">Personal</option>
      </select>
    </div>
    <button type="submit" class="px-6 py-2 bg-highlight text-darkPrimary font-bold rounded">Search</button>
  </form>

  <h2 class="text-3xl font-semibold mb-4 text-lightPrimary">All Decks</h2>
  <%
    List<Deck> allDecks = null;
    try {
      Connection connection = DBConnection.getConnection();
      DeckRepository deckRepository = new DeckRepository(connection);
      allDecks = deckRepository.getAllDecks();
    } catch (Exception e) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
      return;
    }
  %>
  <div class="bg-darkSecondary p-4 rounded-lg">
    <% if (allDecks != null && !allDecks.isEmpty()) { %>
      <ul class="space-y-4">
        <% for (Deck deck : allDecks) { %>
          <!-- Make the entire deck card clickable -->
          <a href="<%= request.getContextPath() %>/decks/detail/<%= deck.getDeckId() %>" class="block p-4 bg-darkPrimary border border-highlight rounded hover:bg-accentDark">
            <strong class="block text-xl mb-2 text-lightPrimary"><%= deck.getDeckName() %></strong>
            <span class="text-lightPrimary">Category: <%= deck.getDeckCategory() %></span><br>
            <span class="text-lightPrimary">Description: <%= deck.getDeckDescription() %></span><br>
            <span class="text-lightPrimary">Created At: <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(deck.getCreatedAt()) %></span><br>
          </a>
        <% } %>
      </ul>
    <% } else { %>
      <p class="text-lightPrimary">No decks found.</p>
    <% } %>
  </div>
</div>

</body>
</html>

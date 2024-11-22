<%@ include file="/components/navbar.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Deck, java.util.List, repository.DeckRepository, java.sql.Connection, util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home | Recallio</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://kit.fontawesome.com/6f244e0a23.js" crossorigin="anonymous"></script>
  <style>
    ::-webkit-scrollbar {
      width: 8px;
    }
    ::-webkit-scrollbar-track {
      background: #1e1e1e;
    }
    ::-webkit-scrollbar-thumb {
      background: #575757;
      border-radius: 4px;
    }
    ::-webkit-scrollbar-thumb:hover {
      background: #6b6b6b;
    }
  </style>
</head>
<body class="bg-zinc-950 text-white font-sans">
  <div class="mx-auto p-6">
    <form action="<%= request.getContextPath() %>/decks/search" method="get" class="mb-8 p-6 rounded-lg shadow-xl">
      <h2 class="text-3xl font-semibold mb-4 text-white ml-2">Search Decks</h2>
      <div class="mb-4">
        <label for="deckName" class="block mb-2 text-white ml-2 text-base font-medium">Deck Name</label>
        <input
          id="deckName"
          name="deckName"
          required
          placeholder="Search decks by name"
          class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"/>
      </div>
      <div class="mb-4">
        <label for="deckCategory" class="block mb-2 text-white ml-2 text-base font-medium">Deck Category</label>
        <select id="deckCategory" name="deckCategory" class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent px-1">
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
      <button type="submit" class="w-full px-6 py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-bold rounded-lg transition duration-300 flex justify-center">
        <div class="flex gap-3 items-center">
          <p class="text-base">Search</p>
          <i class="fa-solid fa-magnifying-glass text-white text-xs mt-1"></i>
        </div>
      </button>
    </form>

    
    <div class="p-6">
      <div class="flex justify-between items-center mb-6">
        <h2 class="text-3xl font-semibold text-white ml-2">All Decks</h2>
        <a href="<%= request.getContextPath() %>/decks/create" class="px-6 py-3 flex gap-2 bg-violet-800 text-white rounded-md hover:bg-violet-900 transition-colors font-semibold items-center">
          <p>Create Deck</p>
          <i class="fa-solid fa-plus text-white"></i>
        </a>
      </div>
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
      <% 
        if (allDecks != null && !allDecks.isEmpty()) {
      %>
        <div class="space-y-6">
          <% for (Deck deck : allDecks) { %>
            <div class="p-6 bg-zinc-900 border border-zinc-700 rounded-lg shadow-md hover:shadow-xl hover:bg-zinc-800 transition-all">
              <a href="<%= request.getContextPath() %>/decks/detail/<%= deck.getDeckId() %>" class="block">
                <strong class="text-xl text-white block mb-2"><%= deck.getDeckName() %></strong>
                <div class="flex gap-2 items-center mb-4">
                  <p class="text-zinc-300 text-sm font-normal"><%= new java.text.SimpleDateFormat("dd MMMM yyyy").format(deck.getCreatedAt()) %></p>
                  <div class="rounded-full px-3 py-1 bg-indigo-700">
                    <p class="text-white text-xs font-medium"><%= deck.getDeckCategory() %></p>
                  </div>
                </div>
                <p class="text-zinc-200 text-base mb-2 font-medium"><%= deck.getDeckDescription() %></p>
              </a>
            </div>
          <% } %>
        </div>
      <% } else { %>
        <p class="text-zinc-200 text-center text-base font-medium">You haven't created any decks yet. Start building your first deck!</p>
      <% } %>
    </div>
  </div>

</body>
</html>

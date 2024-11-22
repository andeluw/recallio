<%@ include file="/components/navbar.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Deck, java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Search Results | Recallio</title>
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
    <div class="mb-8 p-6">
      <h2 class="text-3xl font-semibold mb-8 text-white text-center">Search Results</h2>
      <% 
        List<Deck> decks = (List<Deck>) request.getAttribute("decks");
        if (decks != null && !decks.isEmpty()) {
      %>
      <div class="space-y-6">
        <% for (Deck deck : decks) { %>
        <div class="p-6 bg-zinc-900 border border-zinc-700 rounded-lg shadow-md hover:shadow-xl hover:bg-zinc-800 transition-all">
          <a href="<%= request.getContextPath() %>/decks/detail/<%= deck.getDeckId() %>" class="block">
            <h3 class="text-xl font-semibold text-white mb-2"><%= deck.getDeckName() %></h3>
            <div class="flex gap-2 items-center mb-4">
              <p class="text-zinc-300 text-sm"><%= new java.text.SimpleDateFormat("dd MMM yyyy").format(deck.getCreatedAt()) %></p>
              <div class="px-3 py-1 rounded-full bg-indigo-700">
                <p class="text-white text-xs font-medium"><%= deck.getDeckCategory() %></p>
              </div>
            </div>
            <p class="text-zinc-200 text-base font-medium mb-4"><%= deck.getDeckDescription() %></p>
          </a>
        </div>
        <% } %>
      </div>
      <% } else { %>
      <p class="text-center text-zinc-200 text-base font-medium">No decks found matching your search criteria.</p>
      <% } %>
    </div>
  </div>
</body>
</html>

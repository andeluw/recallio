<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 

<%
  if (session == null || session.getAttribute("username") == null) { 
    response.sendRedirect(request.getContextPath() + "/login"); 
    return;
  }
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create a New Deck | Recallio</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
  <body class="bg-zinc-950">
    <div class="flex items-center justify-center p-10">
      <div class="bg-zinc-900 p-10 rounded-xl shadow-xl w-4/5 max-sm:w-4/5">
        <div class="text-center mb-6">
          <h1 class="text-3xl font-bold text-white">Create a New Deck</h1>
          <p class="text-zinc-400 text-sm mt-2 font-medium">
            Add a new flashcard deck to your collection.
          </p>
        </div>

        <form action="<%= request.getContextPath() %>/decks/create" method="post" class="space-y-6">
          <div>
            <label for="deckName" class="block text-base text-white mb-2 font-semibold ml-2">Deck Name</label>
            <textarea
              name="deckName"
              id="deckName"
              rows="2"
              required
              placeholder="Enter a unique deck name"
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"
            ></textarea>
          </div>

          <div>
            <label for="deckCategory" class=" ml-2 block text-base text-white mb-2 font-semibold">Choose a Category</label>
            <select
              id="deckCategory"
              name="deckCategory"
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"
            >
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

          <div>
            <label for="deckDescription" class="block text-base text-white mb-2 font-semibold ml-2">Deck Description</label>
            <textarea
              name="deckDescription"
              id="deckDescription"
              rows="8"
              required
              placeholder="Provide a brief description of your deck"
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"
            ></textarea>
          </div>

          <div>
            <button
              type="submit"
              class="w-full px-6 py-3 bg-indigo-600 text-white font-semibold rounded-md hover:bg-indigo-700 transition-colors"
            >
              Create Deck
            </button>
          </div>
        </form>

        <% 
          String errorMessage = (String) request.getAttribute("errorMessage");
          if (errorMessage != null) { 
        %>
          <div class="mt-6 p-4 bg-red-500 text-white text-center rounded-md">
            <p><%= errorMessage %></p>
          </div>
        <% } %>
      </div>
    </div>
  </body>
</html>

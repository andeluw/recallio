<%@ include file="/components/navbar.jsp" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="model.Deck" %>
<%@ page import="java.util.List" %>

<%
  if (session == null || session.getAttribute("username") == null) { 
    response.sendRedirect(request.getContextPath() + "/login"); 
    return;
  }

  String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile | Recallio</title>
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
    <div class="flex items-center justify-center p-10">
      <div>
        <div class="">
          <div class="text-center mb-6 w-full">
            <h1 class="text-4xl font-bold text-white">Hello, <%= session.getAttribute("username") %>!</h1>
            <p class="text-zinc-300 text-base mt-4 font-medium">
              "Welcome back! Manage your decks, track progress, and explore new features!"
            </p>
          </div>
  
          <div class="flex justify-center">
            <button id="logoutBtn" class="px-8 py-3 bg-indigo-600 text-white rounded-full hover:bg-indigo-800 transition-all font-semibold">
              Logout
            </button>
          </div>
        </div>
  
        <% if (errorMessage != null) { %>
          <p class="text-red-500 text-center mt-4 text-sm"><%= errorMessage %></p>
        <% } %>
  
        <div id="logoutModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
          <div class="bg-zinc-900 p-8 rounded-xl text-center">
            <h2 class="text-2xl text-zinc-100 mb-4 font-medium">Are you sure you want to log out?</h2>
            <div class="flex justify-center space-x-6">
              <button id="cancelLogout" class="px-6 py-3 bg-zinc-700 text-zinc-100 rounded-xl hover:bg-zinc-600 transition-all font-semibold">Cancel</button>
              <button id="confirmLogout" class="px-6 py-3 bg-blue-800 text-white rounded-xl hover:bg-blue-900 transition-all font-semibold">Logout</button>
            </div>
          </div>
        </div>
  
        <div class="mt-8 w-full mx-0">
          <div class="flex justify-between items-center mb-2 gap-6">
            <div>
              <h2 class="text-3xl font-bold text-white ml-2">Your Decks</h2>
              <p class="text-md text-zinc-400 mb-6 font-medium ml-2 mt-2">Manage, view, and track your progress with your personalized decks. Create new ones to continue building your collection!</p>
            </div>
            <a href="<%= request.getContextPath() %>/decks/create" class="px-6 py-3 flex gap-2 bg-violet-800 text-white rounded-md hover:bg-violet-900 transition-colors font-semibold items-center">
              <p>Create Deck</p>
              <i class="fa-solid fa-plus text-white"></i>
            </a>
          </div>
  
          <% 
            List<Deck> userDecks = (List<Deck>) request.getAttribute("userDecks");
            if (userDecks != null && !userDecks.isEmpty()) {
          %>
            <div class="space-y-6">
              <% for (Deck deck : userDecks) { %>
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
            <p class="text-zinc-200 ml-2">You haven't created any decks yet. Start building your first deck!</p>
          <% } %>
        </div>
      </div>
    </div>

    <script>
      document.getElementById("logoutBtn").onclick = function () {
        document.getElementById("logoutModal").style.display = "flex";
      };

      document.getElementById("confirmLogout").onclick = function () {
        window.location.href = "<%= request.getContextPath() %>/logout";
      };

      document.getElementById("cancelLogout").onclick = function () {
        document.getElementById("logoutModal").style.display = "none";
      };
    </script>
  </body>
</html>

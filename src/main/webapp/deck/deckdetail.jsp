<%@ include file="/components/navbar.jsp" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Flashcard" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Deck Details | Recallio</title>
    <script src="https://kit.fontawesome.com/6f244e0a23.js" crossorigin="anonymous"></script>
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
  <body class="bg-zinc-950 text-white font-sans">
    <div class="mx-auto py-6 px-12 mb-10">
      <div class="p-6 text-center flex flex-col justify-center items-center border-white">
        <h1 class="text-3xl font-semibold mb-6 ml-2">Deck Details</h1>
        <h2 class="text-4xl font-bold mb-4 text-white"><%= ((model.Deck)request.getAttribute("deck")).getDeckName() %></h2>
        <div class="rounded-full px-4 py-2 bg-indigo-700 mb-3">
          <p class="text-white text-base font-medium">Category: <%= ((model.Deck)request.getAttribute("deck")).getDeckCategory() %></p>
        </div>
        <p class="text-zinc-300 text-base font-normal mb-4">Created on: <%= new java.text.SimpleDateFormat("dd MMMM yyyy").format(((model.Deck)request.getAttribute("deck")).getCreatedAt()) %>. Last modified on: <%= new java.text.SimpleDateFormat("dd MMMM yyyy").format(((model.Deck)request.getAttribute("deck")).getUpdatedAt()) %>.</p>
        <p class="text-zinc-300 text-base font-medium mb-2"><%= ((model.Deck)request.getAttribute("deck")).getDeckDescription() %></p>

        <% Boolean isOwner = (Boolean) request.getAttribute("isOwner"); if (isOwner) { %>
          <div class="flex gap-4 mb-6 mt-4">
            <a href="<%= request.getContextPath() %>/decks/edit/<%= ((model.Deck)request.getAttribute("deck")).getDeckId() %>" class="flex items-center gap-2 px-6 py-3 bg-blue-800 hover:bg-blue-900 rounded-lg text-white transition duration-300 font-semibold">
              <p>Edit Deck</p>
              <i class="fa-solid fa-pencil text-white"></i>
            </a>
            <form action="<%= request.getContextPath() %>/decks/delete/<%= ((model.Deck)request.getAttribute("deck")).getDeckId() %>" method="post" onsubmit="return confirmDeleteDeck()" class="m-0">
              <button type="submit" class="flex items-center gap-2 px-6 py-3 bg-red-600 hover:bg-red-700 rounded-lg text-white transition duration-300 font-semibold">
                <p>Delete Deck</p>
                <i class="fa-solid fa-trash text-white"></i>
              </button>
            </form>
          </div>
        <% } %>
      </div>

      <div class="flex justify-between mt-12 mb-2 items-center">
        <h2 class="text-3xl font-semibold ml-2">Flashcards</h2>
        <% if (isOwner) { %>
          <div class="">
            <button id="toggleFlashcardFormButton" class="flex items-center gap-2 px-6 py-3 bg-violet-800 hover:bg-violet-900 rounded-lg text-white transition duration-300 font-semibold justify-center">
              <p id="toggleButtonText">Add Flashcard</p>
              <i id="toggleButtonIcon" class="fa-solid fa-plus text-white"></i>
            </button>
          </div>
        <% } %>
      </div>
      <% if (isOwner) { %>
        <div>
          <form id="addFlashcardForm" action="<%= request.getContextPath() %>/flashcards/create/<%= ((model.Deck)request.getAttribute("deck")).getDeckId() %>" method="post" style="display: none;" class="space-y-3 mb-6 mt-2">
            <div>
              <label for="flashcardTitle" class="block text-base mb-2 text-white ml-2 font-medium">Title</label>
              <input type="text" id="flashcardTitle" name="flashcardTitle" required class="w-full px-4 py-3 bg-zinc-900 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Enter flashcard title" />
            </div>
            <div>
              <label for="flashcardDetail" class="block text-base mb-2 text-white ml-2 font-medium">Detail</label>
              <textarea id="flashcardDetail" name="flashcardDetail" required class="w-full px-4 py-3 bg-zinc-900 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Enter flashcard details"></textarea>
            </div>
            <button type="submit" class="w-full px-6 py-3 bg-indigo-600 hover:bg-indigo-700 rounded-lg text-white transition duration-300 font-semibold mb-6 mt-2">Create Flashcard</button>
          </form>
        </div>
      <% } %>
      <ul class="space-y-6 mt-4">
        <% 
          List<Flashcard> flashcards = ((model.Deck) request.getAttribute("deck")).getFlashcards();
          if (flashcards != null && !flashcards.isEmpty()) {
            for (Flashcard flashcard : flashcards) {
        %>
          <li class="p-6 bg-zinc-900 border border-zinc-700 rounded-lg shadow-md flex justify-between items-center hover:bg-zinc-800 transition duration-300">
            <div>
              <strong class="text-lg text-white"><%= flashcard.getFlashcardTitle() %></strong>
              <p class="text-zinc-300 mt-2"><%= flashcard.getFlashcardDetail() %></p>
            </div>

            <% if (isOwner) { %>
              <div class="relative group">
                <i class="fa-solid fa-ellipsis-vertical text-zinc-300 hover:text-zinc-500 cursor-pointer ml-2"></i>
                <div class="absolute right-0 mt-3 w-40 bg-zinc-900 border border-zinc-700 text-white rounded-md shadow-lg opacity-0 group-hover:opacity-100 transition-all duration-300">
                  <a href="<%= request.getContextPath() %>/flashcards/edit/<%= flashcard.getFlashcardId() %>" class="block px-4 py-2 hover:bg-zinc-800">Edit</a>
                  <form action="<%= request.getContextPath() %>/flashcards/delete/<%= flashcard.getFlashcardId() %>" method="post" onsubmit="return confirmDeleteFlashcard()" class="m-0">
                    <button type="submit" class="block w-full text-left px-4 py-2 hover:bg-zinc-800">Delete</button>
                  </form>
                </div>
              </div>
            <% } %>
          </li>
        <% 
            }
          } else { 
        %>
          <p class="text-center text-zinc-300">No flashcards available. Start adding new flashcards!</p>
        <% } %>
      </ul>
    </div>

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
        const isFormVisible = addFlashcardForm.style.display === "block";
        addFlashcardForm.style.display = isFormVisible ? "none" : "block";

        toggleFlashcardForm.innerHTML = isFormVisible
          ? `<p>Add Flashcard</p><i class="fa-solid fa-plus text-white"></i>`
          : `<p>Cancel</p><i class="fa-solid fa-times text-white"></i>`;

        toggleFlashcardForm.classList.toggle("bg-violet-800", isFormVisible);
        toggleFlashcardForm.classList.toggle("bg-zinc-800", !isFormVisible);
        toggleFlashcardForm.classList.toggle("hover:bg-violet-900", isFormVisible);
        toggleFlashcardForm.classList.toggle("hover:bg-zinc-900", !isFormVisible);
      });
    </script>
  </body>
</html>

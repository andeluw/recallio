<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include
file="/components/navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Flashcard | Recallio</title>
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
          <h1 class="text-3xl font-bold text-white">Edit Flashcard</h1>
          <p class="text-zinc-400 text-sm mt-2 font-medium">
            Update the details of your flashcard.
          </p>
        </div>

        <form
          action="<%= request.getContextPath() %>/flashcards/edit/${flashcard.getFlashcardId()}"
          method="post"
          class="space-y-6">
          <input type="hidden" name="deckId" value="${flashcard.deckId}" />
          <input
            type="hidden"
            name="flashcardId"
            value="${flashcard.flashcardId}" />

          <div>
            <label
              for="flashcardTitle"
              class="block text-base text-white mb-2 font-semibold ml-2">
              Flashcard Title
            </label>
            <textarea
              id="flashcardTitle"
              name="flashcardTitle"
              required
              placeholder="Enter flashcard title"
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"
              rows="3">${flashcard.flashcardTitle}
            </textarea>
          </div>

          <div>
            <label
              for="flashcardDetail"
              class="block text-base text-white mb-2 font-semibold ml-2">
              Detail
            </label>
            <textarea
              id="flashcardDetail"
              name="flashcardDetail"
              required
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"
              rows="8"
              placeholder="Enter flashcard detail">${flashcard.flashcardDetail}
            </textarea>
          </div>

          <div>
            <button
              type="submit"
              class="w-full px-6 py-3 bg-indigo-600 text-white font-semibold rounded-md hover:bg-indigo-700 transition-colors">
              Save Changes
            </button>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>

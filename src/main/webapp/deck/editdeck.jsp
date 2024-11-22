<%@ include file="/components/navbar.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Deck | Recallio</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
      ::-webkit-scrollbar {
        width: 8px;
        height: 8px;
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
          <h1 class="text-3xl font-bold text-white">Edit Your Deck</h1>
          <p class="text-zinc-400 text-sm mt-2 font-medium">
            Update the details of your flashcard deck.
          </p>
        </div>

        <form action="<%= request.getContextPath()%>/decks/edit/${deck.deckId}" method="post" class="space-y-6">
          <input type="hidden" name="deckId" value="${deck.deckId}" />
          <input type="hidden" name="deckUserId" value="${deck.userId}" />

          <div>
            <label for="deckName" class="block text-base text-white mb-2 font-semibold ml-2">Deck Name</label>
            <textarea
              id="deckName"
              name="deckName"
              required
              placeholder="Enter deck name"
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"
              rows="2"
            >${deck.deckName}</textarea>
          </div>

          <div>
            <label for="deckCategory" class="block text-base text-white mb-2 font-semibold ml-2">Category</label>
            <select
              id="deckCategory"
              name="deckCategory"
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"
            >
              <option value="Math" ${'Math'.equals(deck.deckCategory) ? 'selected' : ''}>Math</option>
              <option value="Science" ${'Science'.equals(deck.deckCategory) ? 'selected' : ''}>Science</option>
              <option value="History" ${'History'.equals(deck.deckCategory) ? 'selected' : ''}>History</option>
              <option value="Languages" ${'Languages'.equals(deck.deckCategory) ? 'selected' : ''}>Languages</option>
              <option value="Exam-preparation" ${'Exam-prep'.equals(deck.deckCategory) ? 'selected' : ''}>Exam Preparation</option>
              <option value="Technology" ${'Technology'.equals(deck.deckCategory) ? 'selected' : ''}>Technology</option>
              <option value="Business" ${'Business'.equals(deck.deckCategory) ? 'selected' : ''}>Business</option>
              <option value="Personal" ${'Personal'.equals(deck.deckCategory) ? 'selected' : ''}>Personal</option>
            </select>
          </div>

          <div>
            <label for="deckDescription" class="block text-base text-white mb-2 font-semibold ml-2">Description</label>
            <textarea
              id="deckDescription"
              name="deckDescription"
              required
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-500 focus:border-transparent"
              rows="8"
              placeholder="Describe your deck's content"
            >${deck.deckDescription}</textarea>
          </div>

          <div>
            <button
              type="submit"
              class="w-full px-6 py-3 bg-indigo-600 text-white font-semibold rounded-md hover:bg-indigo-700 transition-colors"
            >
              Save Changes
            </button>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>

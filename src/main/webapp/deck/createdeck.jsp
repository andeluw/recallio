<%@ page session="true" %> <%@ page language="java" contentType="text/html;
charset=UTF-8" %> <% if(session == null || session.getAttribute("username") ==
null){ response.sendRedirect(request.getContextPath() + "/login"); } %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create Deck</title>
  </head>
  <body>
    <h1>Create Deck</h1>
    <div>
      <form action="<%= request.getContextPath()%>/decks/create" method="post">
        <div>
          <label for="deckName">Deck Name: </label>
          <input
            type="text"
            name="deckName"
            id="deckName"
            required
            placeholder="Enter deck name" />
        </div>

        <div>
          <label for="deckCategory">Deck Category: </label>
          <select id="deckCategory" name="deckCategory">
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
          <label for="deckDescription">Deck Description: </label>
          <textarea
            name="deckDescription"
            id="deckDescription"
            required
            placeholder="Enter description"
            rows="4"
            cols="50">
          </textarea>
        </div>

        <button type="submit">Create Deck</button>
      </form>

      <c:if test="${not empty errorMessage}">
        <p>${errorMessage}</p>
      </c:if>
    </div>
  </body>
</html>

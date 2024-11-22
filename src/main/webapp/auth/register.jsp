<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up</title>
  </head>
  <body>
    <h1>Sign Up</h1>
    <div>
      <form action="<%= request.getContextPath()%>/register" method="post">
        <div>
          <label for="username">Username: </label>
          <input
            type="text"
            name="username"
            id="username"
            minlength="5"
            required
            pattern="^[A-Za-z0-9]+$"
            title="Username can only contain letters and numbers" />
        </div>

        <div>
          <label for="password">Password:</label>
          <input
            type="password"
            name="password"
            id="password"
            minlength="8"
            required
            pattern="^[A-Za-z0-9@!%*?&]+$"
            title="Password must contain only letters, numbers, and special characters, and be at least 8 characters long" />
        </div>

        <button type="submit">Sign up</button>
      </form>

      <c:if test="${not empty errorMessage}">
        <p>${errorMessage}</p>
      </c:if>
    </div>
  </body>
</html>

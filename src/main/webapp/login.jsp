<%@ page session="true" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 

<%
  if(session.getAttribute("username") != null){ 
    response.sendRedirect("profile.jsp"); 
  }
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up</title>
  </head>
  <body>
    <h1>Login</h1>
    <div>
      <form action="/recallio/login" method="post">
        <div>
          <label for="username">Username: </label>
          <input
            type="text"
            name="username"
            id="username"
            required
            placeholder="Enter your username" />
        </div>

        <div>
          <label for="password">Password:</label>
          <input
            type="password"
            name="password"
            id="password"
            required
            placeholder="Enter your password" />
        </div>

        <button type="submit">Login</button>
      </form>

      <c:if test="${not empty errorMessage}">
        <p>${errorMessage}</p>
      </c:if>
    </div>
  </body>
</html>

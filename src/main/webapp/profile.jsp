<%@ page session="true" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 

<%
  if(session == null || session.getAttribute("username") == null){ 
    response.sendRedirect("login.jsp"); 
  }
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home</title>
  </head>
  <body>
    <h1>Welcome, <%= session.getAttribute("username") %>!</h1>
    <!-- Logout Button -->
    <button id="logoutBtn">Logout</button>

    <!-- Logout Confirmation Modal -->
    <div id="logoutModal" style="display: none">
      <div>
        <h2>Are you sure you want to log out?</h2>
        <button id="confirmLogout">Yes</button>
        <button id="cancelLogout">Cancel</button>
      </div>
    </div>

    <script>
      // Show the modal
      document.getElementById("logoutBtn").onclick = function () {
        document.getElementById("logoutModal").style.display = "block";
      };

      // Handle logout confirmation
      document.getElementById("confirmLogout").onclick = function () {
        window.location.href = "logout"; // Redirect to the logout servlet
      };

      // Cancel logout
      document.getElementById("cancelLogout").onclick = function () {
        document.getElementById("logoutModal").style.display = "none";
      };
    </script>
  </body>
</html>

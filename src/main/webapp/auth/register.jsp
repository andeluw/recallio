<%@ include file="/components/navbar.jsp" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% if (session.getAttribute("username") != null) {
  response.sendRedirect(request.getContextPath() + "/profile"); return;
} 
String errorMessage = (String) request.getAttribute("errorMessage"); %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up | Recallio</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-zinc-950">
    <div class="flex items-center justify-center p-10">
      <div class="bg-zinc-900 p-10 rounded-xl shadow-xl w-full sm:w-[450px] max-w-md">
        <div class="text-center mb-6">
          <h1 class="text-3xl font-semibold text-white font-bold">Sign Up</h1>
          <p class="text-zinc-400 text-sm mt-2 font-medium">Sign up to access your personal dashboard.</p>
        </div>

        <form action="<%= request.getContextPath() %>/register" method="post" class="space-y-6">
          <div>
            <label for="username" class="block text-base text-white mb-2 font-semibold">Username</label>
            <input type="text" name="username" id="username" minlength="5" required pattern="^[A-Za-z0-9]+$"
              title="Username can only contain letters and numbers" placeholder="Enter your username"
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700" />
          </div>

          <div>
            <label for="password" class="block text-base text-white mb-2 font-semibold">Password</label>
            <input type="password" name="password" id="password" minlength="8" required pattern="^[A-Za-z0-9@!%*?&]+$"
              title="Password must contain only letters, numbers, and special characters, and be at least 8 characters long"
              placeholder="Enter your password"
              class="w-full px-4 py-3 bg-zinc-950 border border-zinc-700 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-zinc-700 focus:border-zinc-700" />
          </div>

          <button type="submit"
            class="w-full px-6 py-3 bg-indigo-600 text-white font-semibold rounded-md hover:bg-indigo-700 transition-colors">Sign Up</button>
        </form>

        <% if (errorMessage != null) { %>
        <p class="text-red-600 text-center mt-4 text-sm"><%= errorMessage %></p>
        <% } %>

        <div class="text-center mt-6">
          <p class="text-zinc-400 text-sm font-medium">Already have an account?
            <a href="<%= request.getContextPath() %>/login" class="text-indigo-600 hover:text-indigo-800 font-semibold">Log in</a>
          </p>
        </div>
      </div>
    </div>
  </body>
</html>

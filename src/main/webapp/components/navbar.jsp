<%@ page session="true" %>

<nav class="bg-slate-950 text-white px-8 py-6">
  <div class="flex justify-between items-center font-sans">
    <a
      href="<%= request.getContextPath() %>/"
      class="text-2xl font-bold text-white italic"
      >Recallio.</a
    >
    <ul class="flex space-x-8 font-semibold mr-6 text-lg">
      <li>
        <a href="<%= request.getContextPath() %>/" class="hover:text-slate-300"
          >Home</a
        >
      </li>

      <% if (session.getAttribute("userId") != null) { %>
      <li>
        <a
          href="<%= request.getContextPath() %>/profile"
          class="hover:text-slate-300"
          >Profile</a
        >
      </li>
      <% } else { %>
      <li>
        <a
          href="<%= request.getContextPath() %>/login"
          class="hover:text-slate-300"
          >Login</a
        >
      </li>
      <% } %>
    </ul>
  </div>
</nav>

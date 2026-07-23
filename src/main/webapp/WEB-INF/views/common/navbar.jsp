<!--============================== NAVBAR ============= -->

<nav class="navbar">

    <div class="logo">
        <i class="bi bi-bar-chart-fill"></i>
        Sales Analytics Dashboard
    </div>

    <div class="nav-buttons">

        <a href="${pageContext.request.contextPath}/" class="nav-link ${activePage == 'home'?'active':''}">
            <i class="bi bi-house-fill"></i>
            Home
        </a>

        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link ${activePage == 'dashboard'?'active':''}">
            <i class="bi bi-speedometer2"></i>
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/reports" class="nav-link ${activePage == 'reports'?'active':''}">
            <i class="bi bi-file-earmark-text"></i>
            Reports
        </a>

        <a href="${pageContext.request.contextPath}/salesdata" class="nav-link ${activePage == 'salesdata'?'active':''}">
            <i class="bi bi-table"></i>
            Sales Data
        </a>

        <a href="${pageContext.request.contextPath}/about" class="nav-link ${activePage == 'about'?'active':''}">
            <i class="bi bi-info-circle"></i>
            About
        </a>

    </div>

</nav>

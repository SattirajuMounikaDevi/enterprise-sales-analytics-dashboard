<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>Sales Analytics Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/style.css">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<jsp:include page="common/navbar.jsp"/>

<!-- ================= HERO ================= -->

<section class="hero">

    <div class="hero-left">

        <h4>Welcome to</h4>

        <h2>
            Sales Performance Analytics Dashboard
        </h2>

        <p>
            Transform raw sales data into actionable business insights
            using interactive dashboards, real-time KPIs and comprehensive
            reporting.
        </p>

    </div>

    <div class="hero-right">

        <!-- Dashboard Illustration -->
        <img src="/images/icons/dashboard.jpeg"
             alt="Sales Dashboard"
             class="dashboard-image">

    </div>

</section>

<!-- ================= KPI CARDS ================= -->

<div class="cards">

    <div class="card">
        <div class="kpi-title">

        <i class="bi bi-currency-dollar"></i>
        <h5>Total Sales</h5>
        </div>

        <h2>$ <fmt:formatNumber value="${totalSales}" type="number" maxFractionDigits="2"/></h2>

    </div>

    <div class="card">
        <div class="kpi-title">

        <i class="bi bi-cart-fill"></i>
        <h5>Total Quantity</h5>
        </div>

        <h2> <fmt:formatNumber value="${totalQuantity}" type="number"/></h2>

    </div>

    <div class="card">
        <div class="kpi-title">

        <i class="bi bi-graph-up-arrow"></i>
        <h5>Total Profit</h5>
        </div>

        <h2>$ <fmt:formatNumber value="${totalProfit}" type="number" maxFractionDigits="2"/></h2>

    </div>

    <div class="card">
        <div class="kpi-title">

        <i class="bi bi-people-fill"></i>
        <h5>Total Customers</h5>
        </div>

        <h2>${totalCustomers}</h2>


    </div>

</div>

<!-- ================= FOOTER ================= -->

<footer>

    © 2026 Sales Analytics Dashboard |
    Built using Spring Boot + JSP + PostgreSQL

</footer>

</body>

</html>
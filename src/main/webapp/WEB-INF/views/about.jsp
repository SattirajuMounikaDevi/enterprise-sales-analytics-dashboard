<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>About</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet" href="${pageContent.request.contextPath}/css/style.css">

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


</head>

<!--============================== NAVBAR ============= -->

<jsp:include page="common/navbar.jsp"/>

<div class="container mt-4">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">

            <h3>
                <i class="bi bi-info-circle-fill"></i>
                About This Project
            </h3>

        </div>

        <div class="card-body">

            <h4 class="text-primary">
                Enterprise Sales Analytics Dashboard
            </h4>

            <hr>

            <p class="fs-5">

                The Enterprise Sales Analytics Dashboard is a web-based
                Business Intelligence application developed using Java,
                Spring Boot, JSP, Bootstrap and PostgreSQL.

                The application enables users to analyze sales performance
                through interactive dashboards, reports, maps, charts,
                filters and Excel export functionality.

            </p>

            <hr>

            <h5 class="text-success">
                <i class="bi bi-bullseye"></i>
                Project Objective
            </h5>

            <p>

                To help organizations monitor sales performance,
                identify trends, analyze regional sales and support
                better business decisions using interactive analytics.

            </p>

            <hr>

            <h5 class="text-success">
                <i class="bi bi-stars"></i>
                Key Features
            </h5>

            <ul class="list-group mb-4">

                <li class="list-group-item">
                    📊 Interactive Dashboard
                </li>

                <li class="list-group-item">
                    📈 Sales Trend Analysis
                </li>

                <li class="list-group-item">
                    🗺️ State-wise Sales Map
                </li>

                <li class="list-group-item">
                    📑 Reports & Forecast Analysis
                </li>

                <li class="list-group-item">
                    🔍 Dynamic Filters
                </li>

                <li class="list-group-item">
                    📋 Sales Data Table
                </li>

                <li class="list-group-item">
                    📥 Export Filtered Data to Excel
                </li>

            </ul>

            <hr>

            <h5 class="text-success">
                <i class="bi bi-tools"></i>
                Technologies Used
            </h5>

            <table class="table table-bordered">

                <tr>
                    <th>Frontend</th>
                    <td>JSP, HTML, CSS, Bootstrap</td>
                </tr>

                <tr>
                    <th>Backend</th>
                    <td>Java, Spring Boot</td>
                </tr>

                <tr>
                    <th>Database</th>
                    <td>PostgreSQL</td>
                </tr>

                <tr>
                    <th>Charts</th>
                    <td>Google Charts, GeoChart</td>
                </tr>

                <tr>
                    <th>Export</th>
                    <td>Apache POI (Excel)</td>
                </tr>

            </table>

            <hr>

            <h5 class="text-success">
                <i class="bi bi-database"></i>
                Dataset
            </h5>

            <p>

                Sample Superstore Sales Dataset containing customer,
                product, category, sales, profit and regional
                information.

            </p>

            <hr>

            <h5 class="text-success">
                <i class="bi bi-person-fill"></i>
                Developed By
            </h5>

            <table class="table table-bordered">

                <tr>
                    <th>Name</th>
                    <td>Mounika Devi Sattiraju</td>
                </tr>

                <tr>
                    <th>Course</th>
                    <td>Master of Computer Applications (MCA)</td>
                </tr>

                <tr>
                    <th>Project</th>
                    <td>Enterprise Sales Analytics Dashboard</td>
                </tr>

            </table>

        </div>

    </div>

</div>

</body>
</html>
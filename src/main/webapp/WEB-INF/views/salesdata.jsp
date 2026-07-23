<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Sales Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet" href="${pageContent.request.contextPath}/css/style.css">

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <link rel="stylesheet" href="https://cdn.datatabels.net/1.13.8/css/jquery.dataTables.min.css">


</head>

<!--============================== NAVBAR ============= -->

<jsp:include page="common/navbar.jsp"/>

<!-- ===================FILTERS SECTION ============= -->
<jsp:include page="common/filters.jsp"/>

<!-- =================Export Buttons Section ====================== -->
<div class="d-flex justify-content-end mb-3">
    <a href="${pageContext.request.contextPath}/exportExcel?year=${selectedYear}&month=${selectedMonth}&state=${selectedState}&category=${selectedCategory}&subcategory=${selectedSubCategory}&segment=${selectedSegment}"
       class="btn btn-success">
        <i class="bi bi-file-earmark-excel"></i>
        Export to Excel
    </a>
</div>

<div class="table-responsive">
    <table id="salesTable" class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Order Date</th>
            <th>Customer</th>
            <th>Segment</th>
            <th>State</th>
            <th>Category</th>
            <th>Sub Category</th>
            <th>Product</th>
            <th>Sales</th>
            <th>Quantity</th>
            <th>Profit</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="sale" items="${salesData}">
            <tr>
                <td>${sale.orderId}</td>
                <td>${sale.orderDate}</td>
                <td>${sale.customerName}</td>
                <td>${sale.segment}</td>
                <td>${sale.state}</td>
                <td>${sale.category}</td>
                <td>${sale.subCategory}</td>
                <td>${sale.productName}</td>
                <td>${sale.sales}</td>
                <td>${sale.quantity}</td>
                <td>${sale.profit}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function () {
        $('#salesTable').DataTable({
            pageLength: 10,
            lengthMenu: [[10,25,50,100,-1],[10,25,50,100,"All"]]
        });
    });
</script>
</html>
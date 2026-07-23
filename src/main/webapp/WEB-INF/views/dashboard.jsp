<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Dashboard | Sales Analytics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet" href="${pageContent.request.contextPath}/css/style.css">
</head>

<!--============================== NAVBAR ============= -->

<jsp:include page="common/navbar.jsp"/>

<!-- ===================FILTERS SECTION ============= -->
<jsp:include page="common/filters.jsp"/>
<!-- ========================KPIs Section============= -->
<div class="container mt-4">

    <div class="row g-4">

        <!-- Total Sales -->
        <div class="col-lg-3 col-md-6">
            <div class="dashboard-kpi-card sales-card">

                <div class="kpi-header">
                    <div class="kpi-icon sales-icon">
                        <i class="bi bi-currency-dollar"></i>
                    </div>

                    <div>
                        <div class="kpi-title">Total Sales</div>
                    </div>
                </div>

                <div class="kpi-value">
                    $<fmt:formatNumber value="${totalSales}" type="number" maxFractionDigits="2"/>
                </div>

                <c:choose>
                    <c:when test="${salesGrowth>=0}">
                        <div class="kpi-growth positive">
                            <i class="bi bi-caret-up-fill"></i>
                            <strong>${String.format("%.2f",salesGrowth)}%</strong>
                            <span>YoY </span>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="kpi-growth-negative">
                            <i class="bi bi-caret-down-fill"></i>

                            <strong>${String.format("%.2f",Math.abs(salesGrowth))}%</strong>
                            <span>YoY </span>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <!-- Profit -->
        <div class="col-lg-3 col-md-6">
            <div class="dashboard-kpi-card profit-card">

                <div class="kpi-header">
                    <div class="kpi-icon profit-icon">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>

                    <div>
                        <div class="kpi-title">Total Profit</div>
                    </div>
                </div>

                <div class="kpi-value">
                    $<fmt:formatNumber value="${totalProfit}" type="number" maxFractionDigits="2"/>
                </div>

                <c:choose>
                    <c:when test="${profitGrowth>=0}">
                        <div class="kpi-growth positive">
                            <i class="bi bi-caret-up-fill"></i>
                            <strong>${String.format("%.2f",profitGrowth)}%</strong>
                            <span>YoY </span>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="kpi-growth-negative">
                            <i class="bi bi-caret-down-fill"></i>
                            <strong>${String.format("%.2f",Math.abs(profitGrowth))}%</strong>
                            <span>YoY </span>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <!-- Quantity -->
        <div class="col-lg-3 col-md-6">
            <div class="dashboard-kpi-card quantity-card">

                <div class="kpi-header">
                    <div class="kpi-icon quantity-icon">
                        <i class="bi bi-cart-fill"></i>
                    </div>

                    <div>
                        <div class="kpi-title">Quantity</div>
                    </div>
                </div>

                <div class="kpi-value">
                    <fmt:formatNumber value="${totalQuantity}" type="number"/>
                </div>

                <c:choose>
                    <c:when test="${quantityGrowth>=0}">
                        <div class="kpi-growth positive">
                            <i class="bi bi-caret-up-fill"></i>
                            <strong>${String.format("%.2f",quantityGrowth)}%</strong>
                            <span>YoY </span>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="kpi-growth-negative">
                            <i class="bi bi-caret-down-fill"></i>
                            <strong>${String.format("%.2f",Math.abs(quantityGrowth))}%</strong>
                            <span>YoY </span>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <!-- Customers -->
        <div class="col-lg-3 col-md-6">
            <div class="dashboard-kpi-card customer-card">

                <div class="kpi-header">
                    <div class="kpi-icon customer-icon">
                        <i class="bi bi-people-fill"></i>
                    </div>

                    <div>
                        <div class="kpi-title">Customers</div>
                    </div>
                </div>

                <div class="kpi-value">
                    ${totalCustomers}
                </div>

                <c:choose>
                    <c:when test="${customerGrowth>=0}">
                        <div class="kpi-growth positive">
                            <i class="bi bi-caret-up-fill"></i>
                            <strong>${String.format("%.2f",customerGrowth)}%</strong>
                            <span>YoY </span>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="kpi-growth-negative">
                            <i class="bi bi-caret-down-fill"></i>
                            <strong>${String.format("%.2f",Math.abs(customerGrowth))}%</strong>
                            <span>YoY </span>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

    </div>


    <div class="row g-4">
        <!-- ==============Monthly Sales Trend============= -->
        <div class="col-lg-6">
            <div class="card shadow-sm mt-3">
                <div class="card-body">
                    <h4 class="card-title">
                        <i class="bi bi-graph-up text-warning"></i>
                        Monthly Sales Trend
                    </h4>
                    <div style="height:200px;">
                        <canvas id="monthlySalesChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
            <!-- ================Category Bar Chart============ -->
            <div class="col-lg-6">
            <div class="card shadow-sm mt-3 ">
                <div class="card-body">
                    <h4 class="card-title">
                        <i class="bi bi-bar-chart-fill text-warning"></i>
                        Sales by Category
                    </h4>
                    <div style="height:200px;">
                        <canvas id="categoryChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <!-- =============================Sales by Segment================== -->
        <div class="col-lg-6">
            <div class="card shadow-sm mt-2">
                <div class="card-body">
                    <h4 class="card-title">
                        <i class="bi bi-pie-chart-fill text-warning"></i>
                        Sales by Segment
                    </h4>
                    <div style="height:200px;">
                        <canvas id="segmentChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <!-- ===========================Top Products Chart=================== -->
        <div class="col-lg-6">
            <div class="card shadow-sm mt-2">
                <div class="card-body">
                    <h4 class="card-title">
                        <i class="bi bi-trophy-fill text-warning"></i>
                        Top Products
                    </h4>
                    <div style="height:200px;">
                        <canvas id="topProductsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h4 class="crad-title mb-3">
                        <i class="bi bi-table text-warning"></i>
                        Recent Transactions
                    </h4>

                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle">
                            <thead class="table-primary">
                            <tr>
                                <th>Order Date</th>
                                <th>Customer</th>
                                <th>Product</th>
                                <th>Category</th>
                                <th>Quantity</th>
                                <th>Sales</th>
                                <th>Profit</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${recentTransactions}" var="t">
                                <tr>
                                    <td>${t.orderDate}</td>
                                    <td>${t.customerName}</td>
                                    <td>${t.productName}</td>
                                    <td>${t.category}</td>
                                    <td>${t.quantity}</td>
                                    <td>$${t.sales}</td>
                                    <td>$${t.profit}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script>
    Chart.register(ChartDataLabels);

    const monthNames = [
        "Jan","Feb","Mar","Apr","May","Jun",
        "Jul","Aug","Sep","Oct","Nov","Dec"
    ];

    const labels = [];
    const sales = [];

    <c:forEach var="row" items="${monthlySales}">
    labels.push(monthNames[${row[0]}-1]);
    sales.push(${row[1]});
    </c:forEach>

    const ctx = document.getElementById('monthlySalesChart').getContext('2d');

    new Chart(ctx,{
        type:'line',
        data:{
            labels:labels,
            datasets:[{
                label:'Monthly Sales',
                data:sales,
                borderColor:'#0d6efd',
                backgroundColor:'rgba(13,110,253,0.15)',
                fill:true,
                tension:0.4,
                pointRadius:4
            }]
        },
        options:{
            maintainAspectRatio: false,
            responsive:true,
            plugins:{
                legend:{
                    display:false
                },
                datalabels:{
                    display: false
                }
            },
            scales:{
                y:{
                    beginAtZero:true
                }
            }
        }
    });

    const categoryLabels=[
        <c:forEach var="row" items="${categoryData}">
        '${row[0]}',
        </c:forEach>
    ].map(label => label == "Office Supplies" ? "Office Sup.": label);

    const categoryValues = [
        <c:forEach var="row" items="${categoryData}">
        '${row[1]}',
        </c:forEach>
    ];

    new Chart(document.getElementById('categoryChart'),
        {
            type: 'bar',
            data: {
                labels: categoryLabels,
                datasets: [{
                    data: categoryValues,
                    backgroundColor:'#0b5ed7'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,

            plugins:{
                legend:{
                    display:false
                },
                datalabels: {
                    anchor: 'end'
,
                align: 'top',
                color: '#333',
                font:{
                        weight: 'bold',
                    size: 11
                },
                    formatter: function (value){
                        return '$'+Math.round(value).toLocaleString();
                    }
                }
            }
            },
        });

    const segmentLabels = [
        <c:forEach items="${segmentData}" var="row">
        '${row[0]}',
        </c:forEach>
    ];

    const segmentSales = [
        <c:forEach items="${segmentData}" var="row">
        '${row[1]}',
        </c:forEach>
    ];

    const segmentCtx = document.getElementById('segmentChart').getContext('2d');
    new Chart(segmentCtx, {
        type: 'doughnut',
        data: {
            labels: segmentLabels,
            datasets: [{
                data:segmentSales,
                backgroundColor: [
                    '#4e79a7',
                    '#59a14f',
                    '#f28e2b'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom'
                },
                datalabels:{
                    color: '#ffffff',
                    font:{
                        weight: 'bold',
                        size: 11
                    },
                    formatter: function(value,context)
                    {
                        const data=context.chart.data.datasets[0].data;
                        const total=data.reduce((sum,val) => sum + Number(val),0);
                        if(!total) return "";

                        return ((Number(value)/total)*100).toFixed(1)+'%';
                    }
                }
            }
        }
    });

    const productLabels = [
        <c:forEach var="row" items="${topProducts}">
        '${row[0]}',
        </c:forEach>
    ];

    const productValues = [
        <c:forEach var="row" items="${topProducts}">
        '${row[1]}',
        </c:forEach>
    ];

    new Chart(document.getElementById('topProductsChart'), {
        type:'bar',
        data:{
            labels:productLabels,
            datasets:[{
                data:productValues,
                backgroundColor:'#0b5ed7',
                borderRadius:8
            }]
        },
        options:{
            indexAxis:'y',
            responsive:true,
            maintainAspectRatio: false,
            plugins:{
                legend:{
                    display:false
                },
                datalabels:{
                    anchor: 'end',
                    align:'right',
                    color:'#333',
                    font:{
                        weight:'bold',
                        size:11
                    },
                    formatter:function(value){
                        return '$'+Math.round(value).toLocaleString();
                    }
                }
            },
            scales:{
                x:{
                    beginAtZero:true
                }
            }
        }
    });

</script>

</html>
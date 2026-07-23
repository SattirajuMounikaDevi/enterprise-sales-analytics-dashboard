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


</head>

<!--============================== NAVBAR ============= -->

<jsp:include page="common/navbar.jsp"/>

<!-- ===================FILTERS SECTION ============= -->
<jsp:include page="common/filters.jsp"/>
  <!--  ==============================KPIs Section =============================== -->
<div class="row g-4">
    <div class="col-lg-3">
        <div class="card shadow-sm border-0" style="height:120px;">
            <div class="card-body text-center">
                <h6 class="text-muted">Forecast Trend</h6>
                <h4 class="text-primary">${forecastTrend}</h4>
            </div>
        </div>
    </div>

    <div class="col-lg-3">
        <div class="card shadow-sm border-0" style="height:120px;">
            <div class="card-body text-center">
                <h6 class="text-muted">Avg. Forecast</h6>
                <h4 class="text-success">$${avgForecast}</h4>
            </div>
        </div>
    </div>

    <div class="col-lg-3">
        <div class="card shadow-sm border-0" style="height:120px;">
            <div class="card-body text-center">
                <h6 class="text-muted">Projected Growth</h6>
                <h4 class="text-warning">${forecastChange}%</h4>
            </div>
        </div>
    </div>

    <div class="col-lg-3">
        <div class="card shadow-sm border-0" style="height:120px;">
            <div class="card-body text-center">
                <h6 class="text-muted">Recommendation</h6>
                <h7>${recommendation}</h7>
            </div>
        </div>
    </div>

</div>

<div class="card shadow-sm mt-4">
    <div class="card-header bg-primary text-white">
        <h5 class="mb-0">
            <i class="bi bi-graph-up text-warning"></i>
            Sales Forecast (Next 3 Months)
        </h5>
    </div>
    <div class="card-body">
        <canvas id="forecastChart" height="200"></canvas>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card shadow-sm mt-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">
                <i class="bi bi-globe-americas me-2 text-warning"></i>
                    <strong>State-Wise Sales Analysis</strong>
                    </h5>
            </div>

            <div class="card-body">
                <div id="salesMap" style="height:430px;border-radius:10px;">
            </div>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card shadow-sm mt-4">
            <div class="card-header bg-primary text-white">
                <h5>
                    <i class="bi bi-table me-2 text-warning"></i>
                <strong> Sales summary by States</strong>
                </h5>
            </div>

            <div class="card-body p-0" style="height: 450px; overflow-y: auto; border-radius: 10px">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-light">
                    <tr>
                        <th class="text-start">State</th>
                        <th class="text-end">Sales($)</th>
                        <th class="text-end">Qty</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="state" items="${stateSales}">
                        <tr>
                            <td class="text-start">${state.state}</td>
                            <td class="text-end">$
                                    <fmt:formatNumber value="${state.totalSales}" type="number" minFractionDigits="2"
                                    maxFractionDigits="2"/></td>
                            <td class="text-end">
                                    <fmt:formatNumber value="${state.totalQuantity}" type="number"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
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

    const forecastLabels = ["F-Jan","F-Feb","F-Mar"];
    const forecastValues = [
        <c:forEach var="value" items="${forecastValues}">
        '${value}',
        </c:forEach>
    ];
    const forecastData =[
        null, null, null,null,
        null, null, null,null,
        null, null, null,${lastActualSale},...forecastValues
    ];

    <c:forEach var="row" items="${monthlySales}">
    labels.push(monthNames[${row[0]}-1]);
    sales.push(${row[1]});
    </c:forEach>
    labels.push(...forecastLabels);
    sales.push(null,null,null);

    const ctx = document.getElementById('forecastChart').getContext('2d');

    new Chart(ctx,{
        type:'line',
        data:{
            labels:labels,
            datasets:[{
                label:'Actual Sales',
                data:sales,
                borderColor:'#0d6efd',
                backgroundColor:'rgba(13,110,253,0.15)',
                borderWidth: 3,
                fill:true,
                tension:0.4,
                pointRadius:4
            },
                {
                    label: 'Forecast',
                    data: forecastData,
                    borderColor: '#ff9800',
                    backgroundColor: 'transparent',
                    borderDash: [8.5],
                    borderWidth: 3,
                    tension: 0.4,
                    pointRadius: 5,
                    pointStyle: 'triangle',
                    fill: false
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
</script>
<script type="text/javascript">
    google.charts.load('current', {
        'packages': ['geochart']
    });

    google.charts.setOnLoadCallback(drawRegionsMap);

    function drawRegionsMap() {
        var data = google.visualization.arrayToDataTable([
            ['State','Sales'],
        <c:forEach var="state" items="${stateSales}" varStatus="status">
            ['${state.state}',${state.totalSales}]
            <c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ]);
        var options = {
            region: 'US',
            resolution: 'provinces',
            displayMode: 'regions',
            colorAxis: {
                colors: ['#E3F2FD', '#1565C0']
            },
            legend:{
                textStyle: {
                    color:'#333',
                    fontsize: 12,
                    position: 'right'
                }
            },
            backgroundColor: '#ffffff',
            datalessRegionColor: '#f5f5f5',
            defaultColor: '#f5f5f5',

            width: '100%',
            height:'100%'

        };
        var chart = new google.visualization.GeoChart(
            document.getElementById('salesMap'));
            chart.draw(data,options);
    }
</script>
</html>
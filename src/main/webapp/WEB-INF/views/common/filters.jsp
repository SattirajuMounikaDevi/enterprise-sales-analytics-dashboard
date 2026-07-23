<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- ===================FILTERS SECTION ============= -->
<div class="container mt-4">

    <div class="filter-panel">
        <form action="${pageContext.request.contextPath}/${page}" method="get">

            <div class="d-flex justify-content-between align-items-center mb-3">

                <h5 class="filter-heading mb-0">
                    <i class="bi bi-funnel-fill"></i>
                    Filters
                </h5>

                <div>

                    <button type="submit" class="btn btn-primary btn-sm me-2">
                        <i class="bi bi-search"></i>
                        Apply
                    </button>

                    <a href=""${pageContext.request.contextPath}/${page}"" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-arrow-clockwise"></i>
                        Reset
                    </a>

                </div>

            </div>

            <div class="row g-2">

                <div class="col">
                    <select class="form-select" name="state">
                        <option value="">All States</option>

                        <c:forEach var="state" items="${states}">
                            <c:choose>
                                <c:when test="${state == selectedState}">
                                    <option value="${state}" selected="selected">${state}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${state}">${state}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>

                <div class="col">
                    <select class="form-select" name="category">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <c:choose>
                                <c:when test="${cat == selectedCategory}">
                                    <option value="${cat}" selected="selected">${cat}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${cat}">${cat}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>

                <div class="col">
                    <select class="form-select" name="subCategory">
                        <option value="">All Sub-Categories</option>
                        <c:forEach var="subcat" items="${subCategories}">
                            <c:choose>
                                <c:when test="${subcat == selectedSubCategory}">
                                    <option value="${subcat}" selected="selected">${subcat}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${subcat}">${subcat}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>

                <div class="col">
                    <select class="form-select" name="segment">
                        <option value="">All Segments</option>
                        <c:forEach var="seg" items="${segment}">
                            <c:choose>
                                <c:when test="${seg == selectedSegment}">
                                    <option value="${seg}" selected="selected">${seg}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${seg}">${seg}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>

                <div class="col">
                    <select class="form-select" name="year">
                        <option value="">All Years</option>
                        <c:forEach var="year" items="${years}">
                            <c:choose>
                                <c:when test="${year==selectedYear}">
                                    <option value="${year}" selected="selected">${year}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${year}">${year}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>

                <div class="col">
                    <select class="form-select" name="month">
                        <option value="">All Months</option>
                        <c:forEach var="month" items="${months}">
                            <option value="${month}"
                                    <c:if test="${month == selectedMonth}">
                                        selected="selected"
                                    </c:if>>
                                <c:choose>
                                    <c:when test="${month==1}">January</c:when>
                                    <c:when test="${month==2}">February</c:when>
                                    <c:when test="${month==3}">March</c:when>
                                    <c:when test="${month==4}">April</c:when>
                                    <c:when test="${month==5}">May</c:when>
                                    <c:when test="${month==6}">June</c:when>
                                    <c:when test="${month==7}">July</c:when>
                                    <c:when test="${month==8}">August</c:when>
                                    <c:when test="${month==9}">September</c:when>
                                    <c:when test="${month==10}">October</c:when>
                                    <c:when test="${month==11}">November</c:when>
                                    <c:when test="${month==12}">December</c:when>
                                </c:choose>
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </form>

    </div>

</div>
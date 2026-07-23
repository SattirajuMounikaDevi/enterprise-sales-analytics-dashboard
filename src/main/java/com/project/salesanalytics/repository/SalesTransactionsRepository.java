package com.project.salesanalytics.repository;

import com.project.salesanalytics.dto.StateSalesDTO;
import com.project.salesanalytics.entity.SalesTransactions;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import java.util.List;

public interface SalesTransactionsRepository
        extends JpaRepository<SalesTransactions, Integer> {

    @Query("SELECT SUM(s.sales) FROM SalesTransactions s")
    Double getTotalSales();

    @Query("SELECT SUM(s.profit) FROM SalesTransactions s")   Double getTotalProfit();

    @Query("SELECT SUM(s.quantity) FROM SalesTransactions s")
    Integer getTotalQuantity();

    @Query("SELECT COUNT(DISTINCT s.customerId) FROM SalesTransactions s")
    Long getTotalCustomers();

    @Query("SELECT COUNT(DISTINCT s.state) FROM SalesTransactions s")
    Long getTotalStates();

    @Query("""
select max(year(s.orderDate)) from SalesTransactions s""")
    Integer getCurrentYear();

    @Query("""
select coalesce(sum(s.sales),0) from SalesTransactions s where YEAR(s.orderDate)= :year""")
    Double getSalesByYear(@Param("year")
                          Integer year);

    @Query("""
Select coalesce(sum(s.profit),0) from SalesTransactions s where year(s.orderDate)= :year """)
    Double getProfitByYear(@Param("year")
                           Integer year);

    @Query("""
select coalesce(sum(s.quantity),0) from SalesTransactions s where year(s.orderDate)= :year""")
    Integer getQuantityByYear(@Param("year")
                              Integer year);

    @Query("""
select Count(distinct s.customerId) from SalesTransactions s where year(s.orderDate)= :year""")
    Long getCustomersByYear(@Param("year")
                              Integer year);

    //==================================FILTERS SECTIONS======================
    @Query("""
select distinct year(s.orderDate) from SalesTransactions s order by year(s.orderDate)""")
    List<Integer> getAvailableYears();

    @Query("""
select distinct month(s.orderDate) from SalesTransactions s order by month(s.orderDate)""")
    List<Integer> getAvailableMonths();

   /* @Query("""
select distinct function('week',s.orderDate) from SalesTransactions s order by function('week',s.orderDate)""")
    List<Integer> getAvailableWeeks();*/

    @Query("""
Select distinct s.state from SalesTransactions s order by s.state""")
    List<String> getAvailableStates();

    @Query("""
Select distinct s.category from SalesTransactions s order by s.category""")
    List<String> getCategories();

    @Query("""
Select distinct s.subCategory from SalesTransactions s where (:category is null or :category='' or  
s.category=:category)order by s.subCategory""")
    List<String> getSubCategories(@Param("category")String category);

    @Query("""
Select distinct s.segment from SalesTransactions s where (:category is null or :category='' or  
s.category=:category) and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory) order by s.segment""")
    List<String> getSegment(@Param("category")String category,
                            @Param("subCategory")String subCategory);

    @Query("""
Select coalesce(Sum(s.sales),0) from SalesTransactions s where(:year is null or year(s.orderDate)=:year)
and (:state is null or :state='' or s.state=:state) and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
and (:month is null or month(s.orderDate)=:month)""")
//and (:week is null or function('week',s.orderDate)=:week)""")
    Double getSales(
            @Param("year") Integer year,
            @Param("month") Integer month,
 //           @Param("week") Integer week,
            @Param("state") String state,
            @Param("category") String category,
            @Param("subCategory") String subCategory,
            @Param("segment") String segment);

    @Query("""
Select coalesce(Sum(s.profit),0)from SalesTransactions s where(:year is null or year(s.orderDate)=:year)
and (:state is null or :state='' or s.state=:state) and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
and (:month is null or month(s.orderDate)=:month)""")
//and (:week is null or function('week',s.orderDate)=:week)""")
    Double getProfit(
            @Param("year") Integer year,
            @Param("month") Integer month,
 //           @Param("week") Integer week,
            @Param("state") String state,
            @Param("category") String category,
            @Param("subCategory") String subCategory,
            @Param("segment") String segment);

    @Query("""
Select coalesce(Sum(s.quantity),0)from SalesTransactions s where(:year is null or year(s.orderDate)=:year)
and (:state is null or :state='' or s.state=:state) and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
and (:month is null or month(s.orderDate)=:month)""")
//and (:week is null or function('week',s.orderDate)=:week)""")
    Double getQuantity(
            @Param("year") Integer year,
            @Param("month") Integer month,
 //           @Param("week") Integer week,
            @Param("state") String state,
            @Param("category") String category,
            @Param("subCategory") String subCategory,
            @Param("segment") String segment);

    @Query("""
Select Count(Distinct s.customerId) from SalesTransactions s where(:year is null or year(s.orderDate)=:year)
and (:state is null or :state='' or s.state=:state) and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
and (:month is null or month(s.orderDate)=:month)""")
//and (:week is null or function('week',s.orderDate)=:week)""")
    Double getCustomers(
            @Param("year") Integer year,
            @Param("month") Integer month,
 //           @Param("week") Integer week,
            @Param("state") String state,
            @Param("category") String category,
            @Param("subCategory") String subCategory,
            @Param("segment") String segment);

    @Query("""
Select coalesce(Sum(s.sales),0) from SalesTransactions s where Year(s.orderDate)=:year and (:state is null
or :state='' or s.state=:state) and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
and (:month is null or month(s.orderDate)=:month)""")
//and (:week is null or function('week',s.orderDate)=:week)""")
    Double getSalesForGrowth(@Param("year") Integer year,
                             @Param("month") Integer month,
   //                          @Param("week") Integer week,
                             @Param("state") String state,
                             @Param("category") String category,
                             @Param("subCategory") String subCategory,
                             @Param("segment") String segment);

    /*@Query("""
SELECT COALESCE(sum(s.sales),0) from SalesTransactions s where EXTRACT(YEAR from s.orderDate)=
(select max(extract(year from t.orderDate)) from SalesTransactions t) """)
    Double getCurrentYearSales();

    @Query("""
SELECT COALESCE(sum(s.sales),0) from SalesTransactions s where EXTRACT(YEAR from s.orderDate)=
(select max(extract(year from t.orderDate)-1) from SalesTransactions t) """)
    Double getPreviousYearSales();*/

    //===========================CHARTS SECTION============================
    @Query("""
select month(s.orderDate),sum(s.sales) from SalesTransactions s where
(:year is null or year(s.orderDate)=:year) and 
(:state is null or :state='' or s.state=:state)
and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
group by month(s.orderDate)
order by month(s.orderDate)""")
    List<Object[]> getMonthlySales(@Param("year") Integer year,
                                   @Param("state") String state,
                                   @Param("category") String category,
                                   @Param("subCategory") String subCategory,
                                   @Param("segment") String segment);

    @Query("""
select s.category,sum(s.sales) from SalesTransactions s where
(:year is null or year(s.orderDate)=:year) and 
(:month is null or month(s.orderDate)=:month) and
(:state is null or :state='' or s.state=:state)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
group by s.category
order by sum(s.sales) desc""")
    List<Object[]> getSalesByCategory(@Param("year") Integer year,
                                   @Param("month") Integer month,
                                   @Param("state") String state,
                                   @Param("subCategory") String subCategory,
                                   @Param("segment") String segment);

    @Query("""
select s.segment,sum(s.sales) from SalesTransactions s where
(:year is null or year(s.orderDate)=:year) and 
(:month is null or month(s.orderDate)=:month) and
(:state is null or :state='' or s.state=:state)
and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
group by s.segment
order by sum(s.sales) desc""")
    List<Object[]> getSalesBySegment(@Param("year") Integer year,
                                      @Param("month") Integer month,
                                      @Param("state") String state,
                                      @Param("category") String category,
                                      @Param("subCategory") String subCategory);

    @Query("""
select s.productName,sum(s.sales) from SalesTransactions s where
(:year is null or year(s.orderDate)=:year) and 
(:month is null or month(s.orderDate)=:month) and
(:state is null or :state='' or s.state=:state)
and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
group by s.productName
order by sum(s.sales) desc""")
    List<Object[]> getTopProducts(@Param("year") Integer year,
                                     @Param("month") Integer month,
                                     @Param("state") String state,
                                     @Param("category") String category,
                                     @Param("subCategory") String subCategory,
                                     @Param("segment") String segment,
                                  Pageable pageable);

    @Query("""
select s from SalesTransactions s where
(:year is null or year(s.orderDate)=:year) and 
(:month is null or month(s.orderDate)=:month) and
(:state is null or :state='' or s.state=:state)
and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
order by s.orderDate desc""")
    List<SalesTransactions> getRecentTransactions(@Param("year") Integer year,
                                  @Param("month") Integer month,
                                  @Param("state") String state,
                                  @Param("category") String category,
                                  @Param("subCategory") String subCategory,
                                  @Param("segment") String segment,
                                                  Pageable pageable);

    @Query("""
Select new com.project.salesanalytics.dto.StateSalesDTO(
s.state,
Sum(s.sales),
Sum(s.quantity)
)
from SalesTransactions s 
where
(:year is null or year(s.orderDate)=:year) and 
(:month is null or month(s.orderDate)=:month) and
(:state is null or :state='' or s.state=:state)
and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
group by s.state
order by Sum(s.sales) desc""")
    List<StateSalesDTO> getStateWiseSales(@Param("year") Integer year,
                                          @Param("month") Integer month,
                                          @Param("state") String state,
                                          @Param("category") String category,
                                          @Param("subCategory") String subCategory,
                                          @Param("segment") String segment);

    @Query("""
select s from SalesTransactions s where
(:year is null or year(s.orderDate)=:year) and 
(:month is null or month(s.orderDate)=:month) and
(:state is null or :state='' or s.state=:state)
and (:category is null or :category='' or s.category=:category)
and (:subCategory is null or :subCategory='' or s.subCategory=:subCategory)
and (:segment is null or :segment='' or s.segment=:segment)
order by s.orderDate desc""")
    List<SalesTransactions> getFilteredSalesData(@Param("year") Integer year,
                                                  @Param("month") Integer month,
                                                  @Param("state") String state,
                                                  @Param("category") String category,
                                                  @Param("subCategory") String subCategory,
                                                  @Param("segment") String segment);


}
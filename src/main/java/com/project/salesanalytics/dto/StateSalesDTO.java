package com.project.salesanalytics.dto;

public class StateSalesDTO {
    private String state;
    private Double totalSales;
    private Long totalQuantity;

    public StateSalesDTO(String state, Double totalSales, Long totalQuantity)
    {
        this.state = state;
        this.totalSales = totalSales;
        this.totalQuantity = totalQuantity;
    }
    public String getState() {
        return state;
    }
    public Double getTotalSales() {
        return totalSales;
    }
    public Long getTotalQuantity() {
        return totalQuantity;
    }
}

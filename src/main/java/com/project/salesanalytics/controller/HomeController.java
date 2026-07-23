package com.project.salesanalytics.controller;

import com.project.salesanalytics.dto.StateSalesDTO;
import com.project.salesanalytics.entity.SalesTransactions;
import com.project.salesanalytics.repository.SalesTransactionsRepository;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.querydsl.QPageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private SalesTransactionsRepository repository;

    @GetMapping("/")
    public String home(Model model) {

        model.addAttribute("activePage","home");

        model.addAttribute("totalSales", repository.getTotalSales());
        model.addAttribute("totalProfit", repository.getTotalProfit());
        model.addAttribute("totalQuantity", repository.getTotalQuantity());
        model.addAttribute("totalCustomers", repository.getTotalCustomers());
        model.addAttribute("totalStates", repository.getTotalStates());

        return "index";
    }

    private void loadFilters(Model model,
                             Integer year,
                             Integer month,
                             String state,
                             String category,
                             String subCategory,
                             String segment) {
        Integer selectedYear= (year == null)?repository.getCurrentYear():year;
        Integer currentYear=selectedYear;
        String selectedState= state;
        model.addAttribute("selectedYear",selectedYear);
        model.addAttribute("selectedState",selectedState);

        List<Integer> years=repository.getAvailableYears();
        model.addAttribute("years", years);

        List<String> states= repository.getAvailableStates();
        model.addAttribute("states",states);

        model.addAttribute("categories",repository.getCategories());
        model.addAttribute("selectedCategory",category);

        model.addAttribute("subCategories",repository.getSubCategories(category));
        model.addAttribute("selectedSubCategory",subCategory);

        model.addAttribute("segment",repository.getSegment(category,subCategory));
        model.addAttribute("selectedSegment",segment);

        model.addAttribute("months",repository.getAvailableMonths());
        model.addAttribute("selectedMonth",month);

    }

    @GetMapping("/dashboard")
    public String dashboard(@RequestParam(required=false) Integer year,
                            @RequestParam(required=false) Integer month,
                            //@RequestParam(required=false) Integer week,
                            @RequestParam(required = false) String state,
                            @RequestParam(required = false) String category,
                            @RequestParam(required = false) String subCategory,
                            @RequestParam(required = false) String segment, Model model) {

        //======================================Sales Calculations======================//

        /*Integer selectedYear= (year == null)?repository.getCurrentYear():year;
        Integer currentYear=selectedYear;
        String selectedState= state;
        model.addAttribute("selectedYear",selectedYear);
        model.addAttribute("selectedState",selectedState);

        model.addAttribute("categories",repository.getCategories());
        model.addAttribute("selectedCategory",category);

        model.addAttribute("subCategories",repository.getSubCategories(category));
        model.addAttribute("selectedSubCategory",subCategory);

        model.addAttribute("segment",repository.getSegment(category,subCategory));
        model.addAttribute("selectedSegment",segment);

        model.addAttribute("months",repository.getAvailableMonths());
        model.addAttribute("selectedMonth",month);*/
        loadFilters(model, year, month, state, category, subCategory, segment);
        Integer selectedYear= (year == null)?repository.getCurrentYear():year;
        Integer currentYear=selectedYear;
        String selectedState= state;

        /*model.addAttribute("weeks",repository.getAvailableWeeks());
        model.addAttribute("selectedWeek",week);*/

        model.addAttribute("page","dashboard");
        model.addAttribute("activePage","dashboard");

        model.addAttribute("totalSales", repository.getSales(selectedYear,month, selectedState, category, subCategory, segment));
        model.addAttribute("totalProfit", repository.getProfit(selectedYear,month,selectedState, category, subCategory, segment));
        model.addAttribute("totalQuantity", repository.getQuantity(selectedYear,month,selectedState, category, subCategory, segment));
        model.addAttribute("totalCustomers", repository.getCustomers(selectedYear,month,selectedState, category, subCategory, segment));
        model.addAttribute("totalStates", repository.getTotalStates());


        Double currentYearSales = repository.getSalesForGrowth(currentYear, month,selectedState, category, subCategory, segment);
        Double previousYearSales = repository.getSalesForGrowth(currentYear - 1, month,selectedState, category, subCategory, segment);

        Double salesGrowth = 0.0;
        if (previousYearSales != null && previousYearSales != 0)
        {
            salesGrowth =((currentYearSales-previousYearSales)/previousYearSales)*100;
        }

        model.addAttribute("salesGrowth", salesGrowth);
        model.addAttribute("currentYear", currentYear);

        //===================================Profit Calculations====================

        Double currentProfit = repository.getProfitByYear(currentYear);
        Double previousProfit=repository.getProfitByYear(currentYear-1);

        double profitGrowth =0.0;

        if(previousProfit!=null && previousProfit!=0)
        {
            profitGrowth = ((currentProfit-previousProfit)/previousProfit)*100;
        }
        model.addAttribute("profitGrowth", profitGrowth);

        //==========================Quantity Calculations===========================
        Integer currentQuantity=repository.getQuantityByYear(currentYear);
        Integer previousQuantity=repository.getQuantityByYear(currentYear-1);

        double quantityGrowth =0.0;

        if(previousQuantity!=null && previousQuantity!=0)
        {
            quantityGrowth = ((double)(currentQuantity-previousQuantity)/previousQuantity)*100;
        }
        model.addAttribute("quantityGrowth", quantityGrowth);

        //============================Total Customers Calculations===============================
        Long currentCustomers=repository.getCustomersByYear(currentYear);
        Long previousCustomers=repository.getCustomersByYear(currentYear-1);

        double customerGrowth =0.0;

        if(previousCustomers!=null && previousCustomers!=0)
        {
            customerGrowth = ((double)(currentCustomers-previousCustomers)/previousCustomers)*100;
        }
        model.addAttribute("customerGrowth", customerGrowth);

        //===========================Filters Section====================
        /*List<Integer> years=repository.getAvailableYears();
        model.addAttribute("years", years);

        List<String> states= repository.getAvailableStates();
        model.addAttribute("states",states);*/

        List<Object[]> monthlySales=repository.getMonthlySales(selectedYear,selectedState,category,subCategory,segment);
        model.addAttribute("monthlySales",monthlySales);

        List<Object[]> categoryData=repository.getSalesByCategory(selectedYear,month,selectedState,subCategory,segment);
        model.addAttribute("categoryData",categoryData);

        List<Object[]> segmentData=repository.getSalesBySegment(selectedYear,month,category,selectedState,subCategory);
        model.addAttribute("segmentData",segmentData);

        model.addAttribute("topProducts",repository.getTopProducts(selectedYear,month,selectedState,category,subCategory,segment,
                PageRequest.of(0,10)));

        model.addAttribute("recentTransactions",repository.getRecentTransactions(selectedYear,month,selectedState,category,subCategory,segment,
                PageRequest.of(0,10)));

        return "dashboard";
    }

    @GetMapping("/reports")
    public String reports(@RequestParam(required=false) Integer year,
                          @RequestParam(required=false) Integer month,
                          @RequestParam(required = false) String state,
                          @RequestParam(required = false) String category,
                          @RequestParam(required = false) String subCategory,
                          @RequestParam(required = false) String segment, Model model){
        loadFilters(model, year, month, state, category, subCategory, segment);
        Integer selectedYear= (year == null)?repository.getCurrentYear():year;
        Integer currentYear=selectedYear;
        String selectedState= state;

        model.addAttribute("page","reports");
        model.addAttribute("activePage","reports");

        List<Object[]> monthlySales=repository.getMonthlySales(selectedYear,selectedState,category,subCategory,segment);
        List<Double> movingAverage=new ArrayList<>();
        for(int i=0;i<monthlySales.size();i++){
            if(i<2){
                movingAverage.add(null);
            }
            else{
                double month1=((Number)monthlySales.get(i)[1]).doubleValue();
                double month2=((Number)monthlySales.get(i-1)[1]).doubleValue();
                double month3=((Number)monthlySales.get(i-2)[1]).doubleValue();
                movingAverage.add((month1+month2+month3)/3.0);
            }
        }
        List<Double> salesValues =new ArrayList<>();

        for(Object[] row : monthlySales)
        {
          salesValues.add(((Number)row[1]).doubleValue());
        }
        if(salesValues.size()>=12) {

            double forecastJan = (salesValues.get(9) + salesValues.get(10) + salesValues.get(11)) / 3;
            double forecastFeb = (salesValues.get(10) + salesValues.get(11) + forecastJan) / 3;
            double forecastMar = (salesValues.get(11) + forecastJan + forecastFeb) / 3;


            List<Double> forecastValues = new ArrayList<>();
            forecastValues.add(forecastJan);
            forecastValues.add(forecastFeb);
            forecastValues.add(forecastMar);
            double lastActualSale = salesValues.get(salesValues.size() - 1);
            model.addAttribute("lastActualSale", lastActualSale);

            model.addAttribute("forecastValues", forecastValues);

            model.addAttribute("movingAverage", movingAverage);
            model.addAttribute("monthlySales", monthlySales);

            double avgForecast = (forecastJan + forecastFeb + forecastMar) / 3.0;
            double forecastChange = ((avgForecast - forecastJan) / forecastJan) * 100;


            String forecastTrend;
            if (forecastChange > 5) {
                forecastTrend = "Increasing";
            } else if (forecastChange < -5) {
                forecastTrend = "Declining";
            } else {
                forecastTrend = "Stable";
            }

            String recommendation;
            if (forecastChange > 5) {
                recommendation = "Prepare for increased sales demand";
            } else if (forecastChange < -5) {
                recommendation = "Plan promotional campaigns";
            } else {
                recommendation = "Maintain current stock levels";
            }
            model.addAttribute("avgForecast", String.format("%,.0f", avgForecast));
            model.addAttribute("forecastChange", String.format("%,.1f", forecastChange));
            model.addAttribute("forecastTrend", forecastTrend);
            model.addAttribute("recommendation", recommendation);
        }

        List<StateSalesDTO> stateSales = repository.getStateWiseSales(selectedYear,month, selectedState,category,subCategory,segment);
        model.addAttribute("stateSales",stateSales);


        return "reports";
    }

    @GetMapping("/salesdata")
    public String salesData(@RequestParam(required=false) Integer year,
                            @RequestParam(required=false) Integer month,
                            @RequestParam(required = false) String state,
                            @RequestParam(required = false) String category,
                            @RequestParam(required = false) String subCategory,
                            @RequestParam(required = false) String segment, Model model){

        loadFilters(model, year, month, state, category, subCategory, segment);
        Integer selectedYear= (year == null)?repository.getCurrentYear():year;
        Integer currentYear=selectedYear;
        String selectedState= state;

        model.addAttribute("page","salesdata");
        model.addAttribute("activePage","salesdata");

        model.addAttribute("selectedYear",selectedYear);
        model.addAttribute("selectedState",selectedState);

        List<Integer> years=repository.getAvailableYears();
        model.addAttribute("years", years);

        List<String> states= repository.getAvailableStates();
        model.addAttribute("states",states);

        model.addAttribute("categories",repository.getCategories());
        model.addAttribute("selectedCategory",category);

        model.addAttribute("subCategories",repository.getSubCategories(category));
        model.addAttribute("selectedSubCategory",subCategory);

        model.addAttribute("segment",repository.getSegment(category,subCategory));
        model.addAttribute("selectedSegment",segment);

        model.addAttribute("months",repository.getAvailableMonths());
        model.addAttribute("selectedMonth",month);

        List<SalesTransactions> salesData = repository.getFilteredSalesData(selectedYear,month, selectedState,category,subCategory,segment);
        model.addAttribute("salesData",salesData);

        return "salesdata";

    }

    @GetMapping("/exportExcel")
    public void exportExcel(
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer month,
            @RequestParam(required = false) String state,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String subCategory,
            @RequestParam(required = false) String segment,
            HttpServletResponse response) throws IOException {

        List<SalesTransactions> salesData =
                repository.getFilteredSalesData(
                        year,
                        month,
                        state,
                        category,
                        subCategory,
                        segment
                );

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Sales Data");

        Row header = sheet.createRow(0);

        String[] columns = {
                "Order ID",
                "Order Date",
                "Customer Name",
                "Segment",
                "State",
                "Category",
                "Sub Category",
                "Product Name",
                "Sales",
                "Quantity",
                "Profit"
        };

        for (int i = 0; i < columns.length; i++) {
            header.createCell(i).setCellValue(columns[i]);
        }

        int rowNum = 1;

        for (SalesTransactions sale : salesData) {

            Row row = sheet.createRow(rowNum++);

            row.createCell(0).setCellValue(sale.getOrderId());
            row.createCell(1).setCellValue(sale.getOrderDate().toString());
            row.createCell(2).setCellValue(sale.getCustomerName());
            row.createCell(3).setCellValue(sale.getSegment());
            row.createCell(4).setCellValue(sale.getState());
            row.createCell(5).setCellValue(sale.getCategory());
            row.createCell(6).setCellValue(sale.getSubCategory());
            row.createCell(7).setCellValue(sale.getProductName());
            row.createCell(8).setCellValue(sale.getSales());
            row.createCell(9).setCellValue(sale.getQuantity());
            row.createCell(10).setCellValue(sale.getProfit());

        }

        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        response.setContentType(
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader(
                "Content-Disposition",
                "attachment; filename=SalesData.xlsx");

        workbook.write(response.getOutputStream());
        workbook.close();
    }

    @GetMapping("/about")
    public  String about(Model model) {
        model.addAttribute("page","about");
        model.addAttribute("activePage","about");

        return "about";
    }

}
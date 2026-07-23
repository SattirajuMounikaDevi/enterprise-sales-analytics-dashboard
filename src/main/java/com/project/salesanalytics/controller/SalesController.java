package com.project.salesanalytics.controller;


import com.project.salesanalytics.entity.SalesTransactions;
import com.project.salesanalytics.repository.SalesTransactionsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
public class SalesController {

    @Autowired
    private SalesTransactionsRepository repository;
    @GetMapping("/sales")
    public List<SalesTransactions>getSales()
    {
        return repository. findAll();
    }
}

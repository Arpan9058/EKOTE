/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ekote.entities;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author sambh
 */
public class GunDetails {
    private String gunIdentifier; // Add gun identifier field
    private String gunName;
    private String model;
    private int quantity;
    private String registeredBy;
    private String manufacturedDate;
    private String manufacturedPlace;
    private String maintenanceDate;
    private String nextMaintenanceDate;
    private String issueDate;
    private String returnDate;
    private String status;
    private String userName;
    private String userEmail;
    private String userRole;

    public void setGunName(String gunName) {
        this.gunName = gunName;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setRegisteredBy(String registeredBy) {
        this.registeredBy = registeredBy;
    }

    public void setManufacturedDate(String manufacturedDate) {
        this.manufacturedDate = manufacturedDate;
    }

    public void setManufacturedPlace(String manufacturedPlace) {
        this.manufacturedPlace = manufacturedPlace;
    }

    public void setMaintenanceDate(String maintenanceDate) {
        this.maintenanceDate = maintenanceDate;
    }

    public void setNextMaintenanceDate(String nextMaintenanceDate) {
        this.nextMaintenanceDate = nextMaintenanceDate;
    }

    public void setIssueDate(String issueDate) {
        this.issueDate = issueDate;
    }

    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }
    public String getGunIdentifier() {
        return gunIdentifier;
    }
    public void setGunIdentifier(String gunIdentifier) {
        this.gunIdentifier = gunIdentifier;
    }

    public String getGunName() {
        return gunName;
    }

    public String getModel() {
        return model;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getRegisteredBy() {
        return registeredBy;
    }

    public String getManufacturedDate() {
        return manufacturedDate;
    }

    public String getManufacturedPlace() {
        return manufacturedPlace;
    }

    public String getMaintenanceDate() {
        return maintenanceDate;
    }

    public String getNextMaintenanceDate() {
        return nextMaintenanceDate;
    }

    public String getIssueDate() {
        return issueDate;
    }

    public String getReturnDate() {
        return returnDate;
    }

    public String getStatus() {
        return status;
    }

    public String getUserName() {
        return userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public String getUserRole() {
        return userRole;
    }
    
}



/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ekote.entities;

/**
 *
 * @author sambh
 */
public class Gun {
    private int id;
    private String gunName;
    private String model;
    private int quantity;
    private String registeredBy;

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the gunName
     */
    public String getGunName() {
        return gunName;
    }

    /**
     * @param gunName the gunName to set
     */
    public void setGunName(String gunName) {
        this.gunName = gunName;
    }

    /**
     * @return the model
     */
    public String getModel() {
        return model;
    }

    /**
     * @param model the model to set
     */
    public void setModel(String model) {
        this.model = model;
    }

    /**
     * @return the quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * @return the registeredBy
     */
    public String getRegisteredBy() {
        return registeredBy;
    }

    /**
     * @param registeredBy the registeredBy to set
     */
    public void setRegisteredBy(String registeredBy) {
        this.registeredBy = registeredBy;
    }
   
}

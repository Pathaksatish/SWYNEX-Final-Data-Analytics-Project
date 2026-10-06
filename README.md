# SWYNEX Final Data Analytics Project

## 📊 Project Overview

This project is a complete end-to-end Data Analytics case study developed as part of my SWYNEX internship.

The project analyzes Cafe Sales transaction data to understand sales performance, product performance, transaction patterns, payment methods, and business trends.

The complete analytics workflow covers:

**Data Cleaning → Exploratory Data Analysis → Dashboard Development → Business Insights**

---

## 🎯 Problem Statement

The objective of this project is to analyze cafe sales transaction data and identify meaningful patterns and trends that can support business decision-making.

The analysis focuses on:

- Overall sales performance
- Product-wise sales and quantity
- Transaction performance
- Payment method preferences
- Location-wise performance
- Monthly sales trends
- Interactive business reporting

---

## 📁 Dataset

The project uses a Cafe Sales transaction dataset containing information such as:

- Transaction ID
- Item
- Quantity
- Price Per Unit
- Total Spent
- Payment Method
- Location
- Transaction Date

The raw dataset was cleaned and prepared before performing analysis.

---

## 🧹 1. Data Cleaning — PostgreSQL

The data cleaning process was performed using PostgreSQL.

### Cleaning activities included:

- Creating a staging table
- Handling missing values
- Handling invalid values
- Converting data types
- Cleaning transaction fields
- Calculating missing total spending values
- Validating the cleaned dataset
- Preparing the final dataset for analysis

📂 **Folder:** `01_Data_Cleaning`

---

## 📈 2. Exploratory Data Analysis — Excel

Exploratory Data Analysis was performed using Microsoft Excel.

### Analysis included:

- KPI analysis
- Total Sales
- Total Quantity
- Total Transactions
- Average Unit Price
- Average Transaction Value
- Product-wise sales
- Product-wise quantity
- Payment method analysis
- Location-wise analysis
- Pivot tables
- Charts
- Outlier and anomaly analysis

### Key Metrics

| Metric | Value |
|---|---:|
| Total Transactions | 10,000 |
| Total Quantity Sold | 28,834 |
| Total Sales | 88,952 |
| Number of Products | 8 |

📂 **Folder:** `02_Excel_Analysis`

---

## 📊 3. Interactive Power BI Dashboard

An interactive Power BI dashboard was developed to visualize the cleaned and analyzed data.

### Dashboard includes:

- Total Sales KPI
- Total Quantity KPI
- Total Transactions KPI
- Average Unit Price
- Average Transaction Value
- Product-wise analysis
- Payment Method analysis
- Location-wise analysis
- Monthly sales trends
- Interactive slicers and filters

### Power BI techniques used:

- Power Query
- Data Transformation
- Data Modeling
- DAX Measures
- KPI Cards
- Charts
- Slicers
- Interactive Dashboard Design

📂 **Folder:** `03_PowerBI_Dashboard`

---

## 💡 Key Business Insights

The analysis helps identify:

- Overall sales performance
- Products contributing significantly to sales
- Products with higher sales quantities
- Customer payment preferences
- Location-wise sales patterns
- Monthly sales trends
- Potential areas for business improvement

---

## 🔄 Project Workflow

```text
Raw Cafe Sales Dataset
        ↓
Data Cleaning & Preparation
        ↓
PostgreSQL
        ↓
Cleaned Dataset
        ↓
Exploratory Data Analysis
        ↓
Microsoft Excel
        ↓
Interactive Dashboard
        ↓
Microsoft Power BI
        ↓
Business Insights

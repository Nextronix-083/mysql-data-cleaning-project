# 🧹 Data Cleaning in MySQL – Layoffs Dataset

## 📌 Project Overview
This project demonstrates a complete **data cleaning workflow using MySQL**.  
The dataset used here contains information about company layoffs, including details such as company name, industry, location, stage, funds raised, and layoff counts.  

The main goal was to **clean, standardize, and prepare** the dataset for analysis by removing duplicates, handling missing values, fixing inconsistent formats, and ensuring data integrity.

---

## 📂 Repository Structure

data-cleaning-mysql-project/
│── data/
│ ├── raw_data.sql # Original dataset (exported from MySQL)
│ ├── cleaned_data.sql # Final cleaned dataset
│ ├── cleaned_dataset.csv # (Optional) Cleaned dataset in CSV format
│
│── queries/
│ ├── cleaning_queries.sql # SQL scripts used for cleaning
│
│── README.md # Project explanation


---

## 🔧 Cleaning Steps Applied

### 1. **Remove Duplicates**
- Created staging tables (`layoffs_staging`, `layoffs_staging2`) to work safely on data.  
- Used `ROW_NUMBER()` with `PARTITION BY` to identify duplicate records.  
- Deleted duplicate rows based on company, industry, layoffs, and date.

### 2.Standardize Data
- Trimmed extra spaces in company names (`TRIM(company)`).
- Fixed inconsistent industry names (e.g., all variations of “crypto” → **Crypto**).  
- Corrected country values with trailing characters (e.g., “United States.” → “United States”).  
- Converted `date` column from text format to proper `DATE` type (`STR_TO_DATE`).  

### 3. Handle Null & Blank Values
- Replaced empty industry strings with `NULL`.  
- Backfilled missing industry values using company + location matches.  
- Removed rows where both `total_laid_off` and `percentage_laid_off` were null (no useful info).  

### 4. Finalize Dataset
- Dropped helper column (`row_num`).  
- Resulted in a **clean and consistent dataset** ready for analysis.  

---

### 📊 Key Outcomes
- ✅ Removed duplicates and inconsistent records.  
- ✅ Standardized company, industry, country, and date fields.  
- ✅ Handled null and blank values effectively.  
- ✅ Final dataset ready for further **analysis and visualization**.  

---

 ## 🚀 Tools & Technologies
- MySQL (Workbench & SQL queries)  
- GitHub for version control  

---

## 📂 Dataset Source
Link: https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv  

---

## Author
👤 Nazmul Hosen  
📎 [LinkedIn](www.linkedin.com/in/mnazmulhosen)

---

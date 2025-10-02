-- Data Cleaning Project (MySQL)
-- Dataset: Layoffs
-- Purpose: Clean and standardize dataset for analysis

-- Step 1: Create Staging Table
CREATE TABLE layoffs_staging LIKE layoffs;
INSERT layoffs_staging SELECT * FROM layoffs;

-- Step 2: Remove Duplicates
WITH duplicate_cte AS (
  SELECT *,
    ROW_NUMBER() OVER(
      PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`
    ) AS row_num
  FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;

-- Step 3: Standardize Data
-- Remove extra spaces from company names
UPDATE layoffs_staging
SET company = TRIM(company);

-- Fix inconsistent industry names
UPDATE layoffs_staging
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%';

-- Fix country values with trailing dots
UPDATE layoffs_staging
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Standardize date format
UPDATE layoffs_staging
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
ALTER TABLE layoffs_staging MODIFY COLUMN `date` DATE;

-- Step 4: Handle Null/Blank Values
UPDATE layoffs_staging
SET industry = NULL
WHERE industry = '';

-- Fill null industries based on other rows with same company
UPDATE layoffs_staging t1
JOIN layoffs_staging t2
  ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Step 5: Remove Rows with No Layoff Info
DELETE
FROM layoffs_staging
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Step 6: Drop Helper Columns
ALTER TABLE layoffs_staging
DROP COLUMN row_num;

-- Final Cleaned Table
SELECT * FROM layoffs_staging;

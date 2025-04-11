-- QUESTIONS

-- How have total layoffs changed over time?
SELECT DATE_FORMAT(date, '%Y-%m') AS month, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY month
ORDER BY month ASC;

-- Which industries have experienced the most layoffs?
SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC;

-- Which countries have been hit hardest by layoffs?
SELECT country, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC;

-- Are early-stage companies more affected by layoffs than later-stage ones?
SELECT stage, AVG(percentage_laid_off) AS avg_percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY stage
ORDER BY avg_percentage_laid_off DESC;

-- Is there a relationship between the amount of funding a company raised and how many employees it laid off?
SELECT company, funds_raised_millions, total_laid_off
FROM layoffs_staging2
WHERE funds_raised_millions IS NOT NULL AND total_laid_off IS NOT NULL;

-- Which company stages raise the most funding on average? 
SELECT stage, AVG(funds_raised_millions) AS avg_funding
FROM layoffs_staging2
WHERE funds_raised_millions IS NOT NULL
GROUP BY stage
ORDER BY avg_funding DESC;

-- How many companies have conducted layoffs each month?
SELECT DATE_FORMAT(date, '%Y-%m') AS month, COUNT(DISTINCT company) AS companies_laid_off
FROM layoffs_staging2
GROUP BY month
ORDER BY month;

-- Which companies laid off the most employees (Top 10)?
SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC
LIMIT 10;

-- Are companies with less funding more likely to lay off a higher percentage of their workforce?
SELECT company, funds_raised_millions, percentage_laid_off
FROM layoffs_staging2
WHERE funds_raised_millions IS NOT NULL AND percentage_laid_off IS NOT NULL;

-- Which industry and funding stage combinations have the highest number of layoffs?
SELECT industry, stage, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry, stage
ORDER BY total_layoffs DESC;

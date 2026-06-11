/* ==========================================================
   CUSTOMER CHURN & RETENTION ANALYTICS
   Banking Domain

   Author: Aryan Chechi

   Tools Used:
   - MySQL
   - Excel
   - Tableau

   Dataset:
   10,000 Banking Customers

   Objective:
   Analyze customer churn behavior, identify key churn
   drivers, and uncover high-risk customer segments to
   improve customer retention strategies.
========================================================== */

USE customer_churn_analytics;


/* ==========================================================
   BUSINESS QUESTION 1

   What is the overall customer churn rate?
========================================================== */

SELECT
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    COUNT(*) - SUM(Exited) AS Retained_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate,
    ROUND((COUNT(*) - SUM(Exited)) * 100.0 / COUNT(*), 2) AS Retention_Rate
FROM churn_cleaned;

/*
INSIGHT:
- Total Customers: 10,000
- Churned Customers: 2,037
- Retained Customers: 7,963
- Churn Rate: 20.37%
- Retention Rate: 79.63%

Approximately 1 in every 5 customers leaves the bank.
*/


/* ==========================================================
   BUSINESS QUESTION 2

   Which geography experiences the highest customer churn?
========================================================== */

SELECT
    Geography,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM churn_cleaned
GROUP BY Geography
ORDER BY Churn_Rate DESC;

/*
INSIGHT:
Germany records the highest churn rate at 32.44%.

This is almost double the churn rate observed in
France and Spain.
*/


/* ==========================================================
   BUSINESS QUESTION 3

   Which age group is most likely to churn?
========================================================== */

SELECT
    `Age Group`,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM churn_cleaned
GROUP BY `Age Group`
ORDER BY Churn_Rate DESC;

/*
INSIGHT:
Senior customers exhibit the highest churn rate
at 45.45%.

Nearly half of all senior customers eventually
leave the bank.
*/


/* ==========================================================
   BUSINESS QUESTION 4

   Do inactive customers churn more than active customers?
========================================================== */

SELECT
    IsActiveMember,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM churn_cleaned
GROUP BY IsActiveMember;

/*
INSIGHT:
Active Customers   : 14.27%
Inactive Customers : 26.85%

Inactive customers churn almost twice as much as
active customers.
*/


/* ==========================================================
   BUSINESS QUESTION 5

   How does product ownership impact customer churn?
========================================================== */

SELECT
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM churn_cleaned
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

/*
INSIGHT:
1 Product : 27.71%
2 Products: 7.58%
3 Products: 82.71%
4 Products: 100.00%

Customers owning 2 products show the strongest
retention.

Customers with 3 or more products demonstrate
extremely high churn behavior.
*/


/* ==========================================================
   BUSINESS QUESTION 6

   Does credit card ownership influence customer churn?
========================================================== */

SELECT
    HasCrCard,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM churn_cleaned
GROUP BY HasCrCard;

/*
INSIGHT:
Credit Card Holders    : 20.18%
Non Credit Card Holders: 20.81%

Credit card ownership has very little impact on
customer churn.
*/


/* ==========================================================
   BUSINESS QUESTION 7

   Which balance segment experiences the highest churn?
========================================================== */

SELECT
    `Balance Segment`,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM churn_cleaned
GROUP BY `Balance Segment`
ORDER BY Churn_Rate DESC;

/*
INSIGHT:
Low Balance    : 34.67%
High Balance   : 25.23%
Medium Balance : 19.88%
Zero Balance   : 13.82%

Low-balance customers show the highest observed
churn rate.

High-value customers also display elevated churn
risk.
*/


/* ==========================================================
   BUSINESS QUESTION 8

   Does gender influence customer churn?
========================================================== */

SELECT
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM churn_cleaned
GROUP BY Gender;

/*
INSIGHT:
Female Customers : 25.07%
Male Customers   : 16.46%

Female customers churn significantly more than
male customers.
*/


/* ==========================================================
   BUSINESS QUESTION 9

   Which geography-gender combination represents
   the highest-risk customer segment?
========================================================== */

SELECT
    Geography,
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM churn_cleaned
GROUP BY Geography, Gender
ORDER BY Churn_Rate DESC;

/*
INSIGHT:
Germany - Female customers exhibit the highest
churn rate at 37.55%.

This segment represents the highest-risk customer
group in the dataset.
*/


/* ==========================================================
   BUSINESS QUESTION 10

   Are churned customers generally older than
   retained customers?
========================================================== */

SELECT
    `Customer Status`,
    ROUND(AVG(Age), 2) AS Average_Age
FROM churn_cleaned
GROUP BY `Customer Status`;

/*
INSIGHT:
Compare average ages of retained and churned
customers to understand whether age influences
customer attrition.
*/


/* ==========================================================
   BUSINESS QUESTION 11

   Do churned customers maintain higher account
   balances than retained customers?
========================================================== */

SELECT
    `Customer Status`,
    ROUND(AVG(Balance), 2) AS Average_Balance
FROM churn_cleaned
GROUP BY `Customer Status`;

/*
INSIGHT:
This analysis helps determine whether higher-value
customers are more likely to leave the bank.
*/


/* ==========================================================
   BUSINESS QUESTION 12

   Does creditworthiness influence customer churn?
========================================================== */

SELECT
    `Customer Status`,
    ROUND(AVG(CreditScore), 2) AS Average_Credit_Score
FROM churn_cleaned
GROUP BY `Customer Status`;

/*
INSIGHT:
Comparing credit scores helps evaluate whether
financial reliability impacts retention.
*/


/* ==========================================================
   BUSINESS QUESTION 13

   Are long-term customers more loyal?
========================================================== */

SELECT
    `Customer Status`,
    ROUND(AVG(Tenure), 2) AS Average_Tenure
FROM churn_cleaned
GROUP BY `Customer Status`;

/*
INSIGHT:
This comparison helps determine whether customer
loyalty increases with tenure.
*/


/* ==========================================================
   EXECUTIVE SUMMARY
========================================================== */

/*
KEY FINDINGS

1. Overall churn rate stands at 20.37%.

2. Germany records the highest churn rate among
   all geographies.

3. Senior customers are the most vulnerable age
   segment.

4. Inactive customers churn almost twice as often
   as active customers.

5. Customers owning 3+ products display extremely
   high churn behavior.

6. Credit card ownership has minimal influence
   on churn.

7. Female customers churn significantly more than
   male customers.

8. Germany-Female customers represent the
   highest-risk customer segment.
*/


/* ==========================================================
   FINAL BUSINESS RECOMMENDATIONS
========================================================== */

/*
1. Prioritize retention initiatives in Germany.

2. Develop loyalty programs for senior customers.

3. Increase engagement among inactive customers.

4. Investigate dissatisfaction among customers
   holding multiple banking products.

5. Create personalized retention strategies for
   female customers.

6. Build predictive churn monitoring systems for
   high-risk customer segments.

7. Focus immediate retention efforts on
   Germany-Female customers.
*/

-- END OF ANALYSIS
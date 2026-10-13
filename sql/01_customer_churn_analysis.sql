
-- Query 1: How many customers are in each customer status?

SELECT
    "Customer Status",
    COUNT(*) AS customer_count
FROM customers
GROUP BY "Customer Status"
ORDER BY customer_count DESC;





-- Query 2: What percentage of each contract group churned?
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN "Customer Status" = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Customer Status" = 'Churned' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS churn_percentage
FROM customers
GROUP BY Contract
ORDER BY churn_percentage DESC;





-- Query 3: Which internet types have the highest churn percentage?
SELECT
    "Internet Type",
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN "Customer Status" = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Customer Status" = 'Churned' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS churn_percentage
FROM customers
WHERE "Internet Service" = 'Yes'
GROUP BY "Internet Type"
ORDER BY churn_percentage DESC;





-- Query 4: Contract churn analysis
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN "Customer Status" = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Customer Status" = 'Churned' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS churn_percentage
FROM customers
GROUP BY Contract
ORDER BY churn_percentage DESC;





-- Query 5: Churn by customer tenure
SELECT
    CASE
        WHEN "Tenure in Months" <= 12 THEN '0-12 months'
        WHEN "Tenure in Months" <= 24 THEN '13-24 months'
        WHEN "Tenure in Months" <= 48 THEN '25-48 months'
        ELSE '49-72 months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN "Customer Status" = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        CAST(
            SUM(
                CASE
                    WHEN "Customer Status" = 'Churned' THEN 1
                    ELSE 0
                END
            ) AS REAL
        ) * 100 / COUNT(*),
        2
    ) AS churn_percentage
FROM customers
GROUP BY tenure_group
ORDER BY
    CASE tenure_group
        WHEN '0-12 months' THEN 1
        WHEN '13-24 months' THEN 2
        WHEN '25-48 months' THEN 3
        ELSE 4
    END;
    
    
    
    
    -- Query 6 Churn by payment method
    SELECT
    "Payment Method",
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN "Customer Status" = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        CAST(
            SUM(
                CASE
                    WHEN "Customer Status" = 'Churned' THEN 1
                    ELSE 0
                END
            ) AS REAL
        ) * 100 / COUNT(*),
        2
    ) AS churn_percentage
FROM customers
GROUP BY "Payment Method"
ORDER BY churn_percentage DESC;
    
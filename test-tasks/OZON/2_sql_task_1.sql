SELECT 
    Client_id as Клиент,
    t.Report_date as дата,
    Txn_amount/
(
    SELECT top 1 CCy_rate
FROM 
    Rates 
WHERE 
    Report_date<=t.report_date 
    AND CCy_code=840 
ORDER BY 
    Report_date DESC
)
    AS 'сумма операцийв usd'
FROM 
    transactions AS t
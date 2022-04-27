SELECT 
	Client_id, 
	CONCAT(YEAR(Report_date), '-', MONTH(Report_date)) as Report_date
	,SUM(CASE WHEN [Txn_type] = 'debit' THEN Txn_amount ELSE 0 END) AS Debit_amount
    ,SUM(CASE WHEN [Txn_type] = 'credit' THEN Txn_amount ELSE 0 END) AS Credit_amount
	,MAX(Report_date) AS Last_VSP
FROM 
	VSP_oper_data
GROUP BY 
	 YEAR(Report_date)
	 ,MONTH(Report_date), Client_id
	 
	 
	 
	 
	 
	 
SELECT
	Client_id
	,l.Report_date
	,1.0*Sum_client/sum_all*100 AS Ratio
FROM
	(
	SELECT
	Client_id, 
	CONCAT(YEAR(Report_date), '-', MONTH(Report_date)) as Report_date
	,SUM([Txn_amount]) as Sum_client
FROM	
	VSP_oper_data
WHERE 
	Txn_type = 'debit'
GROUP BY 
	 YEAR(Report_date)
	 ,MONTH(Report_date), Client_id
	 ) as l

 JOIN 
	
	(
	SELECT
	CONCAT(YEAR(Report_date), '-', MONTH(Report_date)) as Report_date
	,SUM([Txn_amount]) as sum_all
FROM	
	VSP_oper_data
WHERE 
	Txn_type = 'debit'
GROUP BY 
	 YEAR(Report_date)
	 ,MONTH(Report_date)
	 ) as r
ON 
	l.Report_date=r.Report_date




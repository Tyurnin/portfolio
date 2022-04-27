/**Задание: Напишите sql запрос, который будет переводить сумму транзакций в usd (ccy_code = 840) с учетом того, 
что в таблице rates данные только за рабочие дни. Транзакции, совершенные в выходные, 
пересчитываются по курсу последнего рабочего дня перед праздником/выходным. 
**/
Результат: Клиент, дата, сумма операций в usd.

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
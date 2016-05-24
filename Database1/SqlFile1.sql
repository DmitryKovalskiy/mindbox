/*
При наличии данных о типе saleId, на мой взгляд скрипт можно сделать гораздо проще.
*/

;WITH FirstSales(productId,customerId, [dateTime])as
(
	SELECT ProductId,customerId, MIN[dateTime]
	FROM Sales(NOLOCK)
	GROUP BY ProductId,customerId
),
SalesId(saleId) AS
(
	SELECT saleId FROM Sales (NOLOCK) as s
	INNER JOIN FirstSales (NOLOCK) as fs ON s.productId = fs.productId 
								AND s.customerId = fs.customerId
								AND s.dateTime = fs.dateTime
)
SELECT productId,COUNT(1) FROM Sales as s(NOLOCK)
INNER JOIN SalesId as sid (NOLOCK) ON s.saleId = sid.saleId
GROUP BY productId

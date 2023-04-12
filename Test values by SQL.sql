/* Check null or empty values in hotel_revenue_draft */

SELECT COUNT(*)
FROM dbo.hotel_revenue_draft
WHERE agent = 0
; -- 19,555

SELECT COUNT(country)
FROM dbo.hotel_revenue_draft
WHERE country =''
; -- 625

/* Check invalid values hotel_revenue_draft */

SELECT COUNT(*)
FROM dbo.hotel_revenue_draft
WHERE meal = 'Undefined'
; -- 1,372

SELECT COUNT(*)
FROM dbo.hotel_revenue_draft
WHERE market_segment = 'Undefined'
; -- 4

SELECT COUNT(*)
FROM dbo.hotel_revenue_draft
WHERE distribution_channel = 'Undefined'
; -- 10

SELECT COUNT(*)
FROM dbo.hotel_revenue_draft
WHERE arrival_date_week_number = '53'
; -- 2636

SELECT COUNT(*)
FROM dbo.hotel_revenue_draft
WHERE adr ='5400'
;

/* Check null or empty values in hotel_revenue_edited */

SELECT COUNT(*)
FROM dbo.hotel_revenue_edited
WHERE agent IS NULL
; -- 19,555

SELECT COUNT(country)
FROM dbo.hotel_revenue_edited
WHERE country =''
; -- 625

/* Check invalid values hotel_revenue_edited */

SELECT COUNT(*)
FROM dbo.hotel_revenue_edited
WHERE meal = 'Undefined'
; -- 1,372

SELECT COUNT(*)
FROM dbo.hotel_revenue_edited
WHERE market_segment = 'Undefined'
; -- 4

SELECT COUNT(*)
FROM dbo.hotel_revenue_edited
WHERE distribution_channel = 'Undefined'
; -- 10

SELECT COUNT(*)
FROM dbo.hotel_revenue_edited
WHERE arrival_date_week_number = '53'
; -- 2636

 
 /* The average daily rate (ADR) is a metric widely used in the hospitality industry 
 to indicate the average revenue earned for an occupied room on a given day. 
 The average daily rate is one of the key performance indicators (KPI) of the industry.
 Average Daily Rate = Rooms Revenue Earned / Number of Rooms Sold​
*/

SELECT COUNT(DISTINCT country)
FROM dbo.hotel_revenue
--177

SELECT * 
FROM dbo.hotel_revenue
WHERE adults = 0 
; -- 448


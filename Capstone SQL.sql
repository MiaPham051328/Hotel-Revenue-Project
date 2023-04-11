/* Create table hotel_revenue */

WITH hotel_revenue AS
(
SELECT * FROM dbo.HRH2018
UNION ALL
SELECT * FROM dbo.HRH2019
UNION ALL
SELECT * FROM dbo.HRH2020
)
SELECT * 
INTO dbo.hotel_revenue_draft 
FROM hotel_revenue 

/* Handle missing, null and invalid values
 1. Drop some unrelated columns: 'reserved_room_type','assigned_room_type', 'reservation_status_date' */
 
 ALTER TABLE dbo.hotel_revenue_draft
 DROP COLUMN reserved_room_type

 ALTER TABLE dbo.hotel_revenue_draft
 DROP COLUMN assigned_room_type

 ALTER TABLE dbo.hotel_revenue_draft
 DROP COLUMN reservation_status_date

 /* 
 2. Handle missing, null and invalid values
 - agent column: replace 0 value by 'No Agent' value (19,555 values)
 - country column: replace with the highest frequency value - PRT (625 of blank values) and replace 'CN' by 'CAN'
 - meal column: replace 'Undefined' values in meal column with highest frequency value 'BB'
 - market_segment column: replace 'Undefined' values in market_segment with the highest frequency value 'Online TA'
 - distribution_channel column: replace 'Undefined' values in distribution_channel with 'TA/TO'
 - arrival_date_week_number column: replace 53 in arrival_date_week_number to 52, because there are only 52 weeks in year

 */
 SELECT hotel
      ,is_canceled
      ,lead_time
      ,arrival_date_year
      ,arrival_date_month
      ,IIF (arrival_date_week_number = '53' , '52', arrival_date_week_number) as arrival_date_week_number
      ,arrival_date_day_of_month
      ,stays_in_weekend_nights
      ,stays_in_week_nights
      ,adults
      ,children
      ,babies
      ,IIF (meal = 'Undefined', 'BB', meal) as meal
      ,CASE 
	   WHEN country = '' THEN 'PRT'
	   WHEN country = 'CN' THEN 'CAN'
	   ELSE country
	   END as country
      ,IIF (market_segment = 'Undefined', 'Online TA', market_segment) as market_segment
      ,IIF (distribution_channel = 'Undefined', 'TA/TO', distribution_channel) as distribution_channel
      ,is_repeated_guest
      ,previous_cancellations 
      ,previous_bookings_not_canceled
      ,booking_changes
      ,deposit_type
      ,IIF (agent = '0', 'No Agent', CAST(ROUND(agent,0) AS varchar)) as agent
      ,days_in_waiting_list
      ,customer_type
      ,adr
      ,required_car_parking_spaces
      ,total_of_special_requests
      ,reservation_status
INTO dbo.hotel_revenue_edited
FROM dbo.hotel_revenue_draft 
; -- 141,947

/* Delete rows have invalid values */

-- Delete row data with ADR 5,400, because it seems like a data entry error
DELETE
FROM dbo.hotel_revenue
WHERE adr ='5400'
; -- 1

-- Delete row data consist of negative ADR (average daily rate), because it's not possible that room price is negative
DELETE
FROM dbo.hotel_revenue
WHERE adr < 0
; -- 1

-- Delete row data with 0 in adults column, because most of hotels won't permit anybody younger than 18 to stay in a room unaccompanied.
DELETE
FROM dbo.hotel_revenue
WHERE adults = 0
; -- 448

/* Insert new country into dbo.country*/

INSERT INTO dbo.country (country, country_name)
VALUES ('TMP', 'East Timor')

/* Join all tables te extract information */

SELECT  hre.hotel 
      , hre.is_canceled 
      , hre.lead_time 
      , hre.arrival_date_year 
      , hre.arrival_date_month 
      , hre.arrival_date_week_number 
      , hre.arrival_date_day_of_month 
      , hre.stays_in_weekend_nights 
      , hre.stays_in_week_nights 
      , hre.adults 
      , hre.children 
      , hre.babies 
      , mc.meal 
	  , ROUND(mc.Cost,2) as cost
	  , hre.country 
	  , dc.country_name
      , ms.market_segment 
	  , ROUND(ms.Discount,2) as discount
      , hre.distribution_channel 
      , hre.is_repeated_guest 
      , hre.previous_cancellations 
      , hre.previous_bookings_not_canceled 
      , hre.booking_changes 
      , hre.deposit_type 
      , hre.agent 
      , hre.days_in_waiting_list 
      , hre.customer_type 
      , hre.adr 
      , hre.required_car_parking_spaces 
      , hre.total_of_special_requests 
      , hre.reservation_status 
INTO dbo.hotel_revenue
FROM dbo.hotel_revenue_edited hre
LEFT OUTER JOIN dbo.market_segment ms
ON hre.market_segment = ms.market_segment
LEFT OUTER JOIN dbo.meal_cost mc
ON hre.meal = mc.meal
LEFT OUTER JOIN dbo.country dc
ON hre.country = dc.country
; -- 141,497

/* Aggregating information */

-- Total nights
SELECT COUNT(*) as 'Total', SUM(stays_in_week_nights+stays_in_weekend_nights) as 'Total Nights'
FROM dbo.hotel_revenue
; -- 484,120

-- Total required car parking spaces
SELECT COUNT(*) as 'Total', SUM(required_car_parking_spaces) as'Total RCPS'
FROM dbo.hotel_revenue
; -- 8,810

-- Total revenue
-- Before discount
SELECT COUNT(*) as 'Total', ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as 'Revenue'
FROM dbo.hotel_revenue
; -- 49,593,220

-- Have discount
SELECT COUNT(*) as 'Total', ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr*(1-discount)),2) as 'Revenue'
FROM dbo.hotel_revenue
; -- 37,285,675

-- Total guests
SELECT COUNT(*) as 'Total',SUM(adults+children+babies) as 'Total Guest'
FROM dbo.hotel_revenue
; -- 277,471

-- Aggregating table	
SELECT hotel
	  ,is_canceled
	  ,arrival_date_year as 'Year'
      ,arrival_date_month as 'Month'
	  ,meal
	  ,CASE 
	  WHEN meal='BB' THEN 'Bed & Breakfast'
	  WHEN meal='HB' THEN 'Half Board'
	  WHEN meal='SC' THEN 'Self Catering'
	  ELSE 'Full Borad'
	  END as 'meal_name'
	  ,market_segment
	  ,discount
	  ,country
	  ,country_name
	  ,ROUND(SUM(cost),2) as 'revenue from meal'
	  ,ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr*(1-discount)),2) as 'Revenue by Year'
	  ,SUM(adults+children+babies) as 'Total Guest'
	  ,SUM(required_car_parking_spaces) as'Total RCPS'
FROM dbo.hotel_revenue
GROUP BY hotel
		,is_canceled
	    ,arrival_date_year 
        ,arrival_date_month 
	    ,meal
		,market_segment
	    ,discount
	    ,country
	    ,country_name


-- CREATE EVN_average_customer_waiting_time_every_1_hour
CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON SCHEDULE EVERY 1 HOUR
DO
 SELECT 
 AVG(TIMESTAMPDIFF(MINUTE, customer_arrival_time, customer_served_time)) 
 AS average_waiting_time
 FROM customer_service;
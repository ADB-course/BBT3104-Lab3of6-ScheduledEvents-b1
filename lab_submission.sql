-- CREATE EVN_average_customer_waiting_time_every_1_hour
CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON SCHEDULE EVERY 1 HOUR
DO
 SELECT 
 AVG(TIMESTAMPDIFF(MINUTE, customer_arrival_time, customer_served_time)) 
 AS average_waiting_time
 FROM customer_service;


 DELIMITER //

CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    INSERT INTO customer_service_kpi (
         average_waiting_time,
        date_recorded
    )
    SELECT
        -- Calculate average waiting time for tickets raised in the past hour
        AVG(TIMESTAMPDIFF(MINUTE, customer_service_ticket_raise_time, NOW())) AS average_waiting_time,
        NOW() AS date_recorded
        -- Add other columns from customer_service_ticket table as needed
    FROM customer_service_ticket
    WHERE customer_service_ticket_raise_time >= NOW() - INTERVAL 1 HOUR;
END //

DELIMITER ;
CREATE or REPLACE VIEW v_supply_chain_performance AS
SELECT CAST("order date (DateOrders)" AS DATE) order_date, "Shipping Mode",
COUNT(*) total_orders,
ROUND(AVG("Calculated_Lead_Time"), 2) avg_lead_time_days,
ROUND(
  SUM(CASE WHEN "Days for shipping (real)" > "Days for shipment (scheduled)" THEN 1 
  ELSE 0 END) * 100.0 / COUNT(*), 2) late_delivery_rate_pct
  FROM supply_chain_ledger
  GROUP BY
  CAST("order date (DateOrders)" AS DATE),
  "Shipping Mode";
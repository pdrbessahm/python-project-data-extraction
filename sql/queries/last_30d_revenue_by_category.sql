SELECT
  p.category,
  SUM(oi.quantity * oi.unit_price) AS revenue,
  COUNT(*) AS line_count
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
JOIN products p     ON p.id = oi.product_id
WHERE o.order_date BETWEEN :start_date AND :end_date
GROUP BY p.category
ORDER BY revenue DESC;
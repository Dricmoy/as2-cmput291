SELECT m.email,
       COUNT(DISTINCT p.pid) AS total_penalties,
       COUNT(DISTINCT CASE WHEN p.paid_amount >= p.amount THEN p.pid END) AS paid_penalties,
       COALESCE(SUM(CASE WHEN p.paid_amount >= p.amount THEN p.paid_amount ELSE 0 END), 0) AS total_paid_amount
FROM members m
LEFT JOIN penalties p ON m.email = p.bid
GROUP BY m.email;

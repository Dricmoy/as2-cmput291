SELECT m.email,
       COUNT(p.pid) AS total_penalties,
       COUNT(CASE WHEN p.paid_amount >= p.amount THEN 1 END) AS paid_penalties,
       SUM(CASE WHEN p.paid_amount >= p.amount THEN p.paid_amount ELSE 0 END) AS total_paid_amount
FROM members m
LEFT JOIN penalties p ON m.email = p.bid
GROUP BY m.email;

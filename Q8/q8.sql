SELECT m.email,
       COUNT(p.pid) AS total_penalties,
       COUNT(CASE WHEN p.paid_amount >= p.amount THEN 1 END) AS paid_penalties,
       COALESCE(SUM(CASE WHEN p.paid_amount >= p.amount THEN p.paid_amount ELSE 0 END), 0) AS total_paid_amount
FROM members m
LEFT JOIN penalties p ON m.email = p.member
GROUP BY m.email;

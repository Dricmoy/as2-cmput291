SELECT m.email,
       COUNT(DISTINCT p.pid) AS total_penalties,
       COUNT(DISTINCT p_paid.pid) AS paid_penalties,
       COALESCE(SUM(p.paid_amount), 0) AS total_paid_amount
FROM members m
LEFT JOIN penalties p ON m.email = p.member
LEFT JOIN (
    SELECT pid
    FROM penalties
    WHERE paid_amount >= amount
) AS p_paid ON p.pid = p_paid.pid
GROUP BY m.email;
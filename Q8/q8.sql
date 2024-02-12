SELECT
    M.email,
    COALESCE(COUNT(DISTINCT P.pid), 0) AS total_penalties,
    COALESCE(COUNT(DISTINCT CASE WHEN P.paid_amount >= P.amount THEN P.pid END), 0) AS paid_penalties,
    COALESCE(SUM(CASE WHEN P.paid_amount >= P.amount THEN P.amount ELSE 0 END), 0) AS total_paid_amount
FROM members M
LEFT JOIN borrowings B ON M.email = B.member
LEFT JOIN penalties P ON B.bid = P.bid
GROUP BY M.email;

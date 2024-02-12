SELECT
    M.email,
    COUNT(DISTINCT P.pid) AS total_penalties,
    COUNT(DISTINCT CASE WHEN P.paid_amount >= P.amount THEN P.pid END) AS paid_penalties,
    COALESCE(SUM(CASE WHEN P.paid_amount >= P.amount THEN P.amount END), 0) AS total_paid_amount
FROM members M
LEFT JOIN borrowings B ON M.email = B.member
LEFT JOIN penalties P ON B.bid = P.bid
GROUP BY M.email;

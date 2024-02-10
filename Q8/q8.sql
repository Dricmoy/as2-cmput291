SELECT
    m.email,
    COALESCE(p.total_penalties, 0) AS total_penalties,
    COALESCE(p.paid_penalties, 0) AS paid_penalties,
    COALESCE(p.total_paid_amount, 0) AS total_paid_amount
FROM
    members m
LEFT JOIN (
    SELECT
        member,
        COUNT(*) AS total_penalties,
        SUM(CASE WHEN paid_amount >= amount THEN 1 ELSE 0 END) AS paid_penalties,
        SUM(CASE WHEN paid_amount >= amount THEN paid_amount ELSE 0 END) AS total_paid_amount
    FROM
        borrowings b
    JOIN penalties p ON b.bid = p.bid
    GROUP BY
        member
) p ON m.email = p.member;

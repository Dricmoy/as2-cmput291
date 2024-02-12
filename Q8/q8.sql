WITH PenaltyCounts AS (
    SELECT
        m.email,
        COUNT(DISTINCT p.pid) AS total_penalties,
        COUNT(DISTINCT CASE WHEN p.paid_amount >= p.amount THEN p.pid END) AS paid_penalties,
        SUM(CASE WHEN p.paid_amount >= p.amount THEN p.paid_amount ELSE 0 END) AS total_paid_amount
    FROM
        members m
    LEFT JOIN borrowings b ON m.email = b.member
    LEFT JOIN penalties p ON b.bid = p.bid
    GROUP BY
        m.email
    HAVING
        COUNT(DISTINCT p.pid) > 0
)

SELECT
    pc.email,
    COALESCE(pc.total_penalties, 0) AS total_penalties,
    COALESCE(pc.paid_penalties, 0) AS paid_penalties,
    COALESCE(pc.total_paid_amount, 0) AS total_paid_amount
FROM
    PenaltyCounts pc;
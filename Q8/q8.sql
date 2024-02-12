WITH PenaltyCounts AS (
    SELECT
        members.email,
        COUNT(DISTINCT penalties.pid) AS total_penalties,
        COUNT(DISTINCT CASE WHEN penalties.paid_amount >= penalties.amount THEN penalties.pid END) AS paid_penalties,
        SUM(CASE WHEN penalties.paid_amount >= penalties.amount THEN penalties.paid_amount ELSE 0 END) AS total_paid_amount
    FROM
        members
    LEFT JOIN borrowings ON members.email = borrowings.member
    LEFT JOIN penalties ON borrowings.bid = penalties.bid
    GROUP BY
        members.email
    HAVING
        COUNT(DISTINCT penalties.pid) > 0
)

SELECT
    email,
    COALESCE(total_penalties, 0) AS total_penalties,
    COALESCE(paid_penalties, 0) AS paid_penalties,
    COALESCE(total_paid_amount, 0) AS total_paid_amount
FROM
<<<<<<< HEAD
    PenaltyCounts pc;
=======
    PenaltyCounts;
>>>>>>> 7060a45a095663638d959036c5f9ce80a9fa30a3

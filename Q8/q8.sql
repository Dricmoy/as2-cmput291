WITH PenaltyStats AS (
    SELECT
        B.member AS email,
        COUNT(P.pid) AS total_penalties,
        COUNT(CASE WHEN P.paid_amount >= P.amount THEN 1 END) AS paid_penalties,
        SUM(CASE WHEN P.paid_amount >= P.amount THEN P.amount ELSE 0 END) AS total_paid_amount
    FROM borrowings B
    LEFT JOIN penalties P ON B.bid = P.bid
    GROUP BY B.member
)

SELECT
    M.email,
    COALESCE(PS.total_penalties, 0) AS total_penalties,
    COALESCE(PS.paid_penalties, 0) AS paid_penalties,
    COALESCE(PS.total_paid_amount, 0) AS total_paid_amount
FROM members M
LEFT JOIN PenaltyStats PS ON M.email = PS.email
WHERE PS.email IS NOT NULL OR PS.email IS NULL; -- Include users with no paid penalties

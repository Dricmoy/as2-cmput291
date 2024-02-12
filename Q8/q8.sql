WITH PenaltyStats AS (
    SELECT
        B.member,
        COUNT(P.pid) AS total_penalties,
        SUM(CASE WHEN P.paid_amount >= P.amount THEN 1 ELSE 0 END) AS paid_penalties,
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
FROM
    members M
LEFT JOIN PenaltyStats PS ON M.email = PS.member;

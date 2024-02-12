WITH PenaltyStats AS (
    SELECT
        B.member,
        COUNT(DISTINCT P.pid) AS total_penalties,
        COUNT(DISTINCT CASE WHEN P.paid_amount >= P.amount THEN P.pid END) AS paid_penalties,
        IFNULL(SUM(CASE WHEN P.paid_amount >= P.amount THEN P.amount END), 0) AS total_paid_amount
    FROM borrowings B
    LEFT JOIN penalties P ON B.bid = P.bid
    GROUP BY B.member
)

SELECT
    M.email,
    IFNULL(PS.total_penalties, 0) AS total_penalties,
    IFNULL(PS.paid_penalties, 0) AS paid_penalties,
    IFNULL(PS.total_paid_amount, 0) AS total_paid_amount
FROM
    members M
LEFT JOIN PenaltyStats PS ON M.email = PS.member;
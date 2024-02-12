WITH PenaltyStats AS (
    SELECT
        member,
        COUNT(pid) AS total_penalties,
        SUM(CASE WHEN paid_amount >= amount THEN 1 ELSE 0 END) AS paid_penalties,
        SUM(CASE WHEN paid_amount >= amount THEN amount ELSE 0 END) AS total_paid_amount
    FROM penalties
    GROUP BY member
)

SELECT
    M.email,
    COALESCE(PS.total_penalties, 0) AS total_penalties,
    COALESCE(PS.paid_penalties, 0) AS paid_penalties,
    COALESCE(PS.total_paid_amount, 0) AS total_paid_amount
FROM
    members M
LEFT JOIN PenaltyStats PS ON M.email = PS.member;

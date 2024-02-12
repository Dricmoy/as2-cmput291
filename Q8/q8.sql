WITH PenaltyStats AS (
    SELECT
        bid AS member,  -- Replace 'bid' with the correct column name that corresponds to the member identifier in your 'penalties' table
        COUNT(pid) AS total_penalties,
        SUM(CASE WHEN paid_amount >= amount THEN 1 ELSE 0 END) AS paid_penalties,
        SUM(CASE WHEN paid_amount >= amount THEN amount ELSE 0 END) AS total_paid_amount
    FROM penalties
    GROUP BY bid  -- Replace 'bid' with the correct column name that corresponds to the member identifier in your 'penalties' table
)

SELECT
    M.email,
    COALESCE(PS.total_penalties, 0) AS total_penalties,
    COALESCE(PS.paid_penalties, 0) AS paid_penalties,
    COALESCE(PS.total_paid_amount, 0) AS total_paid_amount
FROM
    members M
LEFT JOIN PenaltyStats PS ON M.email = PS.member;

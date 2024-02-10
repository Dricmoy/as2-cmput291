SELECT
    m.email,
    COALESCE(total_penalties, 0) AS total_penalties,
    COALESCE(paid_penalties, 0) AS paid_penalties,
    COALESCE(total_paid_amount, 0) AS total_paid_amount
FROM members m
LEFT JOIN (
    SELECT
        member,
        COUNT(pid) AS total_penalties,
        SUM(CASE WHEN paid_amount >= amount THEN 1 ELSE 0 END) AS paid_penalties,
        SUM(CASE WHEN paid_amount >= amount THEN paid_amount ELSE 0 END) AS total_paid_amount
    FROM penalties
    GROUP BY member
) AS penalty_summary ON m.email = penalty_summary.member;

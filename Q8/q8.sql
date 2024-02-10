SELECT Members.email,
       COUNT(Penalties.penalty_id) AS total_penalties,
       COUNT(CASE WHEN Penalties.paid_amount >= Penalties.penalty_amount THEN 1 END) AS paid_penalties,
       SUM(CASE WHEN Penalties.paid_amount >= Penalties.penalty_amount THEN Penalties.paid_amount ELSE 0 END) AS total_paid_amount
FROM Members
LEFT JOIN Penalties ON Members.member_id = Penalties.member_id
GROUP BY Members.email;

SELECT B.bid, M.email AS borrower_email
FROM borrowings B
JOIN members M ON B.member = M.email
WHERE julianday(B.end_date) - julianday(B.start_date) > 14
  AND B.book_id NOT IN (
    SELECT W.book_id
    FROM waitlists W
    WHERE W.priority >= 5
);

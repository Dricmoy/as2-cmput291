SELECT B.bid, M.email AS borrower_email
FROM borrowings B
JOIN members M ON B.member = M.email
LEFT JOIN waitlists W ON B.book_id = W.book_id AND W.priority >= 5
WHERE julianday(B.end_date) - julianday(B.start_date) > 14
  AND W.wid IS NULL;

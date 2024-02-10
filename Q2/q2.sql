SELECT B.bid, M.email AS borrower_email, B.end_date
FROM borrowings B
JOIN members M ON B.member = M.email
JOIN books BK ON B.book_id = BK.book_id
WHERE M.faculty = 'CS'
  AND (LOWER(BK.author) LIKE '%john%' OR LOWER(BK.author) LIKE '%marry%');

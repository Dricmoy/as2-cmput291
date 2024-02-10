SELECT b.book_id, b.title,
       COUNT(br.bid) AS borrow_count
FROM books b
LEFT JOIN borrowings br ON b.book_id = br.book_id
LEFT JOIN waitlists w ON b.book_id = w.book_id
WHERE b.pyear <= 2015
  AND (br.bid IS NOT NULL AND br.bid >= 2 * COALESCE(w.wid, 0))
GROUP BY b.book_id;

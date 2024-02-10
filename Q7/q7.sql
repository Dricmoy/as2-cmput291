SELECT b.book_id, b.title, b.pyear
FROM books b
JOIN borrowings br ON b.book_id = br.book_id
GROUP BY b.book_id, b.title, b.pyear
ORDER BY COUNT(br.bid) DESC, b.book_id
LIMIT 3;

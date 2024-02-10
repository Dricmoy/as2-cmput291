CREATE VIEW book_info AS
SELECT b.book_id,
       b.title,
       COALESCE(COUNT(DISTINCT r.rid), 0) AS revcnt,
       COALESCE(AVG(r.rating), 0) AS rating,
       COALESCE(AVG(CASE WHEN strftime('%Y', r.rdate) = '2023' THEN r.rating END), 0) AS rating23,
       COALESCE(bwc.borrow_wait_count, 0) AS reqcnt
FROM books b
LEFT JOIN reviews r ON b.book_id = r.book_id
LEFT JOIN (
    SELECT book_id, COUNT(DISTINCT bid) + COUNT(DISTINCT wid) AS borrow_wait_count
    FROM (
        SELECT book_id, bid, NULL AS wid FROM borrowings
        UNION ALL
        SELECT book_id, NULL AS bid, wid FROM waitlists
    ) AS combined
    GROUP BY book_id
) AS bwc ON b.book_id = bwc.book_id
GROUP BY b.book_id, b.title;

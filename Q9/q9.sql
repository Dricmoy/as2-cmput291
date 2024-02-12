CREATE VIEW book_info AS
SELECT
    b.book_id,
    b.title,
    COALESCE(COUNT(DISTINCT r.rid), 0) AS revcnt,
    COALESCE(AVG(r.rating), 0) AS rating,
    COALESCE(AVG(CASE WHEN strftime('%Y', r.rdate) = '2023' THEN r.rating ELSE NULL END), 0) AS rating23,
    COALESCE(SUM(COALESCE(w.req_count, 0) + COALESCE(bo.borrow_count, 0)), 0) AS reqcnt
FROM
    books b
LEFT JOIN
    reviews r ON b.book_id = r.book_id
LEFT JOIN
    (
        SELECT book_id, COUNT(*) as req_count
        FROM waitlists
        GROUP BY book_id
    ) w ON b.book_id = w.book_id
LEFT JOIN
    (
        SELECT book_id, COUNT(*) as borrow_count
        FROM borrowings
        GROUP BY book_id
    ) bo ON b.book_id = bo.book_id
GROUP BY
    b.book_id, b.title;

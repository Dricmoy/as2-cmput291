CREATE VIEW book_info AS
SELECT
    b.book_id,
    b.title,
    COALESCE(COUNT(DISTINCT r.rid), 0) AS revcnt,
    COALESCE(AVG(r.rating), 0) AS rating,
    COALESCE(AVG(CASE WHEN strftime('%Y', r.rdate) = '2023' THEN r.rating END), 0) AS rating23,
    COALESCE(COUNT(DISTINCT bo.bid) + COUNT(DISTINCT w.wid), 0) AS reqcnt
FROM
    books b
LEFT JOIN
    reviews r ON b.book_id = r.book_id
LEFT JOIN
    borrowings bo ON b.book_id = bo.book_id
LEFT JOIN
    waitlists w ON b.book_id = w.book_id
GROUP BY
    b.book_id, b.title;

SELECT * from book_info
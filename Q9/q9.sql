CREATE VIEW book_info AS
SELECT
    b.book_id,
    b.title,
    COUNT(r.rid) AS revcnt,
    AVG(r.rating) AS rating,
    AVG(CASE WHEN strftime('%Y', r.rdate) = '2023' THEN r.rating ELSE NULL END) AS rating23,
    COUNT(DISTINCT COALESCE(borrowings.bid, waitlists.wid)) AS reqcnt
FROM
    books b
LEFT JOIN
    reviews r ON b.book_id = r.book_id
LEFT JOIN
    borrowings ON b.book_id = borrowings.book_id
LEFT JOIN
    waitlists ON b.book_id = waitlists.book_id
GROUP BY
    b.book_id;

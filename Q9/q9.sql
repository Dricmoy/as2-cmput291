CREATE VIEW book_info AS
SELECT Books.book_id, Books.title,
       COUNT(Reviews.review_id) AS revcnt,
       AVG(Reviews.rating) AS rating,
       AVG(CASE WHEN strftime('%Y', Reviews.review_date) = '2023' THEN Reviews.rating END) AS rating23,
       COUNT(Borrowings.bid) + COALESCE(Waitlist.wait_count, 0) AS reqcnt
FROM Books
LEFT JOIN Reviews ON Books.book_id = Reviews.book_id
LEFT JOIN Borrowings ON Books.book_id = Borrowings.book_id
LEFT JOIN Waitlist ON Books.book_id = Waitlist.book_id
GROUP BY Books.book_id;

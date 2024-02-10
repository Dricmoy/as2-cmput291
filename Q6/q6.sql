SELECT Books.book_id, Books.title,
       COUNT(Borrowings.bid) AS borrow_count
FROM Books
LEFT JOIN Borrowings ON Books.book_id = Borrowings.book_id
WHERE Books.publish_year <= 2015
  AND (Borrowings.bid IS NOT NULL AND Borrowings.bid >= 2 * COALESCE(Waitlist.wait_count, 0))
GROUP BY Books.book_id;

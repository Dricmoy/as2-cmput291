SELECT Books.book_id, Books.title, Books.author,
       COUNT(Borrowings.bid) AS borrow_count,
       MAX(Borrowings.start_date) AS most_recent_borrow_date
FROM Books
LEFT JOIN Borrowings ON Books.book_id = Borrowings.book_id
WHERE Books.pyear > 2001
GROUP BY Books.book_id;

SELECT Books.book_id, Books.title, Books.publish_year
FROM Books
JOIN Borrowings ON Books.book_id = Borrowings.book_id
GROUP BY Books.book_id
ORDER BY COUNT(Borrowings.bid) DESC
LIMIT 3;

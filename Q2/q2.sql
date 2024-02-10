SELECT Borrowings.bid, Members.email, Borrowings.end_date
FROM Borrowings
JOIN Members ON Borrowings.member_id = Members.member_id
JOIN Books ON Borrowings.book_id = Books.book_id
WHERE Books.author LIKE '%John%' OR Books.author LIKE '%Marry%'
  AND Books.book_id IN (
    SELECT Borrowings.book_id
    FROM Borrowings
    JOIN Members ON Borrowings.member_id = Members.member_id
    WHERE Members.faculty = 'CS'
);

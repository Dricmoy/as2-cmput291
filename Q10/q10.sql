SELECT DISTINCT Members.email
FROM Members
JOIN Borrowings ON Members.member_id = Borrowings.member_id
JOIN book_info ON Borrowings.book_id = book_info.book_id
WHERE book_info.rating > 3.5
  AND book_info.reqcnt > (SELECT AVG(reqcnt) FROM book_info);

SELECT Borrowings.bid, Members.email
FROM Borrowings
JOIN Members ON Borrowings.member_id = Members.member_id
WHERE Borrowings.end_date - Borrowings.start_date > 14
  AND Borrowings.book_id NOT IN (
    SELECT Waitlist.book_id
    FROM Waitlist
    WHERE Waitlist.priority >= 5
);

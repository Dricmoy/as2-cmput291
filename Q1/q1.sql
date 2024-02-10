SELECT Members.name, Members.email
FROM Members
JOIN Waitlist ON Members.member_id = Waitlist.member_id
JOIN Borrowings ON Members.member_id = Borrowings.member_id AND Waitlist.book_id = Borrowings.book_id;

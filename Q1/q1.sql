SELECT DISTINCT members.name, members.email
FROM members
JOIN borrowings ON members.email = borrowings.member
JOIN waitlists ON members.email = waitlists.member AND borrowings.book_id = waitlists.book_id;

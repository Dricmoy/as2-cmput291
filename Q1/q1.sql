SELECT DISTINCT M.name, M.email
FROM members M
JOIN borrowings B ON M.email = B.member
JOIN waitlists W ON M.email = W.member AND B.book_id = W.book_id;
ashjkjash
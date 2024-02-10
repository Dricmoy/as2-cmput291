SELECT DISTINCT m.email
FROM members m
JOIN borrowings br ON m.email = br.member
JOIN book_info bi ON br.book_id = bi.book_id
WHERE bi.rating > 3.5
  AND bi.reqcnt > (SELECT AVG(reqcnt) FROM book_info);

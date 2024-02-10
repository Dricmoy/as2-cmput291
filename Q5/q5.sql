SELECT r.book_id, b.title, AVG(r.rating) AS avg_rating
FROM reviews r
JOIN books b ON r.book_id = b.book_id
GROUP BY r.book_id
HAVING COUNT(r.rid) >= 2
ORDER BY avg_rating DESC
LIMIT 3;
SELECT R.book_id, B.title, AVG(R.rating) AS avg_rating
FROM reviews R
JOIN books B ON R.book_id = B.book_id
GROUP BY R.book_id, B.title
HAVING COUNT(R.rid) >= 2
ORDER BY avg_rating DESC
LIMIT 3;

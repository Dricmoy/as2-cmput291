SELECT Reviews.book_id, Books.title, AVG(Reviews.rating) AS avg_rating
FROM Reviews
JOIN Books ON Reviews.book_id = Books.book_id
GROUP BY Reviews.book_id
HAVING COUNT(Reviews.review_id) >= 2
ORDER BY avg_rating DESC
LIMIT 3;

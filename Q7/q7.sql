WITH BookRank AS (
  SELECT
    b.book_id,
    b.title,
    b.pyear,
    COUNT(br.bid) AS borrow_count,
    DENSE_RANK() OVER (ORDER BY COUNT(br.bid) DESC) AS ranking
  FROM
    books b
    JOIN borrowings br ON b.book_id = br.book_id
  GROUP BY
    b.book_id, b.title, b.pyear
)

SELECT book_id, title, pyear
FROM BookRank
WHERE ranking <= 3;

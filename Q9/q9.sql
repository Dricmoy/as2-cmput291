import sqlite3

# Replace 'test1.db' with the actual name of your SQLite database file
database_filename = 'test1.db'

try:
    # Attempt to establish a connection to the database
    conn = sqlite3.connect(database_filename)
    
    # Create a cursor object to execute SQL queries
    cursor = conn.cursor()

    # Drop the existing view if it exists
    cursor.execute("DROP VIEW IF EXISTS book_info;")

    # Create the new book_info view
    cursor.execute("""
        CREATE VIEW book_info AS
        SELECT
            b.book_id,
            b.title,
            COALESCE(COUNT(r.rid), 0) AS revcnt,
            COALESCE(AVG(r.rating), 0) AS rating,
            COALESCE(AVG(CASE WHEN strftime('%Y', r.rdate) = '2023' THEN r.rating ELSE NULL END), 0) AS rating23,
            COALESCE(SUM(COALESCE(w.priority, 0)), 0) AS reqcnt
        FROM
            books b
        LEFT JOIN
            reviews r ON b.book_id = r.book_id
        LEFT JOIN
            waitlists w ON b.book_id = w.book_id
        GROUP BY
            b.book_id, b.title;
    """)

    # Display the data from the book_info view
    cursor.execute("SELECT * FROM book_info;")
    tables = cursor.fetchall()
    
    # Print the result
    print(tables)

except sqlite3.Error as e:
    # Print an error message if the connection or query fails
    print(f"Error: {e}")

finally:
    # Don't forget to close the connection when done
    if conn:
        conn.close()

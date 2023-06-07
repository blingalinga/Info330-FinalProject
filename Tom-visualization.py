
import sqlite3
import matplotlib.pyplot as plt

# Connect to the SQLite database
conn = sqlite3.connect('movies.sqlite')
cursor = conn.cursor()

# Execute the query
query = """
SELECT country, COUNT(*) AS movie_count
FROM thirdnf_movie_data
GROUP BY country
ORDER BY movie_count DESC;
"""
cursor.execute(query)

# Fetch the query results
results = cursor.fetchall()

# Separate country and movie count into separate lists
countries = [row[0] for row in results]
movie_counts = [row[1] for row in results]

# Plot the movie counts by country
plt.figure(figsize=(12, 6))
plt.bar(countries, movie_counts)
plt.title('Movie Counts by Country')
plt.xlabel('Country')
plt.ylabel('Movie Count')
plt.xticks(rotation=90)
plt.tight_layout()
plt.show()

# Close the database connection
conn.close()

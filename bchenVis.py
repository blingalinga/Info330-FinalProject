# Bernita visualization

import matplotlib.pyplot as plt
import numpy as np
import sqlite3

# Connect to the SQLite database
conn = sqlite3.connect('movies.sqlite')

# Execute the SQL query
query = '''
SELECT m.names, AVG(score) AS avg_score
FROM thirdnf_movie_data AS m
WHERE date_x LIKE '%2023%'
GROUP BY m.names
ORDER BY AVG(score) DESC
LIMIT 10;
'''
cursor = conn.execute(query)
results = cursor.fetchall()

# Separate the movie names and average scores into separate lists
movie = [row[0] for row in results]
average_scores = [row[1] for row in results]

# Create the figure and axis objects
fig, ax = plt.subplots(figsize=(12, 6))

# Create a colormap that has a blue gradient
cmap = plt.cm.get_cmap('Greens')
colors = cmap(np.linspace(0.2, 0.8, len(movie)))

# Create the bar chart
bar_width = 0.5
bar_positions = np.arange(len(movie))
ax.bar(bar_positions, average_scores, width=bar_width, color=colors)

# Customize the chart appearance
ax.set_xlabel('Movie Names')
ax.set_ylabel('Average Score')
plt.title('Top 10 Movies of 2023 by Average Score')
ax.set_xticks(bar_positions)
ax.set_xticklabels(movie, rotation=45, ha='right')

# Display the chart
plt.tight_layout()
plt.show()

# Close the database connection
conn.close()

# Ling Ling's visualization

import sqlite3
import matplotlib.pyplot as plt
import numpy as np

# First, connect to the SQLite database file
conn = sqlite3.connect('movies.sqlite')
cursor = conn.cursor()

# Execute the query from before to retrieve average scores for each country
query = '''
SELECT country, AVG(score) AS average_score
FROM thirdnf_movie_data
GROUP BY country
ORDER BY average_score DESC
'''
cursor.execute(query)
results = cursor.fetchall()

# Separate the country names and average scores into separate lists
countries = [row[0] for row in results]
average_scores = [row[1] for row in results]

# Create the figure and axis objects
fig, ax = plt.subplots(figsize=(12, 6))

# Create a colormap that has a blue gradient
cmap = plt.cm.get_cmap('Blues')
colors = cmap(np.linspace(0.2, 0.8, len(countries)))

# Create the bar chart
bar_width = 0.5
bar_positions = np.arange(len(countries))
ax.bar(bar_positions, average_scores, width=bar_width, color=colors)

# Customize the chart appearance
ax.set_xlabel('Country')
ax.set_ylabel('Average Score')
ax.set_title('Average Scores by Country')
ax.set_xticks(bar_positions)
ax.set_xticklabels(countries, rotation=45, ha='right')

# Display the chart
plt.tight_layout()
plt.show()

# Close the database connection
conn.close()
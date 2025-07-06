-- Load the HDFS data
ads = LOAD '/dualcore/ad_data*/part*' USING PigStorage('\t') AS (display_site:chararray, keyword:chararray, was_clicked:int, cpc:float);

-- Filter for clicked ads
clicked_ads = FILTER ads BY was_clicked == 1;

-- Group by keyword
grouped_keywords = GROUP clicked_ads BY keyword;

-- Calculate total cost per keyword
keyword_costs = FOREACH grouped_keywords GENERATE group AS keyword, SUM(clicked_ads.cpc) AS total_cost;

-- Sort by total cost in descending order
sorted_keywords = ORDER keyword_costs BY total_cost DESC;

-- Display top 5 results
top_five = LIMIT sorted_keywords 5;
DUMP top_five;

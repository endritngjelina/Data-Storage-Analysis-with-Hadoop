-- Load the test data
ads = LOAD '/dualcore/ad_data*/part*' USING PigStorage('\t') AS (display_site:chararray, keyword:chararray, was_clicked:int, cpc:float);


-- Filter for records where the ad was clicked
clicked_ads = FILTER ads BY was_clicked == 1;

-- Group by display site
grouped_ads = GROUP clicked_ads BY display_site;

-- Calculate total cost per site
site_costs = FOREACH grouped_ads GENERATE group AS display_site, SUM(clicked_ads.cpc) AS total_cost;

-- Sort by total cost in ascending order
sorted_sites = ORDER site_costs BY total_cost ASC;

-- Display top 3 results
top_three = LIMIT sorted_sites 3;
DUMP top_three;


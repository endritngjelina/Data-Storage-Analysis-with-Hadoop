-- Load the data from both directories
data = LOAD '/dualcore/ad_data[12]' USING PigStorage('\t') AS (campaign_id:chararray,
             date:chararray, time:chararray,
             keyword:chararray, display_site:chararray,
             placement:chararray, was_clicked:int, cpc:int);

-- Filter to include only records where was_clicked has a value of 1
clicked_data = FILTER data BY was_clicked == 1;

-- Group all clicked records
grouped_data = GROUP clicked_data ALL;

-- Count the total number of clicked ads
total_clicks = FOREACH grouped_data GENERATE COUNT(clicked_data) AS total_click_count;

-- Display the total clicks
DUMP total_clicks;


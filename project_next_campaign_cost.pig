-- Load the data from both directories
data = LOAD '/dualcore/ad_data[12]' USING PigStorage('\t') AS (campaign_id:chararray,
             date:chararray, time:chararray,
             keyword:chararray, display_site:chararray,
             placement:chararray, was_clicked:int, cpc:int);

-- Remove FILTER statement to consider all ads
-- Group by an arbitrary field, here we use ALL
grouped_data = GROUP data ALL;

-- Find the maximum CPC
max_cpc = FOREACH grouped_data GENERATE MAX(data.cpc) AS max_cost;

-- Estimate total cost for 50,000 clicks
estimated_total_cost = FOREACH max_cpc GENERATE max_cost * 50000 AS estimated_total_cost;

-- Display the resulting value
DUMP estimated_total_cost;


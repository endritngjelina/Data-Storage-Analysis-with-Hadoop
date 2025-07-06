-- Load data from the directory
data = LOAD '/dualcore/ad_data[12]' USING PigStorage('\t') AS (
    campaign_id:chararray,
    date:chararray,
    time:chararray,
    keyword:chararray,
    display_site:chararray,
    placement:chararray,
    was_clicked:int,
    cpc:int
);

-- Group the data by display_site
grouped_data = GROUP data BY display_site;

-- Calculate total ads shown and total clicks for each site
site_metrics = FOREACH grouped_data {
    total_ads = COUNT(data);                   -- Total number of ads shown
    clicked_data = FILTER data BY was_clicked == 1;
    total_clicks = COUNT(clicked_data);        -- Total clicks on ads
    ctr_val = (total_clicks * 100.0) / total_ads;  -- Calculate CTR as a percentage
    GENERATE group AS display_site, total_ads, total_clicks, ctr_val AS ctr;  -- Project the results
};

-- Sort by CTR in ascending order
sorted_sites = ORDER site_metrics BY ctr ASC;

-- Display the first three records (lowest CTR)
top_low_ctr_sites = LIMIT sorted_sites 3;

DUMP top_low_ctr_sites;


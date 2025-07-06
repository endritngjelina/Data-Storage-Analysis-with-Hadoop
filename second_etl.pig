data = LOAD '/user/training/sample2.txt' USING PigStorage(',') AS (
    campaign_id:chararray,
    date:chararray,
    time:chararray,
    display_site:chararray,
    placement:chararray,
    was_clicked:chararray,
    cpc:int,
    keyword:chararray
);

unique_data = DISTINCT data;

reordered_data = FOREACH unique_data GENERATE
    campaign_id,
    REPLACE(date, '-', '/') AS date,
    time,
    UPPER(TRIM(keyword)) AS keyword,
    display_site,
    placement,
    was_clicked,
    cpc;


STORE reordered_data INTO '/dualcore/ad_data2' USING PigStorage('\t');

data = LOAD '/dualcore/ad_data1.txt' AS (keyword: chararray,campaign_id:chararray,date:chararray,time:chararray,display_site:chararray,was_clicked:int,cpc:int,country:chararray,placement:chararray);
usa_only = FILTER data BY NOT (country != 'USA');

elaborate_data = FOREACH usa_only GENERATE campaign_id,date,time,UPPER(TRIM(keyword)) AS keyword:chararray,display_site,placement,was_clicked,cpc;

STORE elaborate_data INTO '/dualcore/ad_data1';

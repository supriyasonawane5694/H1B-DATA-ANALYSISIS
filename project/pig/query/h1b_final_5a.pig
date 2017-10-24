--5) Find the most popular top 10 job positions for H1B visa applications for each year?
--a) for all the applications

register /usr/local/hive/lib/hive-exec-1.2.1.jar
register /usr/local/hive/lib/hive-common-1.2.1.jar

data1 = LOAD '/home/hduser/h1b_final/*' USING PigStorage('\t') as (s_no:long,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:chararray,worksite:chararray,longitude,latitude);


data2 = FOREACH data1 GENERATE job_title,year;

year11 = FILTER data2 BY year == '2011';
group1 = group year11 by (job_title,year);
Count1 = foreach group1 generate group, COUNT(year11.job_title);
Desc1 = limit (order Count1 by $1 desc) 10;


year12 = FILTER data2 BY year == '2012';
group2 = group year12 by (job_title,year);
Count2 = foreach group2 generate group, COUNT(year12.job_title);
Desc2 = limit (order Count2 by $1 desc) 10;

year13 = FILTER data2 BY year == '2013';
group3 = group year13 by (job_title,year);
Count3 = foreach group3 generate group, COUNT(year13.job_title);
Desc3 = limit (order Count3 by $1 desc) 10;

year14 = FILTER data2 BY year == '2014';
group4 = group year14 by (job_title,year);
Count4 = foreach group4 generate group, COUNT(year14.job_title);
Desc4 = limit (order Count4 by $1 desc) 10;


year15 = FILTER data2 BY year== '2015';
group5 = group year15 by (job_title,year);
Count5 = foreach group5 generate group, COUNT(year15.job_title);
Desc5 = limit (order Count5 by $1 desc) 10;

year16 = FILTER data2 BY year == '2016';
group6 = group year16 by (job_title,year);
Count6 = foreach group6 generate group, COUNT(year16.job_title);
Desc6 = limit (order Count6 by $1 desc) 10;

RESULT = UNION Desc1,Desc2,Desc3,Desc4,Desc5,Desc6;
STORE  RESULT INTO 'pig_out/prob5a1' USING PigStorage();



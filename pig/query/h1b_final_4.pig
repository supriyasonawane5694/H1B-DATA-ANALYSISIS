--4)Which top 5 employers file the most petitions each year? - Case Status - ALL
register /usr/local/hive/lib/hive-exec-1.2.1.jar
register /usr/local/hive/lib/hive-common-1.2.1.jar


data1 = LOAD '/home/hduser/h1b_final/*' USING PigStorage('\t') as (s_no:long,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:chararray,worksite:chararray,longitude,latitude);


data2 = FOREACH data1 GENERATE employer_name,year;

year1 = FILTER data2 BY year == '2011';
group1 = group year1 by (employer_name,year);
Count1 = foreach group1 generate group, COUNT(year1.employer_name);
Desc1 = limit (order Count1 by $1 desc) 5;

year2 = FILTER data2 BY year == '2012';
group2 = group year2 by (employer_name,year);
Count2 = foreach group2 generate group, COUNT(year2.employer_name);
Desc2 = limit (order Count2 by $1 desc) 5;

year3 = FILTER data2 BY year == '2013';
group3 = group year3 by (employer_name,year);
Count3 = foreach group3 generate group, COUNT(year3.employer_name);
Desc3 = limit (order Count3 by $1 desc) 5;

year4 = FILTER data2 BY year == '2014';
group4 = group year4 by (employer_name,year);
Count4 = foreach group4 generate group, COUNT(year4.employer_name);
Desc4 = limit (order Count4 by $1 desc) 5;

year5 = FILTER data2 BY year == '2015';
group5 = group year5 by (employer_name,year);
Count5 = foreach group5 generate group, COUNT(year5.employer_name);
Desc5 = limit (order Count5 by $1 desc) 5;

year6 = FILTER data2 BY year == '2016';
group6 = group year6 by (employer_name,year);
Count6 = foreach group6 generate group, COUNT(year6.employer_name);
Desc6 = limit (order Count6 by $1 desc) 5;

result = UNION Desc1, Desc2, Desc3, Desc4, Desc5, Desc6;

STORE result INTO 'pig_out/prob4' USING PigStorage();



register /usr/local/hive/lib/hive-exec-1.2.1.jar
register /usr/local/hive/lib/hive-common-1.2.1.jar
data1 = LOAD '/home/hduser/h1b_final/*' USING PigStorage('\t') as (s_no:long,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:chararray,worksite:chararray,longitude,latitude);

data2 = FOREACH data1 GENERATE case_status,job_title,year;

year1 = FILTER data2 BY year == '2011';
group1 = group year1 by (job_title);
Count1 = foreach group1 generate group, COUNT(year1.job_title);
--dump Count1;
year2 = FILTER data2 BY year == '2012';
group2 = group year2 by (job_title);
Count2 = foreach group2 generate group, COUNT(year2.job_title);

year3 = FILTER data2 BY year == '2013';
group3 = group year3 by (job_title);
Count3 = foreach group3 generate group, COUNT(year3.job_title);

year4 = FILTER data2 BY year == '2014';
group4 = group year4 by (job_title);
Count4 = foreach group4 generate group, COUNT (year4.job_title);

year5 = FILTER data2 BY year == '2015';
group5 = group year5 by (job_title);
Count5 = foreach group5 generate group, COUNT (year5.job_title);

year6 = FILTER data2 BY year == '2016';
group6 = group year6 by (job_title);
Count6 = foreach group6 generate group, COUNT (year6.job_title);

JOIN1 = join Count1 BY $0, Count2 BY $0, Count3 BY $0, Count4 BY $0, Count5 BY $0,Count6 BY $0;
data3 = foreach JOIN1 GENERATE $0,$1,$3,$5,$7,$9,$11;
average1 = FOREACH data3 GENERATE $0, (DOUBLE)((($2-$1)*100)/$1+(($3-$2)*100)/$2+(($4-$3)*100)/$3+(($5-$4)*100)/$4+(($6-$5)*100)/$5);
RESULT1 = FOREACH average1 GENERATE $0, (DOUBLE)($1/5);
AVERAGE_DESC_1= LIMIT (ORDER RESULT1 BY $1 DESC) 5;
STORE AVERAGE_DESC_1 INTO 'pig_out/prob_1b' USING PigStorage();


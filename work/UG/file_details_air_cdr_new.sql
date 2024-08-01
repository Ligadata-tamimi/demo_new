start transaction;
delete from  audit.files_details where file_date=yyyymmdd and feed_name=upper('AIR_CDR');
insert into  audit.files_details select distinct base_file_name,inst,nodeid,try_cast(seq as int) seq, try_cast(linecount as bigint ),fulldate,cast(dt as int),upper('AIR_CDR') from ( select distinct '' inst,file_name, split(reverse(element_at(split(reverse(file_name), '/'), 1)),'_')[3] nodeid, cast(split(reverse(element_at(split(reverse(file_name), '/'), 1)),'_')[4] as varchar) seq, cast(split(split(reverse(element_at(split(reverse(file_name), '/'), 1)),'_')[5],'-')[1] as varchar) dt, cast(split(reverse(element_at(split(reverse(file_name), '/'), 1)),'_')[2] as varchar) linecount, cast(split(split(reverse(element_at(split(reverse(file_name), '/'), 1)),'_')[5],'-')[1] as bigint) fulldate, reverse(element_at(split(reverse(file_name), '/'), 1)) base_file_name from devdata.air_cdr_cs18 where tbl_dt between ydate and vday_2 and file_name like '%yyyymmdd%');
commit;



start transaction;
delete from  audit.missing_sequance where file_date=yyyymmdd and feed_name=upper('AIR_CDR');
insert into  audit.missing_sequance
select  node1,instance1 ,sequence2 +1,sequence1-1,filedate,upper('AIR_CDR')
from (select a.num, b.num, a.sequence sequence1, b.sequence sequence2, (a.sequence - b.sequence) diff,a.node_id node1,b.node_id node2 ,a.instance instance1 ,b.instance instance2,a.file_date filedate from (
select rank() over (partition by node_id,instance order by SEQUENCE asc) num, sequence,file_name,node_id,instance,fulldate,file_date
from (
select distinct fulldate,file_date,
seq_num sequence,file_name,node_id,inistance_id instance
FROM   audit.files_details where feed_name=upper('AIR_CDR') and file_date>=ydate and file_date<=vday_2
order by SEQUENCE
)) a left outer join
(
select rank() over ( partition by node_id,instance order by SEQUENCE asc) num, sequence,file_name,node_id,instance,fulldate,file_date
from (
select distinct fulldate,file_date,
seq_num sequence,file_name,node_id,inistance_id instance
FROM   audit.files_details where feed_name= upper('AIR_CDR') and file_date>=ydate and  file_date<=vday_2
order by SEQUENCE
)) b on a.num =case when b.num=9999 then 0 else b.num+1 end
 and a.fulldate>=b.fulldate
and b.node_id=a.node_id and a.instance=b.instance
where b.sequence is not null order by a.num )  where diff >1;
commit;

select * from content_table
select * from user_table
select * from board_info_table

(select max(content_idx)+1 from content_table)

select max(content_idx) as content_idx from content_table

select * from user_table where user_id = 'abcd1'

select board_info_name from board_info_table where board_info_idx =1

--필드추가(게시판명)
select p2.*,(select board_info_name from board_info_table where board_info_idx =1) as board_info_name from
			(select content_idx as num, 
				p1.* from
				(select a1.content_idx, a1.content_subject, a1.content_date, a2.user_name from content_table a1, user_table a2
				where a1.content_writer_idx = a2.user_idx
				and a1.content_board_idx=1		    
				) p1
			) p2
			where p2.num >= 1 and p2.num <= 5

--Row_Number() Over (Order By a1.content_date Desc ) AS RowNum

--Step1.알맹이 추출
select
a1.content_idx, a1.content_subject, a1.content_date, a2.user_name 
from content_table a1, user_table a2
where a1.content_writer_idx = a2.user_idx
and a1.content_board_idx=2

--Step2.RowNum생성
select
Row_Number() Over (Order By a1.content_date asc ) AS RowNum,
a1.content_idx, a1.content_subject, a1.content_date, a2.user_name 
from content_table a1, user_table a2
where a1.content_writer_idx = a2.user_idx
and a1.content_board_idx=2

--Step3.where조건 추가(쿼리완성)
SELECT *  FROM 
( 
	select
	Row_Number() Over (Order By a1.content_date desc ) AS RowNum,
	a1.content_idx, a1.content_subject, convert(varchar(10),a1.content_date,120) as content_date, a2.user_name 
	from content_table a1, user_table a2
	where a1.content_writer_idx = a2.user_idx
	and a1.content_board_idx=1
) TB

where RowNum >= 1 and RowNum <= 5
order by RowNum desc


--일련번호 asc
SELECT *  FROM 
( 
	Select Row_Number() Over (Order By content_date Desc ) AS RowNum, 
	content_idx ,content_subject , content_text, content_writer_idx, content_board_idx, 
	convert(varchar(10),content_date,120) as content_date
	From content_table 
	Where content_board_idx = 1
) TB 

--일련번호 desc
SELECT *  FROM 
( 
	Select Row_Number() Over (Order By content_date asc ) AS RowNum, 
	content_idx ,content_subject , content_text, content_writer_idx, content_board_idx, 
	convert(varchar(10),content_date,120) as content_date
	From content_table 
	Where content_board_idx = 1
) TB
order by RowNum desc


select user_idx, user_name from user_table where user_id = 'abcd1' and user_pw ='dfdf'




use 
select a1.content_idx, a1.content_subject, a1.content_text, a1.content_file,
a1.content_writer_idx, a2.user_name, a1.content_date
from content_table a1, user_table a2
where a1.content_writer_idx = a2.user_idx
and a1.content_idx=1


select a1.content_idx, a1.content_subject, a1.content_text, a1.content_file,  a1.content_writer_idx, a2.user_name, a1.content_date  
from content_table a1, user_table a2  
where a1.content_writer_idx = a2.user_idx  and a1.content_idx=1


--insert into content_table (content_idx, content_subject, content_text, content_file,  content_writer_idx, content_board_idx, content_date)  values ((select max(content_idx)+1 from content_table) , '', '', '', '', '', getdate())

select * from content_table
select * from user_table
--delete from user_table where user_name = ''


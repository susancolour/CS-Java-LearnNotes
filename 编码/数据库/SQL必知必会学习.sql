###1.了解
-- 略



###2.检索
#select
# select * from student;
-- select sno,sname from student;
-- select * from student;

#插入
-- insert into student(sno,sname,ssex,sbirthday,class) values(110,"李时珍","男",'1533-06-24 00:00:00',95054);
-- insert into student(sno,sname,ssex,sbirthday,class) values(112,"李时珍","男",'1995-06-24 00:00:00',95023);
-- insert into student(sno,sname,ssex,sbirthday,class) values(118,"李时珍","男",'2005-12-09 00:00:00',95012);

#检索多个字段
# select distinct sname from student;
# select sname from student;
# select distinct sno,sname from student;

#结果限制
#limit关键字
-- Mysql之中没有Top关键字
# select TOP 5 sno,sname,ssex from student;
#Mysql之中可以用limit关键字来代替
-- select  sname,sno,ssex from student limit 5;

#注释
-- 从第3行其返回6个数据, offset表示从何处开始
#select * from student limit 6 offset 3;



###3.排序
#order by
#order by后面可以有多个字段，依次进行排序
#select * from student order by class,sno;

#order by支持按列排序
#select  sno,sname,ssex from student order by 3,1;

#order by是最后一个子句，desc的作用范围是其前面的一条，如果有多条，则需要每条后面都要说明course
/*select * from student order by sno desc,class;
select * from student order by sname desc,class asc;
select * from student order by sname desc,class desc;*/



###4.where子句过滤(行数据)
#select * from score where sno>103 order by sno desc,degree desc;
#select * from  student as s  where s.sbirthday>'1974-06-03'  and s.sbirthday <'1977-09-01 00:00:00'

#测试空值
#select * from student where sbirthday is Null;

#and
#select * from teacher where tsex='女' and depart ='计算机系';

#or
#select * from teacher where tsex='女' or depart ='助教';

#and 和or的组合，and优先级更高,导致有sno<107的数据进入
-- select * from score where sno>107 or degree>80 and cno='3-105';
#and 和or的组合，and优先级更高,用小括号消除歧义
-- select * from score where (sno>107 or degree>80) and cno='3-105';



###5.where子句高级使用
#in
#select * from  student where  sname in('李时珍','陆君','王丽') order by sbirthday desc;
/*select * from  student where  sname in(
    select sname from student where sname !='李时珍');#此处子查询只能有一条返回的数据
    */

#not
-- not 可以否定任何条件，相当于取反，其位于条件之前
-- select * from score where not degree>80; 



###6.通配符
#like
-- select * from student where  sname like '王%';
-- select * from student where  sname like '%王%';
# select * from student where  class like %95; #通配符之能对文本类型的字段使用，无法对非文本类型字段使用

#'_','%'
#select * from student where sname like '王_';
#select * from student where sname like '_王_';
#select * from student where sname like '[王李]%';#[]在mysql之中好像不起作用？



###7.拼接，计算
#拼接
-- mysql不支持这种，支持的是concat函数
-- select sname +'|'+ ssex +'|'+ from student;
-- select sname,ssex,concat( sname, '-' , ssex) as info from student;
#select concat( sname, '-' , ssex) as info from student;
#select GROUP_CONCAT(sname,ssex)from student;
#select concat(sname,'-', ssex) as info from student; #中间的-是一个连接符
#select *from student where sno>104;

#执行算数计算
#select sno, sname, ssex,class, sno+sno as 2sno from student  where  sno>109;
#select now();
#select trim('abc');



###8.使用函数
-- select upper(sname), ssex from student ;
-- select length(sname), ssex from student ;
-- select sname,sbirthday from student where Year(sbirthday)>1978;
-- select sin(sno) as sinsno from student where dayofmonth(sbirthday)=14;
-- select PI();
-- select curdate();
-- select now();
-- select dayofmonth(now());
-- select dayofmonth(sbirthday) from student;
-- select * from student as s where DayofMonth(s.sbirthday)>13;



###9.聚合函数sum avg count max min 返回一个值,对于Null值忽略，是不是不能用于where子句？
-- select concat(sum(degree),'---',avg(degree),'---',count(sno)) as allinof,sno from score;
-- select concat(sum(degree),'---',avg(degree),'---',count(sno)) as allinof,sno from score where degree>avg(degree);#invalid use group function
-- select sno, avg(degree) as avg_degree from  score where sno>101 order by sno desc ;

/*select sno, avg(distinct(degree)) as avg_degree from  score where sno>avg(sno);
select sno, avg(distinct(degree)) as avg_degree from  score where sno>(select avg(sno) from score);
*/



###10.分组
-- select sno,count(*) as nu from score group by sno order by sno desc;
-- having和where在语法上是相同的，但是作用上是不一样，而“类似的”，having过滤分组数据，where过滤行数据。
-- select ssex,count(*) as nu from student group by ssex having count(*)>3;
-- select ssex,count(*) as nu from student where sno>104 group by ssex having count(*)>3;#where group by having 可以同时使用
-- select sno,ssex,count(*) as nu from student where sno>104 group by ssex having count(*)>2 order by sno asc;#排序不能只依靠group by,还是要用order by
-- select tbname,count(tbname) as book,press from textbook where price>30 group by press having count(*)>2;
-- select  tbname,tbno,author,count(author) as a from textbook group by author having count(author)>1;
-- select  tbname,press,count(press) as a from textbook group by author having count(press)>1 order by a desc;



###11.子查询
#刘冰老师所教课程的出版社与书名
/*
select tno from teacher where tname='刘冰';
select cno from course where tno='831';
select press, tbname from textbook where cno ='5-238';
select press, tbname from textbook where cno in(
    select cno from course where tno in(
        select tno from teacher where tname='刘冰'));
*/

#所有老师所教课程的出版社与书名，输出press, tbname
/*select press, tbname from textbook where cno in(
    select cno from course where tno in(
        select tno from teacher));
*/

#所有老师所教课程的出版社与书名，输出tname，press, tbname
-- select tname,press,tbname from 
-- select cno from course where tno in(
-- select tno from teacher);

/*
select tname,tno,tbname,press
from teacher,textbook
where textbook.cno in
(select course.cno from course where course.tno=teacher.tno);*/

###12.联结
/*select cname,tbname,press,price,author 
from course,textbook
where course.cno=textbook.cno order by price desc;
*/

#笛卡尔积(结果是表一行数*表二行数)
/*select tname,tno,tbname,press
from teacher,textbook;*/
#等值联结
/*
select cname,tbname,press
from course,textbook
where course.cno=textbook.cno;
*/

#内联（就是等值联结）
#上面一句和这一句相等同
/*
select cname,tbname,press
from course inner join textbook
on course.cno=textbook.cno;*/

#多个表的内联
/*select tname,cname, tbname,press
from teacher,course,textbook
where teacher.tno=course.tno and course.cno=textbook.cno order by tname;
*/
-- select tbname as bookname,press as pressname,price as bookprice from textbook as tb,course as cs where  tb.cno=cs.cno;

###创建高级连接
#自连接
-- select * from course where  cname=(select cname from course where cname='计算机导论');
-- 等价于select * from course where cname='计算机导论';
-- #当cname处的=，子查询的返回结果大于1条的时候，会报错，下面的语句是错误的，下下面的是正确的
-- select * from course where  cname=(select cname from course where length(cname)>4);
-- select * from course where  cname in (select cname from course where length(cname)>4);
#使用自连接（自连接代替子查询，效率也很高）
-- select c1.cno,c1.cname,c1.tno from course as c1,course as c2 where c1.cno=c2.cno and c1.cname=c2.cname;

#自然连接（保持每个列只出现一次）
-- 自然联结要求你只能选择那些唯一的列，一般通过对一个表使用通配符（SELECT *）。
-- select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc,student as st where  sc.sno=st.sno;

#外连接（包含了在表中没有关联的行）
-- 关联时候，无where，一律换成on
-- inner join:select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc inner join student as st on  sc.sno=st.sno;
-- left outer join:select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc left outer join student as st on  sc.sno=st.sno;
-- right outer join:select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc right outer join student as st on  sc.sno=st.sno;
-- full outer join（MySQL无full outer join）：select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc full outer join student as st on  sc.sno=st.sno;

#使用聚合函数的连接
#聚合函数返回的结果是一个结果，所以其结果是一个数字，此时，如果所要展示的列之中，必须是条件之中所过滤后的列
-- select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc right outer join student as st on  sc.sno=st.sno group by sc.degree asc,sc.sno desc;
-- select sc.*,st.sno as stno, st.sname as stsname ,count(st.sno) as numbers, st.ssex as stssex from score as sc right outer join student as st on  sc.sno=st.sno group by sc.degree asc,sc.sno desc;
-- select  sc.sno as num, sc.degree as deg, sc.cno, count(sc.sno) as snonum from score as sc where deg>75;#列之中的别名不传递
-- select  sc.sno as num, sc.degree as deg, sc.cno, count(sc.cno) as snonum from score as sc where degree>75 group by sc.cno;



###组合查询
#UNION（多个where子句，就可转化成UNION的形式）
/*UNION中两个select语句所查之列，必须数据相同
select s.sno, s.sname, s.sex from student as s where sno>110
Union
select t.tbname, t.press, t.price  from textbook as t where price>36;
*/
#union all不去除重复，union默认去除重复
/*
select s.sno as sn from score as s where s.sno>60
union all
select st.sno as stn from student as st where st.sno>80
order by  sn; 
*/



###Insert
-- insert into  teacher values('326','张学友','M','1968-07-22 18:36:54','歌手','音乐学院');
-- insert into  teacher (tno,tname,tsex,tbirthday,prof,depart) values('325','Bie','M','1992-09-12 18:36:54','歌手','音乐学院');
-- insert into book values(110,'繁星春水','巴金','国家出版社',15.9);
-- insert into book(bid,bname,author,press,price) values(109,'京华春梦','梁羽生','成人出版社',92.8);
-- insert into book(bid,bname,price) values(111,'Cava编程思想',192.8);
#Insert Select检索插入语句(要保证两个表的结构相同)
#Insert Select(Error)
-- insert into teacher values(select t1.tno,t1.tname,t1.tsex,t1.tbirthday,t1.prof,t1.depart from  teacher as t1 where t1.tno='326' union select  *from  teacher as t2 where t2.tno='100');
#Insert Select(Okay)(可以用where过滤，更可以一次性插入多条语句)
-- insert  into book(bid,bname,author,press,price) select * from booktemp where bid<106;# insert select;

##Insert Select和Select  Into的区别
-- Insert select:导出数据
-- Select   into:导入数据(select * into custcopy from customer)
-- insert into book select * from booktemp where bid<106;
-- (mysql不支持)select  * into  booktemp from  book;
-- create table booktable1  as select * from booktemp;
-- create table booktable2  as select * from booktemp where price >60;
-- create table booktable3  as select * from booktemp group by press having count(*)>=2
-- create table booktable4  as select * from booktemp;#(为了删除数据库)
/*INSERT INTO `aboutstudent`.`booktable3` (`bid`, `bname`, `press`, `price`) VALUES ('102', '红楼春梦', 'XXX出版社', '399.5');
INSERT INTO `aboutstudent`.`booktable3` (`bid`, `bname`, `press`, `price`) VALUES ('103', '红楼轶梦', 'XXX出版社', '69.50');
INSERT INTO `aboutstudent`.`booktable3` (`bid`, `bname`, `press`, `price`) VALUES ('104', '红楼轶梦', 'XXX出版社', '69.50');*/



###Update and Delete
#update
-- 有where(某一行),无where(全表)
-- update booktable3 set bname='红楼春梦' where bid=102; 
-- update booktable3 set bname='红楼遗梦', press='国色天香出版社' where bid=103; 
-- update booktable3 set bname='红楼遗梦', press=null where bid=104;#相当于删除某列的值

#delete(删除的是表之中的数据)
-- 有where(某一行),无where(全表)
-- delete from booktable4 where bid=101;
-- delete from booktable4;



###create and manipulate database
#create(选择某种缩进，最好是四个空格，主键，注释，默认值，默认值好于null)
/*
#注意在定义语句里面和外面，有：有“=”和无“=”的区别#
create table if not exists parent(
    pid int auto_increment not null comment'ID',
    pfname varchar(25)  not null default 'XXX的爸爸' comment '学生爸爸名字',
    pmname varchar(25)  not null default 'XXX的妈妈' comment '学生妈妈名字',
    sno    varchar(3)   not null comment '学生学号',
    pftel  varchar(11)  not null comment '学生爸爸电话',
    pmtel  varchar(11)  not null comment '学生妈妈电话',
    primary key(pid)
 )default charset=utf8 AUTO_INCREMENT=100 comment='学生父母的信息';
-- 有主键，自增信息，以及自增开始处的定义方式
*/

#alter table(更新表的定义，主要是字段)
#alter table要和数据备份（包括模式与数据）联系起来，修改表的操作有一定的风险性
/*create table foralter as select * from booktemp; 准备工作*/
-- alter table foralter add presstime date default current_date();
-- alter table foralter add testinfo varchar(20) default "test";
-- alter table foralter drop testinfo;

#drop table(删除表)
-- drop table foralter;

#Rename(重命名表)
-- rename table foralter to foralter1;



###View视图
#view(主要目的是为了SQL的重用)
-- (error)create view v1;#创建view
-- create view bookview as select * from book where price >50;#不能丢了AS,后面要有检索填充的数据
-- drop view v1;
/*select p.pfname, p.pmname, s.sno,s.sname, sc.cno,sc.degree from parent as p,student as s,score as sc where p.sno=s.sno and s.sno=sc.sno;*/
-- 简化SQL，重用SQL
-- create view par_stu_scopar_stu_sco as select p.pfname, p.pmname, s.sno,s.sname, sc.cno,sc.degree from parent as p,student as s,score as sc where p.sno=s.sno and s.sno=sc.sno;
-- select * from bookview where bid>103;#view的查询
-- 格式化数据
-- create view bookcontactview as select concat(bid,'-',bname,'-',author,'-',press,'-',price) as bookinfo from book where price>40;
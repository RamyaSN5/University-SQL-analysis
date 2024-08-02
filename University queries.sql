
Display average salary given by each department.

select dept_name,sum(salary)/count(name) as average_sal
from instructor 
group by dept_name;  

2. Display the name of students and their corresponding course IDs.

select s.name,t.course_ID
from student s join takes t 
on 
s.ID = t.ID ;


3. Display number of courses taken by each student. 
select s.name,count(t.course_ID) as no_courses
from student s join takes t 
on s.ID = t.ID 
group by s.name
order by s.name;

4. Get the prerequisites courses for courses in the Spring semester. 

select t.semester, p.course_id, p.prereq_id
from takes t join prereq p 
on t.course_id=p.course_ID
where t.semester="Spring";  

5. Display the instructor name who teaches student with highest 5 credits. 

select s.name,i.name,s.tot_cred 
from student s join department d 
on s.dept_name=d.dept_name join instructor i 
on d.dept_name=i.dept_name 
order by s.tot_cred desc
limit 5;

select * from classroom;
select * from department;
select * from course;
select * from instructor;
select * from time_slot;
select * from section;
select * from teaches;
select * from student;
select * from takes;
select * from advisor;
select * from prereq;
6. Which semester and department offers maximum number of courses.

select t.semester,c.dept_name,count(t.course_id) as max_course
from takes t join course c 
on t.course_id=c.course_id 
group by t.semester,c.dept_name
order by max_course desc 
limit 1;

7. Display course and department whose time starts at 8. 

select distinct section.course_id,time_slot.start_hr
from section join time_slot on section.time_slot_id=section.time_slot_id
where time_slot.start_hr=8; 


select distinct section.course_id,course.dept_name,time_slot.start_hr
from section join course on section.course_ID=course.course_id
join time_slot on section.time_slot_id=section.time_slot_id
where time_slot.start_hr=8;

8. Display the salary of instructors from Watson building. 

select i.name,i.salary,d.dept_name from instructor i join department d 
on i.dept_name=d.dept_name 
where d.building="Watson";


9. Show the title of courses available on Monday.

select distinct c.title from course c join section s
on c.course_id=s.course_id join time_slot t on 
s.time_slot_id=t.time_slot_id
where t.day="M"
order by c.title;

----- cte 

with monday (TIME_SLOT_ID) AS (select time_slot_id where day="M")
SELECT 

10. Find the number of courses that start at 8 and end at 8. 

select distinct t.start_hr,t.end_hr,count(c.course_id) as num_courses 
from course c join section s
on c.course_id=s.course_id join time_slot t on 
s.time_slot_id=t.time_slot_id
where t.start_hr=8 and t.end_hr=8;




11. Find instructors having salary more than 90000. 

select name,salary from instructor 
where salary>90000;

12. Find student records taking courses before 2018. 

select * from takes
where year<2018; 

13. Find student records taking courses in the fall semester and coming under first section.

select * from takes
 where semester="Fall" and sec_id=1;

14. Find student records taking courses in the fall semester and coming under second section. 

select * from takes
 where semester="Fall" and sec_id=2;
 
15. Find student records taking courses in the summer semester, coming under first section in the year 2017.

select * from takes
 where semester="Summer" and 
 sec_id=1 and year=2017;
 
 
16. Find student records taking courses in the fall semester and having A grade. 

select * from takes
 where semester="Fall" and grade="A";
 
17. Find student records taking courses in the summer semester and having A grade. 

select * from takes
 where semester="Summer" and grade="A";

18. Display section details with B time slot, room number 514 and in the Painter building. 

select * from section 
where time_slot_id="B" and room_number=514
 and building="Painter";


19. Find all course titles which have a string "Intro.".  

select title from course 
where title regexp "Intro";

20. Find the titles of courses in the Computer Science department that have 3 credits.  

select title from course 
where dept_name="Comp. Sci." and credits=3;

21. Find IDs and titles of all the courses which were taught by an instructor named Einstein. 
Make sure there are no duplicates in the result.  

with courses(course_id) as 
(select t.course_id 
from teaches t join instructor i 
on t.id=i.id
where i.name="Einstein") 
select c.course_id,c.title 
from course c where c.course_id in(select course_id from courses); 


22. Find all course IDs which start with CS 

select course_id from course
 where course_id regexp "^CS";

23. For each department, find the maximum salary of instructors in that department. 

select dept_name,max(salary) as salarii 
from instructor 
group by dept_name;

24. Find the enrollment (number of students) of each section that was offered in Fall 2017. 

select sec_id,count(ID) as number_od_stud,semester,year
 from section  where semester="Fall" and year=2017
 group by sec_id; 
 
 select * from section;
25. Increase(update) the salary of each instructor by 10% if their current salary is between 0 and 90000. 

UPDATE instructor
SET salary = salary + salary * 0.10
WHERE salary > 0 AND salary < 90000; 


26. Find the names of instructors from Biology department having salary more than 50000.  

select name from instructor 
where salary>50000 and dept_name="Biology";

27. Find the IDs and titles of all courses taken by a student named Shankar  

select c.course_id,c.title from course c join student s
on c.dept_name=s.dept_name  
where s.name="Shankar";

28. For each department, find the total credit hours of courses in that department. 
select * from course;
select dept_name,sum(credits) as credits
from course
group by dept_name;
29. Find the number of courses having A grade in each building. 

select s.building,count(s.course_id) number_of_courses,t.grade 
from section s join takes t 
on s.course_id=t.course_id 
where t.grade="A"
group by s.building;

30. Display number of students in each department having total credits divisible by course credits. 

select ss.dept_name,count(ss.ID) as num_of_students from 
course c join section s on c.course_id=s.course_id join 
takes t on s.course_id=t.course_id join student ss 
on t.ID=ss.ID 
where ss.tot_cred % c.credits=0
group by ss.dept_name
;


31. Display number of courses available in each building. 

select d.building,count(c.course_id) as num_of_courses 
from course c join department d 
on d.dept_name=c.dept_name
group by d.building; 

32. Find number of instructors in each department having 'a' and 'e' in their name. 

select dept_name,count(distinct name) from instructor 
where name regexp "a|e"
group by dept_name; 

33. Display number of courses being taught in classroom having capacity more than 20. 

with morethan(building) as 
(select building from classroom 
where capacity>20) 
select count(s.course_id) as number_of_co 
from section s where s.building in 
(select building from morethan);

select c.room_number,c.capacity,count(s.course_id) as nou
from section s join classroom c 
on s.building=c.building 
where c.capacity>20
group by c.room_number
order by room_number;

34. Update the budget of each department by Rs. 1000 

update department 
set budget= budget +1000;  
select * from department; 

select *,budget+1000 as new_budget 
from department;

35. Find number of students in each room. 

select s.room_number, count(t.ID) as num_stu
from section s join takes t 
on s.course_id=t.course_id
group by s.room_number;

36. Give the prerequisite course for each student.


select s.name,p.prereq_id from
prereq p join takes t 
on p.course_id=t.course_id 
join student s on t.ID=s.ID 
group by s.name; 

SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));


37. Display number of students attending classes on Wednesday. 

with wednesday(day,course_id) as 
(select t.day,s.course_id
from time_slot t join section s
on t.id=s.id) 
select count(takes.ID) from 
takes join wednesday w 
on takes.course_id=w.course_id
where w.day="W";  

WITH wednesday_classes AS (
    SELECT t.day, s.course_id
    FROM time_slot t
    JOIN section s ON t.id = s.id
    WHERE t.day = 'W'
)
SELECT COUNT(takes.ID) AS number_of_students
FROM takes
JOIN wednesday_classes w ON takes.course_id = w.course_id; 


select t.day,count(sa.name) from 
time_slot t join section s
on t.id=s.id join takes ta
on s.course_id=ta.course_id join student sa
on ta.ID=sa.ID
where t.day="W"; 

38. Display number of students and instructors in each department

SELECT i.dept_name,count(distinct s.name),count(distinct i.name) as num
FROM student s
JOIN instructor i ON s.dept_name = i.dept_name 
group by i.dept_name;

39. Display number of students in each semester and their sum of credits.

select t.semester,count(t.ID) as num_of_stu, sum(s.tot_cred) as total
from takes t join student s
on t.ID=s.ID
group by t.semester;

40. Give number of instructors in each building. 

select d.building,count(i.ID) 
from department d join instructor i
on d.dept_name=i.dept_name
group by d.building;

select * from advisor; 
select * from instructor;
41. Display advisor IDs for instructors in Painter building. 

select a.s_ID,i.name,d.building
from instructor i join advisor a 
on a.i_id=i.ID join department d on i.dept_name=d.dept_name 
where d.building="Painter"; 

select a.s_ID,i.name,d.building
from instructor i join department d on i.dept_name=d.dept_name 
join advisor a 
on a.i_id=i.ID  
where d.building="Painter"; 

42. Find total credits earned by students coming at 9am 

select s.name,s.tot_cred,ti.start_hr
from student s join takes t 
on s.ID=t.ID join section se
on t.course_id=se.course_id 
join time_slot ti on se.id=ti.id 
where ti.start_hr=9; 

43. Display student names ordered by room number 

select s.name,se.room_number
from student s join takes t 
on s.ID=t.ID join section se
on t.course_id=se.course_id 
order by se.room_number; 

select * from classroom;
44. Find the number of capacity left after occupying all the students. 

select c.room_number, c.capacity-count(t.ID) as left_cap
from classroom c join section s 
on c.room_number=s.room_number join takes t 
on s.course_id=t.course_id
group by c.room_number; 

45. Find the duration for which each student has to attend each lecture. 
SELECT s.name,takes.course_id,
((t.end_hr * 60 + t.end_min) - (t.start_hr * 60 + t.start_min)) AS total_duration_minutes,
    FLOOR(((t.end_hr * 60 + t.end_min) - (t.start_hr * 60 + t.start_min)) / 60) AS duration_hours,
    ((t.end_hr * 60 + t.end_min) - (t.start_hr * 60 + t.start_min)) % 60 AS duration_minutes
FROM time_slot t join section se on t.id=se.id join takes on takes.course_id=se.course_id 
join student s on s.ID=takes.ID
group by s.name,takes.course_id; 



46. Create a timetable for the university. 

select t.day,s.building,s.room_number,s.course_id 
from time_slot t join section s 
on t.id=s.id order by t.day;

47. Find the average salary thats distributed to teachers for each course and sort them in descending order 

select t.course_id,c.title, avg(i.salary) as average
from instructor i join teaches t 
on i.ID=t.ID join course c 
on t.course_id=c.course_id
group by t.course_id
order by average desc; 

48. Find the average duration of classes for each course id 

SELECT s.course_id,AVG((t.end_hr * 60 + t.end_min) - (t.start_hr * 60 + t.start_min)) AS average_duration_minutes
FROM time_slot t join section s 
on t.id=s.id
GROUP BY s.course_id;
49 Get the name of the instructor with highest salary from each department. 

select name,max(salary),dept_name 
from instructor
group by dept_name; 

SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

50. Get the sum of the total credits of students that is dealt by the instructors along with their names 

select i.name, sum(tot_cred) as totals 
from instructor i join student s 
on i.dept_name=s.dept_name 
group by i.name ;
51. Perform division between student credits and department total credits 

select s.name,(s.tot_cred)/sum(c.credits) as cred 
from student s join course c 
on s.dept_name=c.dept_name
group by s.name
order by cred desc;

52. If the department budget was to be distributed among the buildings, how much amount can be allocated to each room in a building

select d.building, (d.budget)/(count(c.room_number) )
from department d join classroom c
on d.building=c.building 
group by d.building;

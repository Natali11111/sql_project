create database `tracking_for_mentor`;
use tracking_for_mentor;
SHOW TABLES;

drop database tracking_for_mentor;

create table `teachers`(
id int not null auto_increment,
full_name varchar(500) ,
age int,
phone varchar(30),
education varchar(500),
primary key(id)
);

create table `students`(
id int not null auto_increment,
full_name varchar(500) ,
age int,
phone varchar(30),
primary key(id)
);

create table `subjects`(
id int not null auto_increment,
title varchar(500),
parent_id int,
primary key(id),
constraint foreign key(parent_id) references subjects(id)
);

create table `lessons`(
id int not null auto_increment,
timetable timestamp,
teacher_id int not null,
student_id int not null,
subject_id int not null,
duration int,
note text,
number_lesson int,
primary key(id),
foreign key(teacher_id) references teachers(id),
foreign key(student_id) references students(id),
foreign key(subject_id) references subjects(id)
);


create table `tasks`(
id int not null auto_increment,
lesson_id int not null,
description_task text,
complexity enum('easy', 'medium', 'hard'),
completed_task text,
rating int,
primary key(id),
foreign key(lesson_id) references lessons(id)
);

create table `paid_for_lessons`(
id int not null auto_increment,
is_paid boolean,
price double,
paid_date timestamp,
primary key(id)
);

create table `lessons_paid_for_lessons`(
id int not null auto_increment,
paid_for_lesson_id int not null,
lesson_id int not null,
primary key(id),
foreign key(lesson_id) references lessons(id),
foreign key(paid_for_lesson_id) references paid_for_lessons(id)
);

insert into lessons_paid_for_lessons(paid_for_lesson_id, lesson_id )
value((select id from paid_for_lessons where id = 5), (select id from lessons where id = 5));

insert into teachers (full_name, age, phone, education)
#values('Anton Danilov', 25, '0992345678', 'NPU'), ('Maria Protasova', 33, '0879876756', 'KPI');
#values('Irina Ivanova', 40, '0996789009', 'MAUP'), ('Ivan Petrov', 50, '0991234567', 'KNU'), ('Boris Gubin', 34, '0678900978', 'KPI');
values('Oksana Morgun', 33, '06089900989', 'NPU'), ('Vladimer Pupkin', 55, '0448765456', 'MAUP');

insert into students(full_name, age, phone)
values('Katy Serova', 20, '0998765678'), ('Nataliia Kirkorova', 13, '0998727890'), ('Valeria Piragova', 21, '0997899890'), ('Karina Ivanova', 15, '0998900098'),
('Margo Tutikova', 24, '0678900978'), ('Marsel Onim', 25, '0996547898'), ('Mark Makarov', 10, '0663456789'), ('Angela Papina', 17, '0507899856'), ('Tonya Donya', 15, '0506788796');

select*from teachers;
select * from students;
select * from subjects;
select * from lessons;
select * from tasks;
select * from paid_for_lessons;
select * from lessons_paid_for_lessons;

insert into subjects(title)
value('History');

insert into subjects(parent_id, title)
values(1, 'The World History'), (1, 'History of Ukraine'), (1, 'Microhistory');

insert into subjects(title)
value('Maths');

insert into subjects(parent_id, title)
values(5, 'Discrete Math'), (5, 'Boolean Algebra'), (5, 'Analytic Geometry');

insert into subjects(title)
value('Languages');

insert into subjects(parent_id, title)
values (9, 'English'), (9, 'German'), (9, 'Ukraine'), (9, 'Polish');


insert into lessons(teacher_id, subject_id, student_id, timetable, duration, number_lesson)
values ((select id from teachers where full_name = 'Irina Ivanova'), (select id from subjects where title = 'The World History'), (select id from students where full_name = 'Katy Serova'), '2020-05-15 14:00:00', 2, 1 );

insert into lessons(teacher_id, subject_id, student_id, timetable, duration, number_lesson)
values ((select id from teachers where full_name = 'Ivan Petrov'),(select id from subjects where title = 'Discrete Math') , (select id from students where full_name = 'Katy Serova'), '2020-10-11 10:30:00', 1, 2);

insert into lessons(teacher_id, subject_id, student_id, timetable, duration, number_lesson)
values ((select id from teachers where full_name = 'Boris Gubin'), (select id from subjects where title = 'English'), (select id from students where full_name = 'Nataliia Kirkorova'), '2021-11-11 09:00:00', 1, 3);

insert into lessons(teacher_id, subject_id, student_id, timetable, duration, number_lesson)
values ((select id from teachers where full_name = 'Irina Ivanova'), (select id from subjects where title = 'Microhistory'), (select id from students where full_name = 'Valeria Piragova'), '2021-09-22 10:00:00', 2, 5);

insert into lessons(teacher_id, subject_id, student_id, timetable, duration, number_lesson)
values ((select id from teachers where full_name = 'Irina Ivanova'), (select id from subjects where title = 'Microhistory'), (select id from students where full_name = 'Nataliia Kirkorova'), '2021-06-16 11:00:00', 3, 4);

insert into lessons(teacher_id, subject_id, student_id, timetable, duration, number_lesson)
values ((select id from teachers where full_name = 'Anton Danilov'), (select id from subjects where title = 'German'), (select id from students where full_name = 'Karina Ivanova'), '2021-08-04 16:00:00', 1, 1);

insert into lessons(teacher_id, subject_id, student_id, timetable, duration, number_lesson)
values ((select id from teachers where full_name = 'Anton Danilov'), (select id from subjects where title = 'German'), (select id from students where full_name = 'Karina Ivanova'), '2021-08-15 16:15:00', 1, 2);

insert into tasks(lesson_id, description_task, complexity)
value((select id from lessons where id = 1), 'Read paragraphs 5, 6, 7', 'easy');

insert into tasks(lesson_id, description_task, complexity, rating)
value((select id from lessons where id = 2), 'Solve tasks 12, 14, 15 from pages 50', 'medium', 3);

insert into tasks(lesson_id, description_task, complexity, rating)
value((select id from lessons where id = 3), 'Translate text from page 77', 'medium', 5);

insert into tasks(lesson_id, description_task, complexity)
value((select id from lessons where id = 5), 'Read paragraphs 10, 12, 14', 'easy');

insert into tasks(lesson_id, description_task, complexity, rating)
value((select id from lessons where id = 6), 'Translate text from page 100', 'medium', 4);


insert into paid_for_lessons(is_paid, price, paid_date)
#values(true, 400, '2020-07-12'), (true, 500, '2021-10-01'), (true, 350, '2021-05-15'), (true, 600, '2021-04-13'), (true, 600, '2021-07-20');
value(true, 450, '2021-04-22');

select * from teachers t
left join lessons l on t.id = l.teacher_id;

select * from tasks t
right join lessons l on t.lesson_id = l.id;

select * from students s
left join lessons l on s.id = l.student_id;

select s1.title as subcategory, s2.title as category from subjects s1
join subjects s2 ON s2.id = s1.parent_id;

select s.full_name as student_name, t.full_name as teacher_name, sub.title, l.timetable, l.duration, l.number_lesson from lessons l
join students s on l.student_id = s.id
join teachers t on l.teacher_id = t.id
join subjects sub on l.subject_id = sub.id;

select * from lessons_paid_for_lessons lp
join paid_for_lessons pfl on lp.paid_for_lesson_id = pfl.id
join lessons l on lp.lesson_id = l.id
join teachers t on l.teacher_id = t.id
join students s on l.student_id = s.id
join subjects sub on l.subject_id = sub.id;


create view  `lessons_students_teachers` as
select s.full_name as student_name, t.full_name as teacher_name, sub.title, l.timetable, l.duration, l.number_lesson from lessons l
join students s on l.student_id = s.id
join teachers t on l.teacher_id = t.id
join subjects sub on l.subject_id = sub.id;

select * from lessons_students_teachers
order by duration desc;


 delimiter $$
 create procedure input_in_student( f varchar(50), a int, p varchar(18) )
 begin
 insert into students(full_name, age, phone)value(f, a, p);
 end $$

call input_in_student('Peter Kulagin', 18, '0678900767');

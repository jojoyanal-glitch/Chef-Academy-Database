create database chefAcademy;
use chefAcademy;

create table Instructor (
  instructorid int ,
  firstName varchar (50) ,
  lastName varchar (50) ,
  specialty varchar (100) ,
  email varchar (100) unique ,
  primary key (instructorid)
);

create table Student (
  studentid int ,
  email varchar (100) ,
  firstName varchar (50) ,
  lastName varchar (50) ,
  primary key (studentid)
);

create table StudentPhone (
  studentid int,
  phone varchar(20),
  primary key (studentid, phone),
  foreign key (studentid) references Student(studentid)
);

create table Course (
  courseid int,
  titleOfCourse varchar (150),
  level varchar (50),
  instructorid int,
  primary key (courseid),
  foreign key (instructorid) references Instructor(instructorid)
);

create table Recipe (
  recipeid int,
  title varchar (150),
  steps text,
  courseid int,
  primary key (recipeid),
  foreign key (courseid) references Course(courseid)
);

create table Enrollment (
  enrollmentid int,
  enrollDate date,
  recipeid int,
  studentid int,
  primary key (enrollmentid),
  foreign key (recipeid) references Recipe(recipeid),
  foreign key (studentid) references Student(studentid)
);

create table RecipeSubmission (
  photoUrl varchar (255),
  submDate date,
  recipeid int,
  studentid int,
  foreign key (recipeid) references Recipe(recipeid),
  foreign key (studentid) references Student(studentid)
);

insert into Instructor values (1, 'Jana', 'Yanal', 'Fine Dining', 'JanaYanal@chef.com');
insert into Instructor values (2, 'Rama', 'Mahmoud',' Home Cooking', 'RamaMahmoud@chef.com');
insert into Instructor values (3, 'Hanady', 'Abdullah',' Home Cooking', 'HanadyAbdullah@chef.com');

insert into Student values (101, 'JudeJazzazi@gmail.com', 'Jude', 'Jazzazi');
insert into Student values (102, 'BasharMohammad@gmail.com', 'Bashar', 'Mohammad');
insert into Student values (103, 'YanalNaje@gmail.com', 'Yanal', 'Naje');

insert into StudentPhone values (101 , '0791234567');
insert into StudentPhone values (101 , '0789876543');
insert into StudentPhone values (102 , '0779838583');
insert into StudentPhone values (103 , '0789834543');

insert into Course values (10, 'French Gourmet Secrets', 'Advanced', 1);
insert into Course values (20, 'Middle Eastern Classics', 'Beginner', 2);
insert into Course values (30, 'Quick & Healthy Meals', 'Intermediate', 3);

insert into Recipe values (1, 'Beef Wellington', '1. Sear beef. 2. Wrap in pastry. 3. Bake until golden.', 10);
insert into Recipe values (2, 'Traditional Mansaf', '1. Cook lamb in jameed. 2. Prepare rice. 3. Serve on shrak.', 20);
insert into Recipe values (3, 'Quinoa Salad', '1. Boil quinoa. 2. Chop vegetables. 3. Mix with lemon dressing.', 30);

insert into Enrollment values (501, '2026-01-01', 2, 101);
insert into Enrollment values (502, '2026-01-02', 1, 102);
insert into Enrollment values (503, '2026-01-03', 3, 103);

insert into RecipeSubmission values ('http://chefacademy.com/uploads/jude_mansaf.jpg', '2026-01-05', 2, 101);
insert into RecipeSubmission values ('http://chefacademy.com/uploads/bashar_beef.jpg', '2026-01-07', 1, 102);

select 
    Student.firstName, 
    Student.lastName, 
    Course.titleOfCourse 
from Enrollment
join Student on Enrollment.studentid = Student.studentid
join Recipe on Enrollment.recipeid = Recipe.recipeid
join Course on Recipe.courseid = Course.courseid;

select 
    Instructor.specialty, 
    count(Enrollment.studentid) as TotalStudents
from Enrollment
join Recipe on Enrollment.recipeid = Recipe.recipeid
join Course on Recipe.courseid = Course.courseid
join Instructor on Course.instructorid = Instructor.instructorid
group by Instructor.specialty;

select 
    Student.firstName, 
    Student.lastName
from Enrollment
left join RecipeSubmission on Enrollment.recipeid = RecipeSubmission.recipeid 
    and Enrollment.studentid = RecipeSubmission.studentid
join Student on Enrollment.studentid = Student.studentid
where RecipeSubmission.photoUrl is null;

select titleOfCourse, level 
from Course 
where level = 'Beginner';

select 
    Instructor.firstName, 
    count(Course.courseid) as CourseCount
from Instructor
join Course on Instructor.instructorid = Course.instructorid
group by Instructor.instructorid
having CourseCount >= 1;


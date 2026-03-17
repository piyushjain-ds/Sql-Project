create database library_db;

use library_db;

create table authors(
					author_id int  Primary Key  Auto_Increment,
					author_name	VARCHAR(100) NOT NULL,
					country	VARCHAR(50)
);

select *from authors;

create table books(
					book_id	INT	Primary Key  Auto_Increment,
                    title VARCHAR(150)	NOT NULL,
					author_id	INT	,
                    Foreign Key (author_id) references authors (author_id )  ,
					category VARCHAR(50)	,
					published_year	YEAR,	
					available_copies INT Default 0
);

select *from books ;


create table members(
					member_id INT Primary Key Auto_Increment,
					member_name	VARCHAR(100),
					email	VARCHAR(100) UNIQUE,
					join_date	DATE
);

select *from members ;

create table borrow_records (
							borrow_id	INT primary key  Auto_Increment,
							member_id	INT ,
							Foreign Key (member_id) references authors (author_id ),
							book_id	INT ,
                            Foreign Key (book_id) references books (book_id ),
							borrow_date	DATE,
							return_date	DATE NULL
);

select *from borrow_records ;

insert into authors(author_id ,author_name	,country) 
value(1	,'J.K. Rowling'	,'UK'),
(2	,'George Orwell'	,'UK'),
(3	,'Mark Twain','USA'),
(4	,'Jane Austen'	,'UK'),
(5	,'Paulo Coelho','Brazil');

select *from authors;

insert into  books(book_id	,title	,author_id	,category	,published_year	,available_copies)-- Why publishged year has limited

value
(1 , 'Harry Potter 1'	,1,	'Fantasy',1997,	5),
(2	, 'Harry Potter 2'	,1,	'Fantasy',1998,4),
(3	,'1984 ',2	,'Dystopian'	,1949	,6),
(4	,'Animal Farm',	2	,'Political Satire'	,1945	,3),
(5	,'Adventures of Tom Sawyer'	,3,	'Fiction', 1976,2),
(6,	'Pride and Prejudice',4	,'Romance',	1913,4),
(7	,'Emma'	,4	,'Romance',1915	,2),
(8,	'The Alchemist'	,5	,'Fiction'	,1988	,5),
(9	,'Brida'	,5	,'Fiction'	,1990	,3),
(10	,'Homage to Catalonia ' ,2	,'History'	,1938,2);

insert into members(member_id,member_name,email	,join_date)
value 
(1	,'Ali Khan'	,'ali@email.com',2024-01-10),
(2	,'Sara Ahmed','sara@email.com',2024-02-15),
(3	,'John Smith','john@email.com',2024-03-01),
(4	,'Maria Garcia','maria@email.com',2024-03-20),
(5	,'David Lee',	'david@email.com',2024-04-05);
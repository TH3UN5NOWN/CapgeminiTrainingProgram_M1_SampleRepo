create table Departments(
	Id int primary key identity,
	Name nvarchar(50) not null
)

create table Employees(
	Id int primary key identity,
	Name nvarchar(50) not null,
	DateofJoining date not null,
	Salary money not null, --/// check condition below ///
	Email nvarchar(50) not null,
	Gender int not null, --/// because using enum type in console app (either int or string) ///
	Hobbies nvarchar(50) not null,
	DepartmentId int not null foreign key references Departments(Id),
	IsActive bit not null default 1,

	check(Salary > 0)
)

create table UserInfo(
	Id int primary key identity,
	Name nvarchar(50) not null,
	Password nvarchar(30) not null,
	Role int not null

)
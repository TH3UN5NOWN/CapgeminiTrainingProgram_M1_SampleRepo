alter proc usp_RegisterUser @name nvarchar(50), @password nvarchar(30), @role int
as
begin
	if(LEN(@name) =0)
		throw 500003, 'Name cannot be Empty',1
	if(LEN(@password) < 6 )
		throw 500004, 'password must be 6 char atleast', 1

insert into UserInfo ( Name, Password, Role) 
values (@name, @password, @role)
end
go

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
create proc usp_Login @name nvarchar(50), @password nvarchar(30)
as
begin
	select Role from UserInfo where Name = @name and Password = @password
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
create proc usp_AddDepartment @name nvarchar(50)
as
begin
	if(exists(select Name from Departments where Name = @name) and LEN(@name)=0)
		throw 500005,'Name already exist or no name entered',1

insert into Departments (Name) values (@name)

end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
create proc usp_DepartmentList
as
begin
	select*from Departments
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
create proc usp_AddEmployee @name nvarchar(50),
							@email nvarchar(50),
							@salary money,
							@dateofjoining date,
							@gender int,
							@hobbies nvarchar(50),
							@depatmentId int 
as
begin
	--validate
	if(LEN(@name) = 0)
		throw 500010, 'Name cannot be Empty',1
	if(@salary <0)
		throw 500011, 'Salaray cannot be < 0',1
	if(LEN(@email) = 0)
		throw 500012, 'Email cannot be Empty',1
	if(LEN(@hobbies) = 0)
		throw 500013, 'Hobbies cannot be Empty',1

	if(exists(select Email from Employees where Email = @email))
		throw 500020, 'Employee already exist',1

	if(not exists(select Id from Departments where Id = @depatmentId))
		throw 500030, 'Department ID not Valid',1

insert into Employees (Name, DateofJoining, Salary, Email, Gender, Hobbies, DepartmentId)
values (@name,@dateofjoining,@salary,@email,@gender,@hobbies,@depatmentId)
end


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
create proc usp_EmployeeList
as
begin
	select*from Employees
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select * from UserInfo
select* from Departments
select * from Employees
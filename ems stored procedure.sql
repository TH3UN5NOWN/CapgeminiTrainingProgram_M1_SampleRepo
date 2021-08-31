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

select * from UserInfo
select* from Departments
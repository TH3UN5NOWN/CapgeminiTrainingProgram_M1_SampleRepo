using EMS_DataAcessLayer;
using EMS_Entities;
using EMS_Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace EMS_BusinessLayer
{
    public class EmsBL
    {
        public static bool Register(UserInfo user)
        {
            bool isRegistered = EmsDAL.Register(user);
            return isRegistered;
        }

        public static (bool isSuccess, Role role) Login(string name, string password)
        {
            var result = EmsDAL.Login(name, password);
            return result;
        }

        public static bool AddDepartment(Department department)
        {
            bool isAdded = EmsDAL.AddDepartment(department);
            return isAdded;
        }

        public static List<Department> DepartmentList()
        {
            return EmsDAL.DepartmentList();
        }

        public static List<Employee> EmployeeList()
        {
            return EmsDAL.EmployeeList();
        }

        public static bool AddEmployee(Employee employee)
        {
            //validation
            ValidateEmployee(employee);
            //dal
            return EmsDAL.AddEmployee(employee);
        }

        private static void ValidateEmployee(Employee employee)
        {
            string errors = "";
            if (string.IsNullOrEmpty(employee.Name))
            {
                errors = "Name Cannot be Empty\n";
            }
            if (employee.Salary<0)
            {
                errors += "Salary cannot be negative\n"; 
            }
            if (!Regex.IsMatch(employee.Email, @"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"))
            {
                errors += "Email not Valid\n";
            }
            if (string.IsNullOrEmpty(employee.Hobbies))
            {
                errors = "Hobbies Cannot be Empty\n";
            }

            if (errors.Count() >0)
            {
                throw new EmsException(" Validation Failed \n"+errors);
            }
        }
    }
}

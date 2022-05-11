using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADO.NET
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Welcome");

            EmployeeRepo repo = new EmployeeRepo();
            try
            {
                Console.WriteLine("Choose option or press 0 for exit\n1:Retrieve Data\n2:Add Data\n");
                int option = Convert.ToInt32(Console.ReadLine());
                switch (option)
                {
                    case 0:
                        Environment.Exit(0);
                        break;
                    case 1:
                        repo.GetAllEmployees();
                        break;
                    case 2:
                        EmployeeModel model = new EmployeeModel
                        {
                            Name = "Saurabh",
                            Startdate = DateTime.Now,
                            Gender = 'M',
                            Phone = 9876453215,
                            Department = "Testing",
                            Address = "Katni",
                            Basic_Pay = 30000.00,
                            Deductions = 1000.00,
                            Taxable_Pay = 29000.00,
                            Income_Tax = 1000.00,
                            Net_Pay = 28000,
                        };
                        repo.AddEmployee(model);
                        break;
                }
                Console.ReadLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}

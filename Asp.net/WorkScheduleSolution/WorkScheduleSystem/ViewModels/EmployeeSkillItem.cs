using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WorkScheduleSystem.ViewModels
{
    public class EmployeeSkillItem
    {
        public int EmployeeSkillID { get; set; }
        public int EmployeeID { get; set; }
        public string EmployeeFullName { get; set; }
        public int SkillID { get; set; }
        public string SkillName { get; set; }
        public int Level { get; set; }
        public int? YearsOfExperience { get; set; }
        public decimal HourlyWage { get; set; }
    }
}

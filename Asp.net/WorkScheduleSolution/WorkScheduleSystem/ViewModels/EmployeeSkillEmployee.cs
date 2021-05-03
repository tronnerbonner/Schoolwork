using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WorkScheduleSystem.ViewModels
{
    public class EmployeeSkillEmployee
    {
        public int EmployeeID { get; set; }

        public string FullName { get; set; }

        public string Phone { get; set; }

        public bool Active { get; set; }

        public int SkillID { get; set;  }

        public int SkillLevel { get; set; }

        public string SkillName { get; set; }

        public int YOE { get; set; }
    }
}

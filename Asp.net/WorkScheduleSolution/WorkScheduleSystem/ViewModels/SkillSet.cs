using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WorkScheduleSystem.ViewModels
{
    public class SkillSet
    {
        public int SkillID { get; set; }

        public int Level { get; set; }

        public int? YOE { get; set; }

        public decimal HourlyWage { get; set; }
    }
}

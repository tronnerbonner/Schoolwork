namespace WorkScheduleSystem.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    internal partial class EmployeeSkill
    {
        public int EmployeeSkillID { get; set; }

        public int EmployeeID { get; set; }

        public int SkillID { get; set; }
        [Range(1, 3, ErrorMessage = "Value for skill level must be between 1-3.")]
        public int Level { get; set; }

        public int? YearsOfExperience { get; set; }

        [Column(TypeName = "money")]
        public decimal HourlyWage { get; set; }

        public virtual Employee Employee { get; set; }

        public virtual Skill Skill { get; set; }
    }
}

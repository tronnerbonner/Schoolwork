using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
#endregion

namespace starTEDSystem.Entities
{
    [Table("Clubs")]
    public class Club
    {
        [Key]
        [StringLength(10, ErrorMessage = "ClubID cannot exceed 10 chracacters")]
        public string ClubID { get; set; }

        public int? EmployeeID { get; set; }

        [Required(ErrorMessage = "Club Name is required")]
        [StringLength(50,ErrorMessage ="Name cannot exceed 50 characters")]
        public string ClubName { get; set; }

        public bool Active { get; set; }

        [Required(ErrorMessage = "Fee is required")]
        public decimal Fee { get; set; }
    }
}

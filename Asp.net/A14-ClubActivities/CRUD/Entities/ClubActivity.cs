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
    [Table("ClubActivities")]
    public class ClubActivity
    {
        [Key]
        public int ActivityID { get; set; }

        [Required(ErrorMessage ="Club ID is required")]
        [StringLength(10, ErrorMessage = "ClubID cannot exceed 10 chracacters")]
        public string ClubID { get; set; }

        public int? CampusVenueID { get; set; }

        [Required(ErrorMessage ="Activity Name is required")]
        [StringLength(100,ErrorMessage ="Name cannot be greater than 100 characters")]
        public string Name { get; set; }

        private string _Description;
        [StringLength(250,ErrorMessage ="Description cannot exceed 250 characters")]
        public string Description
        {
            get { return _Description; }
            set { _Description = string.IsNullOrEmpty(value) ? null : value; }
        }

        public DateTime? StartDate { get; set; }

        private string _Location;
        [StringLength(50,ErrorMessage ="Location cannot exceet 50 characters")]
        public string Location
        {
            get { return _Location; }
            set { _Location = string.IsNullOrEmpty(value) ? null : value; }
        }

        [Required(ErrorMessage ="Off Campus is required")]
        public bool OffCampus { get; set; }
    }
}

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
    [Table("CampusVenues")]
    public class CampusVenue
    {
        [Key]
        public int CampusVenueID { get; set; }

        [Required(ErrorMessage ="Location is required")]
        [StringLength(25,ErrorMessage ="Location cannot be greater than 30 characters")]
        public string Location { get; set; }
    }
}

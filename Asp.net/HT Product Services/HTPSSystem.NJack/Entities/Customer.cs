using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
#endregion

namespace HTPSSystem.NJack.Entities
{
    [Table("Customer")]
    public class Customer
    {

        [NotMapped]
        public string FullName => $"{LastName},{FirstName}";

        private string _ContactNumber;

        [Key]
        public int CustomerID { get; set; }

        [Required(ErrorMessage = "First Name is required")]
        [StringLength(50, ErrorMessage = "First name cannot be greater than 50 characters")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "Last Name is required")]
        [StringLength(50, ErrorMessage = "Last name cannot be greater than 50 characters")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "Email is required")]
        [RegularExpression(@"^[\w -\.] +@([\w -] +\.)+[\w-]{2,4}$", ErrorMessage = "This email is not valid")]

        [StringLength(100, ErrorMessage = "Email cannot be greater than 100 characters")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Contact Number is required")]
        [StringLength(12, ErrorMessage = "Contact number cannot be greater than 12 characters")]
        public string ContactNumber
        {
            get { return _ContactNumber; }
            set { _ContactNumber = string.IsNullOrEmpty(value) ? null : value; }
        }
    }
}
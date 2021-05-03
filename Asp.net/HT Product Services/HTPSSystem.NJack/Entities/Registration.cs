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
    [Table("Registration")]
    public class Registration
    {
        [Key]
        public int RegistrationID { get; set; }

        public int? CustomerID { get; set; }
        public int? ProductID { get; set; }

        [Required(ErrorMessage = "Serial Number is required")]
        [StringLength(10, ErrorMessage = "Serial Number cannot be greater than 10 characters")]
        public string SerialNumber { get; set; }

        [Required(ErrorMessage = "Date of purchase is required")]
        public DateTime DateOfPurchase { get; set; }

        [Required(ErrorMessage = "Purchased from is required")]
        [StringLength(50, ErrorMessage = "Purchased from cannot be greater than 50 characters")]
        public string PurchasedFrom { get; set; }

        [Required(ErrorMessage = "Purchase Province is required")]
        [StringLength(2, ErrorMessage = "Purchase province must be 2 characters")]
        public string PurchaseProvince { get; set; }


    }
}

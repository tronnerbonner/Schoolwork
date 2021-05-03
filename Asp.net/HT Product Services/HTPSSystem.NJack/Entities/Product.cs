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
    [Table("Product")]
    public class Product
    {
        [Key]
        public int ProductID { get; set; }

        [Required(ErrorMessage = "Product Name is required")]
        [StringLength(50, ErrorMessage = "Product Name cannot be greater than 50 characters")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Model number is required")]
        [StringLength(15, ErrorMessage = "Model Number cannot be fewer than 15 characters")]
        public string ModelNumber { get; set; }

        public bool Discontinued { get; set; }

        public DateTime? DiscontinuedDate { get; set; }

        [NotMapped]
        public string ProductFullName => $"{ModelNumber} : {Name}";
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Aditional Namespaces
using HTPSSystem.NJack.Entities;
using HTPSSystem.NJack.DAL;
#endregion

namespace HTPSSystem.NJack.BLL
{
    public class ProductController
    {
        public Product Product_Find(int productid)
        {
            using (var context = new HTPSContext())
            {
                return context.Product.Find(productid);
            }
        }

        public List<Product> Product_List()
        {
            using (var context = new HTPSContext())
            {
                return context.Product.ToList();
            }
        }
    }
}

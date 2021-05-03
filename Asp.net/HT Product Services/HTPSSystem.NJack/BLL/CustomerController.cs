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
    public class CustomerController
    {
        public List<Customer> Customer_List()
        {
            using (var context = new HTPSContext())
            {
                return context.Customer.ToList();
            }
        }
    }
}

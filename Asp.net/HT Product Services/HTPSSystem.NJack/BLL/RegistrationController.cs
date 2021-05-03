using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Aditional Namespaces
using HTPSSystem.NJack.Entities;
using HTPSSystem.NJack.DAL;
using System.Data.SqlClient;
#endregion

namespace HTPSSystem.NJack.BLL
{
    public class RegistrationController
    {
        public List<Registration> Registration_GetByProduct(int productid)
        {
            using (var context = new HTPSContext())
            {
                IEnumerable<Registration> results = context.Database.SqlQuery<Registration>("Registration_GetByProduct @ProductID",
                    new SqlParameter("ProductID", productid));

                return results.ToList();
            }
        }

        public List<Registration> Registration_GetByCustomer(int customerid)
        {
            using (var context = new HTPSContext())
            {
                IEnumerable<Registration> results = context.Database.SqlQuery<Registration>("Registration_GetByCustomer @CustomerID",
                    new SqlParameter("CustomerID", customerid));

                return results.ToList();
            }
        }

        public List<Registration> Registration_GetByModelNumber(string partialmodelnumber)
        {
            using (var context = new HTPSContext())
            {
                IEnumerable<Registration> results = context.Database.SqlQuery<Registration>("Registration_GetByModelNumber @ModelNumber",
                    new SqlParameter("ModelNumber", partialmodelnumber));

                return results.ToList();
            }
        }

        public List<Registration> Registration_List()
        {
            using (var context = new HTPSContext())
            {
                return context.Registration.ToList();
            }
        }
       
        public Registration Registration_Find(int registrationid)
        {
            using (var context = new HTPSContext())
            {
                return context.Registration.Find(registrationid);
            }
        }

        public int Registration_Add(Registration item)
        {
            using (var context = new HTPSContext())
            {
                context.Registration.Add(item);
                context.SaveChanges();
                return item.RegistrationID;
            }
        }

        public int Registration_Update(Registration item)
        {
            using (var context = new HTPSContext())
            {
                context.Entry(item).State = System.Data.Entity.EntityState.Modified;
                int rowsaffected = context.SaveChanges();
                return rowsaffected;
            }
        }

        public int Registration_Delete(int registrationid)
        {
            using (var context = new HTPSContext())
            {
                int rowsaffected = 0;
                Registration exists = context.Registration.Find(registrationid);

                if (exists == null)
                {
                    throw new Exception("Registration no longer exists. Please select a new registration");
                }
                else
                {
                    context.Registration.Remove(exists);
                    rowsaffected = context.SaveChanges();
                    return rowsaffected;
                }
            }
        }
    }
}

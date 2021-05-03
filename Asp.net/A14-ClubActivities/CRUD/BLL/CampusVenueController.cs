using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Aditional Namespaces
using starTEDSystem.Entities;
using starTEDSystem.DAL;
#endregion

namespace starTEDSystem.BLL
{
    public class CampusVenueController
    {
        public List<CampusVenue> CampusVenue_List()
        {
            using (var context = new StartedContext())
            {
                return context.CampusVenues.ToList();
            }
        }
    }
}

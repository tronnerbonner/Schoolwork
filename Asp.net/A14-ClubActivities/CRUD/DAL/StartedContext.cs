using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using System.Data.Entity;
using starTEDSystem.Entities;
#endregion

namespace starTEDSystem.DAL
{
    internal class StartedContext : DbContext
    {
        public StartedContext() : base("StarTEDDb")
        {

        }

        public DbSet<CampusVenue> CampusVenues { get; set; }
        public DbSet<ClubActivity> ClubActivities { get; set; }
        public DbSet<Club> Clubs { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Aditional Namespaces
using starTEDSystem.Entities;
using starTEDSystem.DAL;
using System.Data.SqlClient;
#endregion

namespace starTEDSystem.BLL
{
    public class ClubActivityController
    {
        public List<ClubActivity> ClubActivity_List()
        {
            using (var context = new StartedContext())
            {
                return context.ClubActivities.ToList();
            }
        }

        public ClubActivity ClubActivity_Find(int activityid)
        {
            using (var context = new StartedContext())
            {
                return context.ClubActivities.Find(activityid);
            }
        }

        public List<ClubActivity> ClubActivities_FindByClub (string clubid)
        {
            using (var context = new StartedContext())
            {
                IEnumerable<ClubActivity> results = context.Database.SqlQuery<ClubActivity>("ClubActivities_FindByClub @clubid",
                    new SqlParameter("clubid", clubid));
                return results.ToList();
            }
        }

        public List<ClubActivity> ClubActivities_FindByClubAndDate(string clubid, DateTime startdate)
        {
            using (var context = new StartedContext())
            {
                IEnumerable<ClubActivity> results = context.Database.SqlQuery<ClubActivity>("ClubActivities_FindByClubAndDate @clubid, @startdate",
                    new SqlParameter("clubid", clubid),
                    new SqlParameter("startdate", startdate));
                return results.ToList();
            }
        }

        public int Activity_Add(ClubActivity item)
        {
            using (var context = new StartedContext())
            {
                context.ClubActivities.Add(item);
                context.SaveChanges();
                return item.ActivityID;
            }
        }

        public int Activity_Update(ClubActivity item)
        {
            using (var context = new StartedContext())
            {
                context.Entry(item).State = System.Data.Entity.EntityState.Modified;
                int rowsaffected = context.SaveChanges();
                return rowsaffected;
            }
        }

        public int Activity_Delete(int activityid)
        {
            using (var context = new StartedContext())
            {
                int rowsaffected = 0;
                ClubActivity exists = context.ClubActivities.Find(activityid);
                if (exists == null)
                {
                    throw new Exception("Activity does not exists. Please select a new activity");
                }
                else
                {
                    context.ClubActivities.Remove(exists);
                    rowsaffected = context.SaveChanges();
                    return rowsaffected;
                }
            }
        }
    }
}

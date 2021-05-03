using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using WorkScheduleSystem.Entities;
using WorkScheduleSystem.DAL;
using WorkScheduleSystem.ViewModels;
using System.ComponentModel;
#endregion
namespace WorkScheduleSystem.BLL
{
    [DataObject]
    public class SkillController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<SkillItem> Skills_List()
        {
            using (var context = new WorkScheduleContext()) 
            {
                IEnumerable<SkillItem> results = from x in context.Skills
                                                 select new SkillItem
                                                 {
                                                     SkillID = x.SkillID,
                                                     Description = x.Description
                                                 };
                return results.ToList();
            }
        }
    }
}

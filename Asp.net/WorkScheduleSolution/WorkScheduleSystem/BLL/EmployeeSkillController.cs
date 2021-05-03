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
using FreeCode.Exceptions;
#endregion
namespace WorkScheduleSystem.BLL
{
    [DataObject]
    public class EmployeeSkillController
    {
        #region CRUD
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public int EmployeeSkill_Add(EmployeeSkillItem item)
        {
            using (var context = new WorkScheduleContext())
            {
                EmployeeSkill entityItem = new EmployeeSkill
                {
                    EmployeeID = item.EmployeeID,
                    SkillID = item.SkillID,
                    Level = item.Level,
                    YearsOfExperience = item.YearsOfExperience,
                    HourlyWage = item.HourlyWage
                };

                context.EmployeeSkills.Add(entityItem);
                context.SaveChanges();
                return entityItem.EmployeeSkillID;
            }
        }
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public void EmployeeSkill_Update(EmployeeSkillItem item)
        {
            using (var context = new WorkScheduleContext())
            {
                EmployeeSkill entityItem = new EmployeeSkill
                {
                    EmployeeSkillID = item.EmployeeSkillID,
                    EmployeeID = item.EmployeeID,
                    SkillID = item.SkillID,
                    Level = item.Level,
                    YearsOfExperience = item.YearsOfExperience,
                    HourlyWage = item.HourlyWage
                };
                context.Entry(entityItem).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public void EmployeeSkill_Delete(EmployeeSkillItem item)
        {
            EmployeeSkill_Delete(item.EmployeeSkillID);
        }

        public void EmployeeSkill_Delete(int employeeSkillId)
        {
            using (var context = new WorkScheduleContext())
            {
                var exists = context.EmployeeSkills.Find(employeeSkillId);
                context.EmployeeSkills.Remove(exists);
                context.SaveChanges();
            }
        }
        #endregion

        #region Queries
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<EmployeeSkillItem> EmployeeSkills_GetEmployeeSkillEmployee()
        {
            using (var context = new WorkScheduleContext())
            {
                IEnumerable<EmployeeSkillItem> results = from x in context.EmployeeSkills
                                                         select new EmployeeSkillItem
                                                         {
                                                             EmployeeSkillID = x.EmployeeSkillID,
                                                             EmployeeID = x.EmployeeID,
                                                             EmployeeFullName = x.Employee.LastName + ", " + x.Employee.FirstName,
                                                             SkillID = x.SkillID,
                                                             SkillName = x.Skill.Description,
                                                             Level = x.Level,
                                                             YearsOfExperience = x.YearsOfExperience == null ? default(int) : (int)x.YearsOfExperience,
                                                             HourlyWage = x.HourlyWage
                                                         };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<EmployeeSkillEmployee> EmployeeSkills_GetEmployeeBySkillID(int skillid)
        {
            using (var context = new WorkScheduleContext())
            {
                IEnumerable<EmployeeSkillEmployee> results = from x in context.EmployeeSkills
                                                             where x.SkillID == skillid
                                                             select new EmployeeSkillEmployee
                                                             {
                                                                 SkillID = x.SkillID,
                                                                 SkillName = x.Skill.Description,
                                                                 SkillLevel = x.Level,
                                                                 EmployeeID = x.EmployeeID,
                                                                 FullName = x.Employee.LastName + ", " + x.Employee.FirstName,
                                                                 Phone = x.Employee.HomePhone,
                                                                 Active = x.Employee.Active,
                                                                 YOE = x.YearsOfExperience == null ? default(int) : (int)x.YearsOfExperience
                                                             };
                return results.ToList();
            }
        }
        #endregion

        List<Exception> brokenRules = new List<Exception>();

        #region Exercise 4
        public void Register_Employee(EmployeeItem employee, List<SkillSet> skillset)
        {
            Employee employeeExists = null;
            EmployeeSkill skillExists = null;

            using (var context = new WorkScheduleContext())
            {
                if (string.IsNullOrEmpty(employee.FirstName))
                {
                    brokenRules.Add(new BusinessRuleException<string>("Employee is missing, unable to add employee", nameof(employee.FirstName), employee.FirstName));
                }
                if (!skillset.Any())
                {
                    brokenRules.Add(new BusinessRuleException<int>("No skills selected, unable to add employee", nameof(skillset), skillset.Count()));
                }

                employeeExists = (from x in context.Employees
                                  where (x.FirstName.Equals(employee.FirstName)
                                      && x.LastName.Equals(employee.LastName)
                                      && x.HomePhone.Equals(employee.Phone))
                                  select x).FirstOrDefault();
                if (employeeExists == null)
                {
                    employeeExists = new Employee()
                    {
                        FirstName = employee.FirstName,
                        LastName = employee.LastName,
                        HomePhone = employee.Phone,
                        Active = true
                    };
                    context.Employees.Add(employeeExists);
                }
                else
                {
                    brokenRules.Add(new BusinessRuleException<EmployeeItem>("This employee already exists, unable to re-add employee", nameof(employee), employee));
                }

                foreach (SkillSet item in skillset)
                {
                    if (item.YOE < 0 || item.YOE > 50)
                    {
                        brokenRules.Add(new BusinessRuleException<int>("The YOE must be greater than 0 or less than 50", nameof(item.YOE), int.Parse(item.YOE.ToString())));
                    }

                    if (item.HourlyWage < (decimal)15.00 || item.HourlyWage > (decimal)100.00)
                    {
                        brokenRules.Add(new BusinessRuleException<decimal>("The wage cannot be less than $15.00 or greater than $100.00", nameof(item.HourlyWage), item.HourlyWage));
                    }
                    
                }

                if (brokenRules.Count > 0)
                {
                    throw new BusinessRuleCollectionException("Add Employee Concerns:", brokenRules);
                }
                else
                {

                    foreach (SkillSet item in skillset)
                    {
                        skillExists = new EmployeeSkill()
                        {
                            SkillID = item.SkillID,
                            Level = item.Level,
                            YearsOfExperience = item.YOE,
                            HourlyWage = item.HourlyWage,
                            EmployeeID = employeeExists.EmployeeID
                        };
                        employeeExists.EmployeeSkills.Add(skillExists);                        
                    }
                    context.SaveChanges();
                }

            }
            #endregion
        }
    }
}

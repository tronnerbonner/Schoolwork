<Query Kind="Statements">
  <Connection>
    <ID>cb2a72b7-a56a-40b5-ba48-c962fdecfef0</ID>
    <NamingServiceVersion>2</NamingServiceVersion>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WorkSchedule</Database>
  </Connection>
</Query>

//Question 1
var resultsnonequalified = from x in Skills
where x.EmployeeSkills.Count() == 0
select new
{
	Description = x.Description
};
//resultsnonequalified.Dump();

//Question 2
var resultsrequiredticket = from x in Skills
where x.RequiresTicket == true
select new
{
	Description = x.Description,
	Employees = (from y in x.EmployeeSkills
				orderby y.YearsOfExperience descending
				select new 
				{
					Name = y.Employee.FirstName + " " + y.Employee.LastName,
					Level = y.Level == 1 ? "Novice" :
							y.Level == 2 ? "Proficient" :
							y.Level == 3 ? "Expert" : "",
					YearsExperience = y.YearsOfExperience
				}).ToList()
};
//resultsrequiredticket.Dump();

//Question 3
var resultsmultipleskills = from x in Employees
where x.EmployeeSkills.Count > 1
select new 
{
	Name = x.FirstName + " " + x.LastName,
	Skills = (from y in x.EmployeeSkills
				select new 
				{
					Description = y.Skill.Description,
					Level = y.Level == 1 ? "Novice" :
							y.Level == 2 ? "Proficient" :
							y.Level == 3 ? "Expert" : "",
							YearsExperience = y.YearsOfExperience
				}).ToList()
};
//resultsmultipleskills.Dump();

//Question 4
var resultsemployeesperday = from x in Shifts 
orderby x.DayOfWeek
where x.PlacementContract.Location.Name.Contains("NAIT")
group x by x.DayOfWeek into gTemp
select new 
{
	DayOfWeek =	gTemp.Key == 0 ? "Sun":
				gTemp.Key == 1 ? "Mon":
				gTemp.Key == 2 ? "Tue":
				gTemp.Key == 3 ? "Wed":
				gTemp.Key == 4 ? "Thu":
				gTemp.Key == 5 ? "Fri":
				gTemp.Key == 6 ? "Sat": "",
	EmployeesNeeded = (from y in gTemp
					   select y.NumberOfEmployees).Sum(i=>i)
};
//resultsemployeesperday.Dump();

//Question 5
var resultssum = from x in Employees
select ((from y in x.EmployeeSkills select y.YearsOfExperience).Sum());
//resultssum.Dump();

var resultsmostyoe = from x in Employees
where (from y in x.EmployeeSkills select y.YearsOfExperience).Sum() == resultssum.Max()
select new 
{
	Name = x.FirstName + " " + x.LastName,
	YearCount = ((from y in x.EmployeeSkills select y.YearsOfExperience).Sum())
};
//resultsmostyoe.Dump();

//Question 6
var resultsnotinmarch = from x in Employees
where (from y in x.Schedules select y.Day).All(tr => tr.Month !=  3)
orderby x.LastName, x.FirstName
select new
{
	Name = x.LastName + ", " + x.FirstName,
};
//resultsnotinmarch.Dump();

//Question 7
var resultstotalearningsmarch = from x in Employees
where (from y in x.Schedules select y.Day).Any(tr => tr.Month ==  3)
select new
{
	Name = x.FirstName + " " + x.LastName,
	RegularEarnings = (from y in x.Schedules.ToList()
						where y.Day.Month == 3
						select y.OverTime == false ? (y.Shift.EndTime.TotalHours - y.Shift.StartTime.TotalHours) * (double)y.HourlyWage : 0).Sum().ToString("0.00", System.Globalization.CultureInfo.InvariantCulture),
	OverTimeEarnings =  (from y in x.Schedules.ToList()
						where y.Day.Month == 3
						select y.OverTime == true ? (y.Shift.EndTime.TotalHours - y.Shift.StartTime.TotalHours) * (double)y.HourlyWage*1.5 : 0).Sum().ToString("0.00", System.Globalization.CultureInfo.InvariantCulture),
	NumberOfShifts = (from y in x.Schedules where y.Day.Month == 3 select y.Day).Count()
};
//resultstotalearningsmarch.Dump();
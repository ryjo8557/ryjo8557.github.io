// Problem 1
const employees = [
    { firstName: "Sam", department: "Tech", designation: "Manager", salary: 40000, raiseEligible: true },
    { firstName: "Mary", department: "Finance", designation: "Trainee", salary: 18500, raiseEligible: true },
    { firstName: "Bill", department: "HR", designation: "Executive", salary: 21200, raiseEligible: false }
  ];
  
  console.log("Problem 1:", employees);
  
  // Problem 2
  const company = {
    companyName: "Tech Stars",
    website: "www.techstars.site",
    employees: employees
  };
  
  console.log("Problem 2:", company);
  
  // Problem 3
  const newEmployee = { firstName: "Anna", department: "Tech", designation: "Executive", salary: 25600, raiseEligible: false };
  company.employees.push(newEmployee);
  
  console.log("Problem 3:", company);
  
  // Problem 4
  let totalSalary = 0;
  for (const emp of company.employees) {
    totalSalary += emp.salary;
  }
  
  console.log("Problem 4: Total Salary =", totalSalary);
  
  // Problem 5
  function applyRaises(company) {
    for (const emp of company.employees) {
      if (emp.raiseEligible) {
        emp.salary *= 1.1;
        emp.raiseEligible = false;
      }
    }
  }
  
  applyRaises(company);
  console.log("Problem 5: Company after raises", company);
  
  // Problem 6
  const wfhEmployees = ['Anna', 'Sam'];
  for (const emp of company.employees) {
    emp.wfh = wfhEmployees.includes(emp.firstName);
  }
  
  console.log("Problem 6: Company with WFH info", company);
  
using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.ViewModels
{
    public class EmpAdd
    {
        public utblEmpPersonalInfoKey EmpAddDetails { get; set; }
        public string Role { get; set; }
        public IEnumerable<VendorDDList> StateDDList { get; set; }
        public IEnumerable<VendorDDList> DesignationDDList { get; set; }
        public IEnumerable<VendorDDList> RolesDDList { get; set; }
    }

    public class EmpManageViewModel
    {
        public utblEmpPersonalInfoKey utblEmpPersonalInfoKey { get; set; }
        public EmployeeProfile EmpProfileDtls { get; set; }
    }

    public class EmpManageVM
    {
        public List<EmpList> empList { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
    }

    public class EmployeeProfile
    {
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string PhotoNormal { get; set; }
        public string PhotoThumb { get; set; }
        public string UserRole { get; set; }
    }
}

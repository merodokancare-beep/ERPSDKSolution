using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblEmpAttendanceMapping
    {
        [Key]
        public long EmpDeviceMappingID { get; set; }
        [Required(ErrorMessage = "Employee name is required...")]
        [DisplayName("Employee Name")]
        public string EmployeeID { get; set; }
        [Required(ErrorMessage = "Device ID is required...")]
        [DisplayName("Device ID")]
        public int EmpDeviceID { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
        
    }
}

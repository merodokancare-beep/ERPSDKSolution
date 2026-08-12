using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.ViewModels
{
    public class EmpAttendanceViewModel
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public PageParameters PageParameter { get; set; }
        public EmpAttendanceView ViewEmpAttendance { get; set; }
        public List<EmpAttendanceView> ViewEmpAttendanceList { get; set; }
        public MonthDtls MonthList { get; set; }
        public List<HolidayDateMonth> HolidayDateList { get; set; }
    }
    public class EmpAttendanceView
    {
        public string AttendanceID { get; set; }
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public DateTime AttendanceDate { get; set; }
        public string InTime { get; set; }
        public string OutTime { get; set; }
        public string AttendanceStatus { get; set; }
        public string LogType { get; set; }
        public string Remarks { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
        //public string EmpAttentList { get; set; }
        //public string LType { get; set; }
        //public string LStatus { get; set; }
    }
    public class MonthDtls
    {
        public int Month { get; set; }
        public int Year { get; set; }
    }
    public class HolidayDateMonth
    {
        public DateTime HolidayDates { get; set; }
    }
}

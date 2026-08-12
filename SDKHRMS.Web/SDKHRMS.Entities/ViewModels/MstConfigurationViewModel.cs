using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SDKHRMS.Entities.ViewModels
{
    public class MstConfigurationViewModel
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public PageParameters PageParameter { get; set; }
        #region Client
        public IEnumerable<ClientDDList> ClientDDList { get; set; }
        public IEnumerable<utblMstClient> ClientList { get; set; }
        public utblMstClient utblMstClient { get; set; }
        #endregion
        #region Device mapping
        public IEnumerable<EmpDeviceView> EmpAttDevMappingList { get; set; }
        public utblEmpAttendanceMapping utblEmpAttendanceMapping { get; set; }
        public IEnumerable<EmployeeListForDD> EmpListForDD { get; set; }
        #endregion
        #region Item
        public List<utblMstItem> ItemList { get; set; }
        public utblMstItem utblMstItem { get; set; }
        #endregion
    }
    public class HolidayVM
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public IEnumerable<MstHolidayView> HolidayList { get; set; }
    }
    public class HolidayAdd
    {
        public PageParameters PageParameter { get; set; }
        public utblMstHoliday utblMstHoliday { get; set; }
    }
    public class FinancialYearVM
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public List<UtblMstFinancialYear> FinancialYearList { get; set; }
    } 
    public class FinancialYearAdd
    {
        public PageParameters PageParameter { get; set; }
        public UtblMstFinancialYear FinancialYear { get; set; }
    }
    public class ReferenceNoVM
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public IEnumerable<utblMstReferenceNumber> MstReferenceNumberList { get; set; }
    }
    public class ReferenceNoAdd
    {
        public PageParameters PageParameter { get; set; }
        public utblMstReferenceNumber MstReferenceNumber { get; set; }
    }
    public class VendorClientVM
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public IEnumerable<utblMstVendorDetail> VendorDetailsList { get; set; }
    }
    public class VendorClientAdd
    {
        public PageParameters PageParameter { get; set; }
        public utblMstVendorDetail ClientVendorAdd { get; set; }
    }
    public class ExpenseTypeViewModel
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        //public PageParameters PageParameter { get; set; }
        public List<utblMstExpenseType> ExpenseTypeList { get; set; }
        public utblMstExpenseType utblMstExpenseType { get; set; }
    }
    public class ExpenseTypeADD
    {
        public PageParameters PageParameter { get; set; }
        public utblMstExpenseType utblMstExpenseType { get; set; }
    }
    public class ProjectVM
    {
        public IEnumerable<ProjectView> ProjectDetailsList { get; set; }
        public int TotalRecords { get; set; }
        public PagingInfo PagingInfo { get; set; }
        //public PageParameters PageParamekter { get; set; }
    }
    public class ProjectAdd
    {
        public PageParameters PageParameter { get; set; }
        public utblMstProject ProjectModelAdd { get; set; }
        public IEnumerable<VendorDDList> VendorDDList { get; set; }
        public HttpPostedFileBase WOFile { get; set; }
        public HttpPostedFileBase PCCFile { get; set; }
    }
    public class ProjectView
    {
        public long ProjectID { get; set; }
        public string ProjectName { get; set; }
        public long VendorID { get; set; }
        public string VendorName { get; set; }
        public DateTime ProjStartDate { get; set; }
        public DateTime? ProjEndDate { get; set; }
        public string ProjStatus { get; set; }
        public decimal ProjValue { get; set; }
        public string ProjDescription { get; set; }
        public DateTime? WODate { get; set; }
        public string WONo { get; set; }
        public string WOPath { get; set; }
        public string PCCPath { get; set; }
    }

    public class VendorDDList
    {
        public long VenderID { get; set; }
        public string VenderName { get; set; }
    }
    public class MstDepartmentView
    {
        public long DepartmentID { get; set; }
        public string DepartmentName { get; set; }
    }
    public class ClientDDList
    {
        public long ClientID { get; set; }
        public string ClientName { get; set; }
    }
    public class MstHolidayView
    {
        public string HolidayID { get; set; }
        public string HolidayName { get; set; }
        public string HolidayDesc { get; set; }
        public DateTime DateFrom { get; set; }
        public DateTime DateTo { get; set; }
        public int NoofDays { get; set; }
    }
    public class EmployeeListForDD
    {
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
    }
    public class EmpDeviceView
    {
        public long EmpDeviceMappingID { get; set; }
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public int EmpDeviceID { get; set; }
    }
    public class ExpenseTypeDD
    {
        public long ExpenseTypeID { get; set; }
        public string ExpenseType { get; set; }
    }

    #region Unit Master
    public class UnitVM
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public PageParameters PageParameter { get; set; }
        public IEnumerable<utblMstUnit> UnitList { get; set; }
    }
    #endregion

}

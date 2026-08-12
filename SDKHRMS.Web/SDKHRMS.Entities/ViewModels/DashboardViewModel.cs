using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;


namespace SDKHRMS.Entities.ViewModels
{
    public class DashboardViewModel
    {
        public TotalCount TotalCount { get; set; }
        public List<ReferenceModel> ReferenceModelList { get; set; }
        public List<PurchaseSaleView> PurchaseSaleList { get; set; }
        public InvoicePurchaseGst InvoicePurchaseGstView { get; set; }
        public string FiscalYear { get; set; }
        public IEnumerable<ProjectDashboardDetails> ProjectDtlsList { get; set; }
        public IEnumerable<RefDashboardDetails> RefDtlsList { get; set; }
        public IEnumerable<MonthlyCalView> MonthlyCalList { get; set; }
        public List<ProjectDD> ProjectList { get; set; }
        public List<ClientDDList> ClientList { get; set; }
        public List<utblSaleInvoiceKey> SalesInvoiceList { get; set; }
        public List<utblPurchaseInvoiceKey> PurchaseInvoiceList { get; set; }
    }
    public class TotalCount
    {
        public int TotalPresent { get; set; }
        public int TotalAbsent { get; set; }
        public int TotalEmp { get; set; }

    }

    public class InvoicePurchaseGst
    {
        public decimal FiscalInvoiceAmt { get; set; }
        public decimal MonthInvoiceAmt { get; set; }
        public decimal FiscalPurchaseAmt { get; set; }
        public decimal MonthPurchaseAmt { get; set; }
        public decimal FiscalGSTInputAmt { get; set; }
        public decimal MonthGSTInputAmt { get; set; }
        public decimal FiscalGSTPaymentAmt { get; set; }
        public decimal MonthGSTPaymentAmt { get; set; }

    }
    public class CalendarMonthlyView
    {
        public string AttendanceDay { get; set; }
        public int AttendanceDate { get; set; }
        //public bool IsPresent { get; set; }
        //public bool IsAbsent { get; set; }
        //public bool IsSundayWork { get; set; }
        public string AttendanceStatus { get; set; }
        public string IsHoliday { get; set; }
    }
    public class RefDashboardDetails
    {
        public DateTime RefDate { get; set; }
        public string RefType { get; set; }
        public string RefNumber { get; set; }
    }
    public class ProjectDashboardDetails
    {
        public DateTime StartDate { get; set; }
        public string ProjectName { get; set; }
        public string VendorName { get; set; }

    }
    public class MonthlyCalView
    {
        public string CalDay { get; set; }
        public int CalDate { get; set; }
        public string HolidayName { get; set; }
        public bool IsHoliday { get; set; }
    }
    public class NotificationView
    {
        public string AlertName { get; set; }
        public int AlertCount { get; set; }
        public string AlertURL { get; set; }
    }

    public class DashboardVM
    {
        public FiscalWiseCount FiscalWiseCount { get; set; }
        public IEnumerable<RefDashboardDetails> RefDtlsList { get; set; }
    }
    public class FiscalWiseCount
    {
        public int OpenProject { get; set; }
        public int ClosedProject { get; set; }
        public int SaleInvCount { get; set; }
        public int POCount { get; set; }
        public int OpenProjPer { get; set; }
        public int ClosedProjPer { get; set; }
        public int SaleInvPer { get; set; }
        public int POCountPer { get; set; }
    }
    public class GSTInput
    {
        public decimal TotalIGST { get; set; }
        public decimal TotalCGST { get; set; }
        public decimal TotalSGST { get; set; }

    }
    public class DirectPaymentWithExpHead
    {
        public string ExpenseHead { get; set; }
        //public string MonName { get; set; }
        public decimal AmountReceived { get; set; }
        public decimal AmountReleased { get; set; }
    }
    public class ProjectDetailsChart
    {
        public string ProjectName { get; set; }
        //public string MonName { get; set; }
        public decimal ProjCost { get; set; }
        public decimal PaymentReceived { get; set; }
        public decimal DueAmt { get; set; }

    }
    public class GSTPayable
    {
        public decimal TotalIGST { get; set; }
        public decimal TotalCGST { get; set; }
        public decimal TotalSGST { get; set; }

    }
    public class DirectPayment
    {
        public string ExpHeadName { get; set; }
        public decimal TatalAmount { get; set; }
    }
    public class NewDashboardVM
    {
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        //public FiscalWiseCount FiscalWiseCount { get; set; }
    }


    [DataContract]
    public class DataPoint
    {
        public DataPoint(string label, double y)
        {
            this.Label = label;
            this.Y = y;
        }

        //Explicitly setting the name to be used while serializing to JSON.
        [DataMember(Name = "label")]
        public string Label = "";

        //Explicitly setting the name to be used while serializing to JSON.
        [DataMember(Name = "y")]
        public Nullable<double> Y = null;
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.ViewModels
{
    public class ProjectViewModel
    {
        public IEnumerable<ProjectView> ProjectViewList { get; set; }
        public IEnumerable<VendorDDList> VendorDD { get; set; }
        //public IEnumerable<ProjectDD> ProjectDD { get; set; }
        public int TotalRecords { get; set; }
        public PagingInfo PagingInfo { get; set; }
    }

    public class ProjectOverview
    {
        public ProjectView ProjectView { get; set; }
        public ProjAmountTrans ProjAmountTrans { get; set; }
    }
    public class ProjAmountTrans
    {
        public decimal TotalProjectValue { get; set; }
        public decimal TotalNetAmtReceived { get; set; }
        public decimal TotalTaxDeduction { get; set; }
        public decimal TotalAmtReceived { get; set; }
        public decimal ProjectBalance { get; set; }
        public decimal TotalGSTInput { get; set; }
        public decimal TotalGSTPayable { get; set; }
    }

    public class TaxInvoiceView
    {
        public string SaleInvoiceID { get; set; }
        public DateTime InvoiceDate { get; set; }
        public string ReferenceNo { get; set; }
        public decimal IGSTAmount { get; set; }
        public decimal CGSTAmount { get; set; }
        public decimal SGSTAmount { get; set; }
        public decimal NetAmount { get; set; }
        public decimal TotalAmount { get; set; }
        public bool IsCancelled { get; set; }
    }

    public class POView
    {
        public string PurchaseInvoiceID { get; set; }
        public DateTime PurchaseDate { get; set; }
        public string BillNoRefNo { get; set; }
        public string VendorName { get; set; }
        public decimal GSTAmt { get; set; }
        public decimal NetAmt { get; set; }
        public decimal TotalAmt { get; set; }
        public decimal PaymentReleased { get; set; }
        public decimal DueAmt { get; set; }
        public bool HasMarkForPayment { get; set; }
    }
    public class DirectPaymentModel
    {
        public long DirectPaymentID { get; set; }
        public long ExpenseTypeID { get; set; }
        public string ExpenseTypeName { get; set; }
        public DateTime PaymentDate { get; set; }
        public decimal PaymentAmt { get; set; }
        public string Purpose { get; set; }
        public string Remarks { get; set; }
        public string Status { get; set; }
        public decimal PaidAmount { get; set; }
        public decimal Balance { get; set; }
    }
}

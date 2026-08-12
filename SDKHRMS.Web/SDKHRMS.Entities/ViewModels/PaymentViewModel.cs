using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SDKHRMS.Entities.ViewModels
{
    public class PaymentViewModel
    {
        public List<PaymentView> PaymentViewList { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
    }
    public class PaymentAdd
    {
        public utblPaymentDetail PaymentDetail { get; set; }
        public HttpPostedFileBase UploadFile { get; set; }
        public List<utblMstBank> BankDDList { get; set; }
        public List<ExpenseTypeDD> ExpenseTypeDDList { get; set; }
        public List<VendorDDList> VendorDDList { get; set; }
        public List<ProjectDD> ProjectDDList { get; set; }
    }
    public class PaymentView
    {
        public string PaymentID { get; set; }
        public long ExpenseTypeID { get; set; }
        public string ExpenseType { get; set; }
        public DateTime PaymentDate { get; set; }
        public decimal PaymentAmt { get; set; }
        public string PaymentMode { get; set; }
        public long? BankID { get; set; }
        public string BankName { get; set; }
        public string ChequeTransNo { get; set; }
        public string PaymentFile { get; set; }
        public long? ProjectID { get; set; }
        public string ProjectName { get; set; }
        public long? VendorID { get; set; }
        public string VendorName { get; set; }
        public string PaymentType { get; set; }
        public string Remarks { get; set; }
    }

    #region Payment Receivable
    public class PaymentReceivedVM
    {
        public IEnumerable<PaymentReceivableView> ReceivePayment { get; set; }
        public IEnumerable<ExpenseTypeDD> ExpenseTypeDD { get; set; }
        public IEnumerable<YearDD> ReceivePaymentYearDD { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
    }
    public class PaymentReceivedAdd
    {
        public utblPaymentReceivable PaymentReceived { get; set; }
        public IEnumerable<ExpenseTypeDD> ExpenseTypeDD { get; set; }
        public IEnumerable<utblMstBank> BankDD { get; set; }
        public HttpPostedFileBase UploadFile { get; set; }
    }
    public class ProjPaymentReceivedAdd
    {
        public utblProjPaymentReceivable ProjPaymentReceived { get; set; }
        public IEnumerable<ProjectDD> ProjectDD { get; set; }
        public IEnumerable<utblMstBank> BankDD { get; set; }
        public HttpPostedFileBase UploadFile { get; set; }
    }
    public class ProjPaymentReceivedVM
    {
        public IEnumerable<ProjPaymentReceivableView> ProjPaymentReceivable { get; set; }
        public IEnumerable<ProjectDD> ProjectDD { get; set; }
        public IEnumerable<YearDD> ProjPaymentReceiveYearDD { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
    }
    public class PaymentReceivableView
    {
        public long ReceivedID { get; set; }
        public long ExpenseTypeID { get; set; }
        public string ExpenseType { get; set; }
        public decimal AmtReceived { get; set; }
        public DateTime ReceivedDate { get; set; }
        public string ReceivedMode { get; set; }
        public long? BankID { get; set; }
        public string BankName { get; set; }
        public string TransactionNo { get; set; }
        public string Remarks { get; set; }
        public string UploadedFile { get; set; }
        public string AddedBy { get; set; }
        public DateTime AddedOn { get; set; }
    }
    public class ProjPaymentReceivableView
    {
        public long ProjPaymentReceiveID { get; set; }
        public long ProjectID { get; set; }
        public string ProjectName { get; set; }
        public long? BankID { get; set; }
        public string BankName { get; set; }
        public DateTime ReceivedDate { get; set; }
        public string ReceivedMode { get; set; }
        public string Remarks { get; set; }
        public decimal NetAmtReceived { get; set; }
        public decimal TDSDeductionAmt { get; set; }
        public decimal GstDeductionAmt { get; set; }
        public decimal SecurityDepositAmt { get; set; }
        public decimal OtherDeductionAmt { get; set; }
        public decimal TotalAmt { get; set; }
        public bool IsAdvance { get; set; }
        public string UploadedFile { get; set; }
        public string SaleInvoiceID { get; set; }
        public string InvRefNo { get; set; }
    }
    #endregion

    #region PO Payment Released
    public class POPaymentVM
    {
        public IEnumerable<POPaymentView> POPaymentList { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public IEnumerable<VendorDDList> VendorDD { get; set; }
    }
    public class POPaymentView
    {
        public string PurchaseInvoiceID { get; set; }
        public DateTime PurchaseDate { get; set; }
        public string PORefNo { get; set; }
        public string BillNo { get; set; }
        public string POType { get; set; }
        public string POStatus { get; set; }
        public long? ProjectID { get; set; }
        public string ProjectName { get; set; }
        public long VenderID { get; set; }
        public string VenderName { get; set; }
        public decimal IGSTAmount { get; set; }
        public decimal CGSTAmount { get; set; }
        public decimal SGSTAmount { get; set; }
        public decimal TotalGSTInput { get; set; }
        public decimal ExcludingTaxAmt { get; set; }
        public decimal IncludingTaxAmt { get; set; }
        public decimal AmountPaid { get; set; }
        public decimal BalanceAmount { get; set; }
        public string Remarks { get; set; }
        public string UploadBill { get; set; }
        public string ShipTo { get; set; }
        public string TermsConditions { get; set; }
        public bool IsPOCancelled { get; set; }
        public bool HasMarkForPayment { get; set; }
        public bool IsPaymentDeclined { get; set; }

    }

    public class POPaymentSettleVM
    {
        public POPaymentView POPaymentDtls { get; set; }
        public utblPaymentReleasedTran PaymentReleased { get; set; }
        public IEnumerable<utblMstBank> BankDD { get; set; }
        public HttpPostedFileBase UploadFile { get; set; }
        public string POID { get; set; }
    }
    public class PaymentReleaseView
    {
        public long PaymentID { get; set; }
        public DateTime PaymentDate { get; set; }
        public decimal PaymentAmt { get; set; }
        public string PaymentMode { get; set; }
        public string PurchaseInvoiceID { get; set; }
        public long? DirectPaymentID { get; set; }
        public long? BankID { get; set; }
        public string BankName { get; set; }
        public string PaymentTransNo { get; set; }
        public string UploadedFile { get; set; }
        public string Remarks { get; set; }
        public string AddedBy { get; set; }
        public DateTime AddedOn { get; set; }
    }
    #endregion
    #region Direct Payment
    public class DirectPaymentdAdd
    {
        public utblDirectPayment DirectPayment { get; set; }
        public IEnumerable<ExpenseTypeDD> ExpenseTypeDD { get; set; }
        public IEnumerable<ProjectDD> ProjectDD { get; set; }
        //public IEnumerable<utblMstBank> BankDD { get; set; }
        //public HttpPostedFileBase UploadFile { get; set; }
    }
    public class DirectPaymentVM
    {
        public IEnumerable<DirectPaymentView> DirectPayment { get; set; }
        public IEnumerable<ExpenseTypeDD> ExpenseTypeDD { get; set; }
        public IEnumerable<YearDD> DirectPaymentYearDD { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
    }
    public class DirectPaymentView
    {
        public long DirectPaymentID { get; set; }
        public long ExpenseTypeID { get; set; }
        public string ExpenseTypeName { get; set; }
        public long? ProjectID { get; set; }
        public string ProjectName { get; set; }
        public DateTime PaymentDate { get; set; }
        public decimal PaymentAmt { get; set; }
        public bool IsDeclined { get; set; }
        public string Purpose { get; set; }
        public string Remarks { get; set; }
        public string Status { get; set; }
        public decimal PaidAmount { get; set; }
        public decimal Balance { get; set; }
        public string AddedBy { get; set; }
        public DateTime AddedOn { get; set; }
    }

    public class DirectPaymentSettleVM
    {
        public DirectPaymentView DirectPayment { get; set; }
        public utblPaymentReleasedTran PaymentReleased { get; set; }
        public IEnumerable<utblMstBank> BankDD { get; set; }
        public HttpPostedFileBase UploadFile { get; set; }
        public long DirectPaymentID { get; set; }
    }
    #endregion

}

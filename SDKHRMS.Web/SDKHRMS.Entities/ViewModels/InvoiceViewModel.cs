using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SDKHRMS.Entities.ViewModels
{
    public class InvoiceViewModel
    {
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public PageParameters PageParameter { get; set; }
        public List<VendorDDList> VendorDDList { get; set; }
        public List<CustomInvoiceItems> CustomInvoiceItemList { get; set; }
        public utblSaleInvoiceKey SaleInvoiceKeyModel { get; set; }
        public utblMstItem MstItemModel { get; set; }
        public ReferenecNoDtls InvoiveNoDetails { get; set; }
        public utblMstVendorDetail VendorDetails { get; set; }
        public utblReceivedAmountKey ReceivedAmountKeyModel { get; set; }
        public utblReceivedAmountDetail ReceivedAmountDetailModel { get; set; }
        public List<SaleInvoiceKeyView> SaleInvoiceKeyViewList { get; set; }
        //Purchase Invoice
        public utblPurchaseInvoiceKey PurchaseInvoiceKeyModel { get; set; }
        public List<PurchaseInvoiceKeyView> PurchaseInvoiceKeyViewList { get; set; }
        public List<ItemsView> ItemsViewList { get; set; }
        public string FigureAmount { get; set; }
        //public decimal RoundOfAmount { get; set; }
        //public decimal RoundOfValue { get; set; }
    }
    public class InvoiceAddViewModel
    {
        public utblSaleInvoiceKey SaleInvoiceKeyModel { get; set; }
        public List<CustomInvoiceItems> CustomInvoiceItemList { get; set; }
        public List<VendorDDList> VendorDDList { get; set; }
        public List<ProjectDD> ProjectDDList { get; set; }
        public PageParameters PageParameter { get; set; }
        public ProjectClientDtls ProjectClientDtlsView { get; set; }
        public utblMstProject ProjectDtls { get; set; }
    }
    public class PurchaseAddViewModel
    {
        public utblPurchaseInvoiceKey PurchaseInvoiceKeyModel { get; set; }
        public List<CustomInvoiceItems> CustomInvoiceItemList { get; set; }
        public List<VendorDDList> VendorDDList { get; set; }
        public List<ProjectDD> ProjectDDList { get; set; }
        public PageParameters PageParameter { get; set; }
        public ProjectClientDtls ProjectClientDtlsView { get; set; }
        public utblMstProject ProjectDtls { get; set; }
        public string ShipTo { get; set; }
    }
    public class CustomInvoiceItems
    {
        [Key]
        public string ItemDtlID { get; set; }
        public string SaleInvoiceID { get; set; }//For Also used as PurchaseInvoiceID
        [Required]
        public string ItemName { get; set; }
        [Required]
        public string ItemHSNCode { get; set; }
        [Required]
        public int GSTPercentage { get; set; }
        [Required]
        public double IGSTPercentage { get; set; }
        [Required]
        public double CGSTPercentage { get; set; }
        [Required]
        public double SGSTPercentage { get; set; }
        [Required]
        public int Qty { get; set; }
        [Required]
        public decimal Rate { get; set; }
        [Required]
        public decimal Amount { get; set; }


    }
    public class ItemDD
    {
        public long value { get; set; }
        public string text { get; set; }
    }
    public class ReferenecNoDtls
    {
        public string InvoiceNO { get; set; }
        public string FiscalYear { get; set; }
        public string OperationMsg { get; set; }
    }

    public class SaleInvoiceKeyView
    {
        public string SaleInvoiceID { get; set; }
        public string OrderNo { get; set; }
        public string OrderDate { get; set; }
        public string InvoiceTo { get; set; }
        public DateTime InvoiceDate { get; set; }
        public string ReferenceNo { get; set; }
        public long VenderID { get; set; }
        public string VenderName { get; set; }
        public long ProjectID { get; set; }
        public string ProjectName { get; set; }
        public decimal IGSTAmount { get; set; }
        public decimal CGSTAmount { get; set; }
        public decimal SGSTAmount { get; set; }
        public decimal ExcludingTaxAmt { get; set; }
        public decimal IncludingTaxAmt { get; set; }
        public decimal AdvanceReceived { get; set; }
        public string ReceivedRemarks { get; set; }
        public decimal BalanceAmount { get; set; }
        public string Remarks { get; set; }
        public bool IsCancelled { get; set; }

    }
    public class PurchaseInvoiceKeyView
    {
        public string PurchaseInvoiceID { get; set; }
        public DateTime PurchaseDate { get; set; }
        public string BillNo { get; set; }
        public string PORefNo { get; set; }
        public string VendorName { get; set; }
        public decimal ExcludingTaxAmt { get; set; }
        public decimal IncludingTaxAmt { get; set; }
        public decimal AmountReceived { get; set; }
        public decimal BalanceAmount { get; set; }
        public string UploadBill { get; set; }
        public string Remarks { get; set; }
        public bool IsPoCancelled { get; set; }
        public bool HasMarkForPayment { get; set; }

    }
    public class ProjectDD
    {
        public long ProjectID { get; set; }
        public string ProjectName { get; set; }
    }
    public class SalInvDD
    {
        public string SaleInvoiceID { get; set; }
        public string InvRefNo { get; set; }
    }
    public class ProjectClientDtls
    {
        public long ProjectID { get; set; }
        public string ProjectName { get; set; }
        public DateTime ProjStartDate { get; set; }
        public string ProjStatus { get; set; }
        public string ProjDescription { get; set; }
        public decimal ProjValue { get; set; }
        public string WODate { get; set; }
        public string WONo { get; set; }
        public long VendorID { get; set; }
        public string VenderName { get; set; }
        public string VenderAddress { get; set; }
        public string GSTNo { get; set; }
        public string ContactNo { get; set; }
        public string ContactName { get; set; }

    }

    public class ItemsView
    {
        public string ItemDtlID { get; set; }
        public string SaleInvoiceID { get; set; }
        public string ItemName { get; set; }
        public string ItemHSNCode { get; set; }
        public int GSTPercentage { get; set; }
        public int Qty { get; set; }
        public decimal Rate { get; set; }
        public decimal Amount { get; set; }
        public decimal IGSTAmt { get; set; }
        public decimal CGSTAmt { get; set; }
        public decimal SGSTAmt { get; set; }
        public decimal TotalAmt { get; set; }
    }
    public class PurchaseInvoiceVM
    {
        public List<PurchaseInvoiceKeyView> PurchaseInvoiceKeyViewList { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public PageParameters PageParameter { get; set; }
        public IEnumerable<YearDD> PurchaseYearDD { get; set; }
        public List<VendorDDList> VendorDDList { get; set; }
    }
    public class SaleInvoiceVM
    {
        public List<SaleInvoiceKeyView> SaleInvoiceKeyViewList { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public PageParameters PageParameter { get; set; }
        public IEnumerable<YearDD> SaleYearDD { get; set; }
        public List<VendorDDList> ClientDDList { get; set; }
    }
    public class YearDD
    {
        public int YearNo { get; set; }
    }
    public class POExportVM
    {
        public POPaymentView PODetails { get; set; }
        public List<ItemsView> POItemsList { get; set; }
        public utblMstVendorDetail VendorDetails { get; set; }
        public string FigureAmount { get; set; }
    }
}

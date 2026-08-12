using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.ViewModels
{
    public class PurchaseSalesViewModel
    {
        public utblPurchaseSale utblPurchaseSale { get; set; }
        public List<PurchaseSaleView> PurchaseSaleList { get; set; }
        public List<VendorDDList> VendorDDList { get; set; }
        public List<ClientDDList> ClientDDList { get; set; }
        public MonthDtls MonthList { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
    }
}
public class PurchaseSaleView
{
    public long PurchaseSaleID { get; set; }
    public DateTime PurchaseSaleDate { get; set; }
    public string PurchaseSaleInvoiceNo { get; set; }
    public string VenderName { get; set; }
    public string ClientName { get; set; }
    public string HSNSAC { get; set; }
    public decimal IGST { get; set; }
    public decimal CGST { get; set; }
    public decimal SGST { get; set; }
    public decimal TaxableAmount { get; set; }
    public string PurchaseSaleType { get; set; }
    public string IsIGST { get; set; }
    public string Description { get; set; }
    public string VendorGSTNO { get; set; }
    public string ClientGSTNO { get; set; }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblPurchaseInvoiceKey
    {
        [Key]
        public string PurchaseInvoiceID { get; set; }
        [Required]
        [Display(Name = "Purchase Date")]
        public DateTime PurchaseDate { get; set; }
        public string PORefNo { get; set; }
        //[Required]
        [Display(Name = "Bill No.")]
        public string BillNo { get; set; }
        [Required]
        public string POType { get; set; }
        [Required]
        [Display(Name = "Vendor Name")]
        public long VenderID { get; set; }
        [Display(Name = "Project Name")]
        public long? ProjectID { get; set; }
        [Required]
        public decimal IGSTAmount { get; set; }
        [Required]
        public decimal CGSTAmount { get; set; }
        [Required]
        public decimal SGSTAmount { get; set; }
        [Required]
        public decimal ExcludingTaxAmt { get; set; }
        [Required]
        public decimal IncludingTaxAmt { get; set; }
        public decimal AmountPaid { get; set; }
        [Required]
        public decimal BalanceAmount { get; set; }
        [Required]
        public string Remarks { get; set; }
        public string UploadBill { get; set; }
        public string ShipTo { get; set; }
        public string TermsConditions { get; set; }
        public bool IsPOCancelled { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

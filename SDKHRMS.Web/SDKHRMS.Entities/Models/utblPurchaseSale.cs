using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblPurchaseSale
    {
        [Key]
        public long PurchaseSaleID { get; set; }
        [Required]
        [DisplayName("Date")]
        public DateTime PurchaseSaleDate { get; set; }
        [Required]
        [DisplayName("Bill No.")]
        public string PurchaseSaleInvoiceNo { get; set; }
        [DisplayName("Vendor Name")]
        public long? VenderID { get; set; }
        [DisplayName("Client Name")]
        public long? ClientID { get; set; }
        [DisplayName("HSN/SAC")]
        public string HSNSAC { get; set; }
        [DisplayName("IGST Amount")]
        public decimal IGST { get; set; }
        [DisplayName("CGST Amount")]
        public decimal CGST { get; set; }
        [DisplayName("SGST Amount")]
        public decimal SGST { get; set; }
        [Required]
        [DisplayName("Taxable Amount")]
        public decimal TaxableAmount { get; set; }
        [Required]
        [DisplayName("Type")]
        public string PurchaseSaleType { get; set; }
        [Required]
        [DisplayName("IsIGST")]
        public bool IsIGST { get; set; }
        [DisplayName("Description")]
        public string Description { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

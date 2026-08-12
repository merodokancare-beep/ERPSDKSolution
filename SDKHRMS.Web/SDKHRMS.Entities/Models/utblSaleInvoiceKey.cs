using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblSaleInvoiceKey
    {
        [Key]
        public string SaleInvoiceID { get; set; }
        [Display(Name = "Order No")]
        public string OrderNo { get; set; }
        [Display(Name = "Order Date")]
        public DateTime? OrderDate { get; set; }
        [Required]
        [Display(Name = "Invoice To")]
        public string InvoiceTo { get; set; }
        [Required]
        [Display(Name = "Invoice Date")]
        public DateTime InvoiceDate { get; set; }
        public string ReferenceNo { get; set; }
        [Required]
        [Display(Name = "Client Name")]
        public long VenderID { get; set; }
        [Required]
        [Display(Name = "Project Name")]
        public long ProjectID { get; set; }
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
        public string ReceivedRemarks { get; set; }//Advance or Deduction Remarks
        public decimal AdvanceReceived { get; set; }//Advance or Deduction Amount
        [Required]
        public decimal BalanceAmount { get; set; }
        [Required]
        public string Remarks { get; set; }
        public bool IsCancelled { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblPaymentDetail
    {
        [Key]
        public string  PaymentID { get; set; }
        [Required]
        [Display(Name = "Expenses Type")]
        public long ExpenseTypeID { get; set; }
        [Required]
        [Display(Name="Date")]
        public DateTime PaymentDate { get; set; }
        [Required]
        [Display(Name = "Amount")]
        public decimal PaymentAmt { get; set; }
        [Required]
        [Display(Name = "Payment Mode")]
        public string PaymentMode  { get; set; }
        [Display(Name = "Bank Name")]
        public long? BankID { get; set; }
        [Display(Name = "Cheque/Transaction No.")]
        public string ChequeTransNo { get; set; }
        public string PaymentFile { get; set; }
        [Display(Name = "Project Name")]
        public long? ProjectID { get; set; }
        [Display(Name = "Client/Vendor Name")]
        public long? VendorID { get; set; }
        public string PaymentType { get; set; }
        [Required]
        [Display(Name = "Remarks")]
        public string Remarks { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblPaymentReleasedTran
    {
        [Key]
        public long PaymentID { get; set; }
        [Required(ErrorMessage = "Select Payment Date")]
        public DateTime PaymentDate { get; set; }
        [Required(ErrorMessage = "Enter payment Amount")]
        public decimal PaymentAmt { get; set; }
        [Required(ErrorMessage = "Select Payment Mode ")]
        public string PaymentMode { get; set; }
        public string PurchaseInvoiceID { get; set; }
        public long? DirectPaymentID { get; set; }
        public long? BankID { get; set; }
        public string PaymentTransNo { get; set; }
        public string UploadedFile { get; set; }
        [Required(ErrorMessage = "Enter Remarks")]
        public string Remarks { get; set; }
        public string AddedBy { get; set; }
        public DateTime AddedOn { get; set; }
    }
}

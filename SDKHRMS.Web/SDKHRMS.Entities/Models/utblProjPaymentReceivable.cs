using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblProjPaymentReceivable
    {
        [Key]
        public long ProjPaymentReceiveID { get; set; }
        [Required(ErrorMessage ="Select Project Name")]
        public long ProjectID { get; set; }
        public long? BankID { get; set; }
        [Required(ErrorMessage = "Select Date")]
        public DateTime ReceivedDate { get; set; }
        [Required(ErrorMessage = "Select Payment Receive Mode")]
        public string ReceivedMode { get; set; }
        [Required(ErrorMessage = "Enter Remarks")]
        public string Remarks { get; set; }
        public decimal NetAmtReceived { get; set; }
        public decimal TDSDeductionAmt { get; set; }
        public decimal GstDeductionAmt { get; set; }
        public decimal SecurityDepositAmt { get; set; }
        public decimal OtherDeductionAmt { get; set; }
        public bool IsAdvance { get; set; }
        public string UploadedFile { get; set; }
        public string SaleInvoiceID { get; set; }
    }
}

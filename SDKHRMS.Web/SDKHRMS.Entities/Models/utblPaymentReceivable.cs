using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblPaymentReceivable
    {
        [Key]
        public long ReceivedID { get; set; }
        [Required(ErrorMessage = "Select Expense Head")]
        public long ExpenseTypeID { get; set; }
        [Required(ErrorMessage = "Enter Receive Amount")]
        public decimal AmtReceived { get; set; }
        [Required(ErrorMessage = "Payment Receive Date")]
        public DateTime ReceivedDate { get; set; }
        [Required(ErrorMessage = "Select Received Mode")]
        [Display(Name = "Received Mode")]
        public string ReceivedMode { get; set; }
        public long? BankID { get; set; }
        public string TransactionNo { get; set; }
        [Required(ErrorMessage = "Enter Remarks")]
        public string Remarks { get; set; }
        public string UploadedFile { get; set; }
        public string AddedBy { get; set; }
        public DateTime AddedOn { get; set; }
    }
}

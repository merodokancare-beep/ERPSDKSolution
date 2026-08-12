using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblDirectPayment
    {
        [Key]
        public long DirectPaymentID { get; set; }
        [Required(ErrorMessage = "Select Expense Head")]
        public long ExpenseTypeID { get; set; }
        public long? ProjectID { get; set; }
        [Required(ErrorMessage = "Payment Date")]
        public DateTime PaymentDate { get; set; }
        [Required(ErrorMessage = "Payment Amount")]
        public decimal PaymentAmt { get; set; }
        public bool IsDeclined { get; set; }
        [Required(ErrorMessage = "Enter Purpose")]
        public string Purpose { get; set; }
        [Required(ErrorMessage = "Enter Remarks")]
        public string Remarks { get; set; }
        public string Status { get; set; }
        public string AddedBy { get; set; }
        public DateTime AddedOn { get; set; }
    }
}

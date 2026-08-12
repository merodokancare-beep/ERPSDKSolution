using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblPettyCash
    {
        [Key]
        public long PettyCashID { get; set; }
        [Required (ErrorMessage ="Select Date")]
        public DateTime TransDate { get; set; }
        //[Required(ErrorMessage = "Select Expense Head ")]
        public long ExpenseTypeID { get; set; }
        public long? ReceivedID { get; set; }
        public long? BankID { get; set; }
        [Required(ErrorMessage = "Enter the Received Amount ")]
        public decimal? CreditAmt { get; set; }
        public decimal? DebitAmt { get; set; }
        [Required(ErrorMessage = "Enter Remarks ")]
        public string Remarks { get; set; }
        public bool IsClosed { get; set; }
        public string FilePath { get; set; }
    }
}

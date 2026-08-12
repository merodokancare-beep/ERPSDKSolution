using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblMstExpenseType
    {
        [Key]
        public long ExpenseTypeID{ get; set; }
        [Required]
        [DisplayName("Expense Name")]
        public string ExpenseType { get; set; }
        [Required]
        public string Description { get; set; }
        public bool IsProjectRelated { get; set; }
        public bool CanReceiveDirectPayment { get; set; }
        public decimal? OpeningAmount { get; set; }
        public DateTime? OpeningDate { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

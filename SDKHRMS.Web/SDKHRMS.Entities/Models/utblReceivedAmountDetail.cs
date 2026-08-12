using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblReceivedAmountDetail
    {
        [Key]
        public string RecvDtlsID { get; set; }
        public string ReceivedID { get; set; }
        [Required]
        [Display(Name = "Reference No")]
        public string ReferenceNo { get; set; }
        [Required]
        [Display(Name = "Received Amount")]
        public decimal ReceivedAmount { get; set; }
        
    }
}

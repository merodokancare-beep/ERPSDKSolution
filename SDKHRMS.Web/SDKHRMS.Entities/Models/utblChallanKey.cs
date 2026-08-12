using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblChallanKey
    {
        [Key]
        public string ChallanID { get; set; }
        [Required(ErrorMessage = "Select Client")]
        public long VenderID { get; set; }
        public long? ProjectID { get; set; }
        public string CHRefNo { get; set; }
        [Required(ErrorMessage = "Select Date")]
        public DateTime CHDate { get; set; }
        [Required(ErrorMessage = "Enter Consignee To")]
        public string CHToName { get; set; }
        [Required(ErrorMessage = "Enter Consignee Address")]
        public string ClientAddress { get; set; }
        [Required(ErrorMessage = "Enter Remarks")]
        public string Remarks { get; set; }
        public int SlNo { get; set; }
        public string FiscalYear { get; set; }
        public bool IsCancel { get; set; }
        public string AddedBy { get; set; }
        public DateTime AddedOn { get; set; }

    }
}

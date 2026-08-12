using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblChallanItem
    {
        [Key]
        public string CHItemID { get; set; }
        public string ChallanID { get; set; }
        [Required]
        [Display(Name = "Item Name")]
        public string ItemName { get; set; }
        [Required]
        [Display(Name = "Qty")]
        public int Quantity { get; set; }
        [Required]
        [Display(Name = "Unit Name")]
        public long UnitID { get; set; }
        public int? SlNo { get; set; }
    }
}

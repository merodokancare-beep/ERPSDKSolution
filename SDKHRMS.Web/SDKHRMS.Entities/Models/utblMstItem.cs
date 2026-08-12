using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblMstItem
    {
        [Key]
        public long ItemID { get; set; }
        [Required]
        [Display(Name = "Item Name")]
        public string ItemName { get; set; }
        [Required]
        [Display(Name = "HSN/SAC Code")]
        public string ItemHSNCode { get; set; }
        [Display(Name = "GST %")]
        public int GSTPercentage { get; set; }
        [Display(Name = "Description")]
        public string ItemDescription { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

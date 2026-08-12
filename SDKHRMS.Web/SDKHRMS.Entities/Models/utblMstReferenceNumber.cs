using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblMstReferenceNumber
    {
        [Key]
        public int RefID { get; set; }
        [Required]
        [Display(Name = "Financial Symbol")]
        public string FiscalYearSymbol { get; set; }
        [Required]
        [Display(Name = "Prefix")]
        public string Prefix { get; set; }
        [Required]
        [Display(Name = "Suffix")]
        public string Suffix { get; set; }
        [Required]
        [Display(Name = "Start No.")]
        public int StartNo { get; set; }
        [Required]
        [Display(Name = "Current No.")]
        public int CurrentNo { get; set; }
    }
}

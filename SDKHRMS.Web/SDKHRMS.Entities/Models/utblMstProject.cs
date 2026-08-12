using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblMstProject
    {
        [Key]
        public long ProjectID { get; set; }
        [Required]
        [Display(Name = "Project Name")]
        public string ProjectName { get; set; }
        [Required]
        [Display(Name = "Client/Vendor")]
        public long VendorID { get; set; }
        [Required]
        [Display(Name = "Start Date")]
        public DateTime ProjStartDate { get; set; }
        [Display(Name = "End Date")]
        public DateTime? ProjEndDate { get; set; }
        [Display(Name = "Project Status")]
        public string ProjStatus { get; set; }
        [Required]
        [Display(Name = "Project Cost")]
        public decimal ProjValue { get; set; }
        [Required]
        [Display(Name = "Project Description")]
        public string ProjDescription { get; set; }
        [Display(Name = "Work Order Date")]
        public DateTime? WODate { get; set; }
         [Display(Name = "Work Order No.")]
        public string WONo { get; set; }
         [Display(Name = "Upload Work Order")]
        public string WOPath { get; set; }
        [Display(Name = "Upload Completion certificate")]
        public string PCCPath { get; set; }
    }
}

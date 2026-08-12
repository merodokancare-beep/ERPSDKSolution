using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblReferenceDetail
    {
        [Key]
        public long ReferenceID { get; set; }

        [Required]
        [DisplayName("Date")]
        public DateTime RefDate { get; set; }

        [Required]
        [DisplayName("Reference Type")]
        public string RefType { get; set; }

        [Required]
        [DisplayName("Remarks")]
        public string DescORSubject { get; set; }

        [DisplayName("Ref Number")]
        public string RefNumber { get; set; }
        [Required]
        [DisplayName("Letter To")]
        public string LetterTO { get; set; }
        [Required]
        [DisplayName("Client/Vendor Name")]
        public long VendorID { get; set; }
        [DisplayName("Fincial Year")]
        public string FiscalYear { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

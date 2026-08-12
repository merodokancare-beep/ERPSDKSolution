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
    public class utblMstVendorDetail
    {
        [Key]
        public long VenderID { get; set; }
        [Required]
        [DisplayName("Client/Vendor Name")]
        [StringLength(100)]
        public string VenderName { get; set; }
        [Required]
        [DisplayName("Client/Vendor Address")]
        public string VenderAddress { get; set; }
        [DisplayName("GST No.")]
        public string GSTNo { get; set; }
        [DisplayName("Contact Name")]
        public string ContactName { get; set; }
        [DisplayName("Contact No.")]
        public string ContactNo { get; set; }
        [DisplayName("Email ID.")]
        [RegularExpression("^[a-z0-9_\\+-]+(\\.[a-z0-9_\\+-]+)*@[a-z0-9-]+(\\.[a-z0-9]+)*\\.([a-z]{2,4})$", ErrorMessage = "Please enter correct email address")]
        public string Email { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
       
    }
}

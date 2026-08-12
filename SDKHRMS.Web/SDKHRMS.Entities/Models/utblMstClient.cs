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
    public class utblMstClient
    {
        [Key]
        public long ClientID { get; set; }
        [Required]
        [DisplayName("Client Name")]
        [StringLength(100)]
        public string ClientName { get; set; }
        [Required]
        [DisplayName("Client Address")]
        public string ClientAddress { get; set; }
        [Required]
        [DisplayName("GST No.")]
        public string GSTNo { get; set; }
        [DisplayName("Contact No.")]
        public string ContactNo { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

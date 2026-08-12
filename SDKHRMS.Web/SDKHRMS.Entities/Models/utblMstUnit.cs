using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblMstUnit
    {
        [Key]
        public long UnitID { get; set; }
        [Required]
        [StringLength(100,ErrorMessage = "Unit Name not more than 100 Char")]
        public string UnitName { get; set; }
        [Required]
        public string UnitDescription { get; set; }
    }
}

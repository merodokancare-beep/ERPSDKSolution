using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.Models
{
    public class utblMstBank
    {
        [Key]
        public long BankID { get; set; }
        public string BankName { get; set; }
    }
}

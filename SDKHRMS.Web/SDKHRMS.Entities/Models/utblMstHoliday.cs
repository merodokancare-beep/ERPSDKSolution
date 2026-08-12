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
    public class utblMstHoliday
    {
        [Key]
        public string HolidayID { get; set; }

        [Required(ErrorMessage = "Holiday name is required...")]
        [DisplayName("Holiday Name")]
        public string HolidayName { get; set; }
        [DisplayName("Holiday Desc.")]
        public string HolidayDesc { get; set; }
        [Required(ErrorMessage = "Date From is required...")]
        [DisplayName("Date From")]
        public DateTime DateFrom { get; set; }
        [Required(ErrorMessage = "Date To is required...")]
        [DisplayName("Date To")]
        public DateTime DateTo { get; set; }
        public int NoofDays { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}

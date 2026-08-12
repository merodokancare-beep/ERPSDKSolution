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
    public class utblEmpPersonalInfoKey
    {
        [Key]
        public string EmployeeID { get; set; }
        [Required(ErrorMessage = "First name is required...")]
        [DisplayName("First Name")]
        public string FName { get; set; }
        public string MName { get; set; }
        [Required(ErrorMessage = "Last name is required...")]
        [DisplayName("First Name")]
        public string LName { get; set; }
        [Required(ErrorMessage = "DOB is required...")]
        [DisplayName("Date Of Birth")]
        public DateTime DateOfBirth { get; set; }
        [Required(ErrorMessage = "Gender is required...")]
        [DisplayName("Gender")]
        public string Gender { get; set; }
        [Required(ErrorMessage = "Nationality is a required field")]
        [DisplayName("Nationality")]
        public string Nationality { get; set; }
        [Required(ErrorMessage = "Maritial Status is a required field")]
        [DisplayName("Maritial Status")]
        public string MaritalStatus { get; set; }
        [Required(ErrorMessage = "Religion is a required field")]
        [DisplayName("Religion")]
        public string Religion { get; set; }
        [Required(ErrorMessage = "BloodGroup is a required field")]
        [DisplayName("Blood Group")]
        public string BloodGroup { get; set; }
        [Required(ErrorMessage = "Phone Number is a required field")]
        [DisplayName("Phone No.")]
        public string PhoneNumber { get; set; }
        [Required(ErrorMessage = "Email is a required field")]
        [DisplayName("Email ID")]
        [EmailAddress]
        public string Email { get; set; }
        [DisplayName("Pan Card No.")]
        public string PanNo { get; set; }
        [DisplayName("Aadhar No.")]
        public string AadharNo { get; set; }
        [Required(ErrorMessage = "Present Address is a required field")]
        [DisplayName("Present Address")]
        public string PresentAddress { get; set; }
        [DisplayName("Emg Contact Name")]
        public string EmgContactName { get; set; }
        [DisplayName("Emg Contact No.")]
        public string EmgContactNo { get; set; }
        [DisplayName("Emg Contact Address")]
        public string EmgContactAddress { get; set; }
        public string PhotoNormal { get; set; }
        public string PhotoThumb { get; set; }
        public string UserID { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }


    public class EmpList
    {
        public string EmployeeID { get; set; }
        public string PhotoThumb { get; set; }
        public string EmpName { get; set; }
        public string Gender { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public bool IsActive { get; set; }
        public string RoleName { get; set; }
        public string UserID { get; set; }
    }

}

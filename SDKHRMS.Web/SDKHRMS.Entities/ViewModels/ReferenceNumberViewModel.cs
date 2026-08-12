using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SDKHRMS.Entities.ViewModels
{
    public class ReferenceNumberViewModel
    {
        public utblReferenceDetail ReferenceDetails { get; set; }
        public List<utblReferenceDetail> ReferenceDetailsList { get; set; }
        //public List<DepartmentDD> DepartmentDDList { get; set; }
        public List<VendorDDList> VendorDDList { get; set; }
        public List<FiscalYearDD> FiscalYearDDList { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        public List<ReferenceModel> ReferenceModelList { get; set; }
        public List<utblOfficalLetterDoc> OfficalLetterDocList { get; set; }
    }
    public class OfficalLetterVM
    {
        public utblReferenceDetail ReferenceDetails { get; set; }
        public utblOfficalLetterDoc OfficalLetterAdd { get; set; }
        public HttpPostedFileBase UploadFile { get; set; }
        public long RefNoID { get; set; }

    }
    public class utblOfficalLetterDoc
    {
        [Key]
        public long DocID { get; set; }
        [Required]
        public string DocName { get; set; }
        public long ReferenceID { get; set; }
        public string DocPath { get; set; }

    }
}
public class DepartmentDD
{
    public long DepartmentID { get; set; }
    public string DepartmentName { get; set; }
}
public class FiscalYearDD
{
    public string FiscalYear { get; set; }
}
public class ReferenceModel
{
    public long ReferenceID { get; set; }
    public DateTime RefDate { get; set; }
    public string RefType { get; set; }
    public string DescORSubject { get; set; }
    public string RefNumber { get; set; }
    public string LetterTO { get; set; }
    public string ClientName { get; set; }
    public string FiscalYear { get; set; }
    public string IsCancelled { get; set; }
}

using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.ViewModels
{
    public class ChallanAdd
    {
        public utblChallanKey ChallanKeyModel { get; set; }
        public List<utblChallanItem> ChallanItemList { get; set; }
        public IEnumerable<VendorDDList> ClientDDList { get; set; }
        public IEnumerable<ProjectDD> ProjectDDList { get; set; }
        public IEnumerable<UnitDD> UnitDDList { get; set; }

    }
    public class DeliveryChallanViewModel
    {
        public ChallanKeyView ChallanDetailsKey { get; set; }
        public IEnumerable<ChallanItemView> ChallanItemList { get; set; }
    }
    public class DeliveryChallanVM
    {
        public IEnumerable<ChallanKeyView> ChallanKeyList { get; set; }
        public IEnumerable<VendorDDList> ClientDDList { get; set; }
        public IEnumerable<string> FiscalYear { get; set; }
        public PagingInfo PagingInfo { get; set; }
        public int TotalRecords { get; set; }
        //public PageParameters PageParameter { get; set; }

    }
    public class ChallanSave
    {
        public utblChallanKey ChallanKeyModel { get; set; }
        public IEnumerable<utblChallanItem> ChallanItemList { get; set; }
    }
    public class UnitDD
    {
        public long UnitID { get; set; }
        public string UnitName { get; set; }
    }
    public class ChallanKeyView
    {
        public string ChallanID { get; set; }
        public long VenderID { get; set; }
        public string VendorName { get; set; }
        public long? ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string CHRefNo { get; set; }
        public DateTime CHDate { get; set; }
        public string CHToName { get; set; }
        public string ClientAddress { get; set; }
        public string Remarks { get; set; }
        public int SlNo { get; set; }
        public string FiscalYear { get; set; }
        public bool IsCancel { get; set; }
        public string AddedBy { get; set; }
        public DateTime AddedOn { get; set; }

    }
    public class ChallanItemView
    {
        public string CHItemID { get; set; }
        public string ChallanID { get; set; }
        public string ItemName { get; set; }
        public int Quantity { get; set; }
        public long UnitID { get; set; }
        public string UnitName { get; set; }
        public int? SlNo { get; set; }
    }
}

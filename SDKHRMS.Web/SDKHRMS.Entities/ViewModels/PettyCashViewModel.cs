using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SDKHRMS.Entities.ViewModels
{
    public class PettyCashAdd
    {
        public IEnumerable<ExpenseTypeDD> ExpenseTypeDD { get; set; }
        public IEnumerable<utblMstBank> BankDD { get; set; }
        public utblPettyCash PettyCash { get; set; }
        //public PettyCashTotalTrans TotalTrans { get; set; }
        public string ExpHeadName { get; set; }
        public decimal AvailableBalance { get; set; }
        public long BankExpID { get; set; }//Select Bank Expance Head Name 
        public HttpPostedFileBase UploadFile { get; set; }
        public string PrevUploadedFile { get; set; }
    }
    public class PettyCashTotalTrans
    {
        public decimal TotalReceived { get; set; }
        public decimal TotalPayment { get; set; }
        public decimal CurrentBal { get; set; }
    }
    public class PettyCashVM 
    {
        public IEnumerable<PrettyCashBook> PrettyCashBook { get; set; }
        public PettyCashTotalTrans TotalTrans { get; set; }
        public IEnumerable<YearDD> YearDD { get; set; }
        public decimal AvailableBalance { get; set; }
        public string MonthName { get; set; }

    }
    public class PrettyCashBook
    {
        public long PettyCashID { get; set; }
        public DateTime TransDate { get; set; }
        public string ExpenseType { get; set; }
        public decimal CreditAmt { get; set; }
        public decimal DebitAmt { get; set; }
        public string Remarks { get; set; }
        public bool IsClosed { get; set; }
    }
}

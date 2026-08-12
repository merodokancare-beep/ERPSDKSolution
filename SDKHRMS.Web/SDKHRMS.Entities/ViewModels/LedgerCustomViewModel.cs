using SDKHRMS.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.ViewModels
{
    public class VendorLedgerVM
    {
        public IEnumerable<LedgerDtlsView> LedgerViews { get; set; }
        public List<VendorDDList> VendorDDList { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }
    public class ExpensesLedgerVM
    {
        public IEnumerable<LedgerDtlsView> LedgerViews { get; set; }
        public IEnumerable<ExpenseTypeDD> ExpenseTypeDD { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }
    public class ProjectLedgerVM
    {
        public IEnumerable<LedgerDtlsView> LedgerViews { get; set; }
        public IEnumerable<ProjectDD> ProjectDD { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }
    public class BankLedgerVM
    {
        public IEnumerable<LedgerDtlsView> LedgerViews { get; set; }
        public IEnumerable<utblMstBank> BankDD { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }
    public class LedgerDtlsView
    {
        public DateTime? TransDate { get; set; }
        public string Remarks { get; set; }
        public decimal Debit { get; set; }
        public decimal Credit { get; set; }
        public decimal Balance { get; set; }
        public string TransType { get; set; }
        public string TransID { get; set; }
    }
}

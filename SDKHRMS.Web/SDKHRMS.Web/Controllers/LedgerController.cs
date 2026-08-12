using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SDKHRMS.Web.Controllers
{
    public class LedgerController : Controller
    {
        dalConfiguration dalconfig = new dalConfiguration();
        dalLedger dalproj = new dalLedger();
        // GET: Ledger
        public ActionResult VendorLedger(long Vendor = 0, DateTime? StartDate = null, DateTime? EndDate = null)
        {
            VendorLedgerVM model = new VendorLedgerVM();
            // Not Used StartDate.HasValue ? StartDate.Value.ToString("yyyy-MM-dd") : "", EndDate.HasValue ? EndDate.Value.ToString("yyyy-MM-dd") : ""
            model.LedgerViews = dalproj.GetVendorLedger(Vendor, StartDate, EndDate);
            ViewBag.Vendor = Vendor;
            model.StartDate = StartDate.HasValue ? StartDate.Value.ToString("dd MMM yyyy") : "--";
            model.EndDate = EndDate.HasValue ? EndDate.Value.ToString("dd MMM yyyy") : "--"; ;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvVendorLedger", model);
            }
            model.VendorDDList = dalconfig.GetVendorDDList();
            return View(model);
        }

        public ActionResult ExpensesLedger(long ExpHead = 0, DateTime? StartDate = null, DateTime? EndDate = null)
        {
            ExpensesLedgerVM model = new ExpensesLedgerVM();
            model.LedgerViews = dalproj.GetExpenseLedger(ExpHead, StartDate, EndDate);
            ViewBag.ExpHead = ExpHead;
            model.StartDate = StartDate.HasValue ? StartDate.Value.ToString("dd MMM yyyy") : "--";
            model.EndDate = EndDate.HasValue ? EndDate.Value.ToString("dd MMM yyyy") : "--"; ;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvExpenseLedger", model);
            }
            model.ExpenseTypeDD = dalconfig.GetExpenseTypeDD(); 
            return View(model);
        }

        public ActionResult ProjectLedger(long ProjID = 0, DateTime? StartDate = null, DateTime? EndDate = null)
        {
            ProjectLedgerVM model = new ProjectLedgerVM();
            model.LedgerViews = dalproj.GetProjectLedger(ProjID, StartDate, EndDate);
            ViewBag.ProjID = ProjID;
            model.StartDate = StartDate.HasValue ? StartDate.Value.ToString("dd MMM yyyy") : "--";
            model.EndDate = EndDate.HasValue ? EndDate.Value.ToString("dd MMM yyyy") : "--"; ;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvProjectLedger", model);
            }
            model.ProjectDD = dalconfig.GetProjectDDList();
            return View(model);
        }
        public ActionResult BankLedger(long BankID = 0, DateTime? StartDate = null, DateTime? EndDate = null)
        {
            BankLedgerVM model = new BankLedgerVM();
            model.LedgerViews = dalproj.GetBankLedger(BankID, StartDate, EndDate);
            ViewBag.ProjID = BankID;
            model.StartDate = StartDate.HasValue ? StartDate.Value.ToString("dd MMM yyyy") : "--";
            model.EndDate = EndDate.HasValue ? EndDate.Value.ToString("dd MMM yyyy") : "--"; ;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvBankLedger", model);
            }
            model.BankDD = dalconfig.GetBankDD();
            return View(model);
        }
    }
}
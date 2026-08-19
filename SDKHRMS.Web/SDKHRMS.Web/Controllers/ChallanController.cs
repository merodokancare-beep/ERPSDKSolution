using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.HtmlHelpers;
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;

namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin,Employee,Accountant")]
    public class ChallanController : Controller
    {
        // GET: Challan
        dalConfiguration dalConfig = new dalConfiguration();
        dalInvoice dalinv = new dalInvoice();
        dalChallan dalch = new dalChallan();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult DeliveryChallanList(int PageNo = 1, int PageSize = 20, string FiscalYear = "", long Client = 0, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/Challan/DeliveryChallanList";
            DeliveryChallanVM model = new DeliveryChallanVM();
            ViewBag.SearchTerm = SearchTerm;
            ViewBag.FiscalYear = FiscalYear;
            ViewBag.Client = Client;
            model = dalch.GetDeliveryChallanList(PageNo, PageSize, SearchTerm, FiscalYear, Client);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            model.FiscalYear = dalch.GetCHFiscalYearDD();
            model.ClientDDList = dalinv.GetVendorDDList();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvDeliveryChallanList", model);
            }
            return View(model);
        }
        public ActionResult DeliveryChallan()
        {
            ViewBag.ActiveURL = "/Challan/DeliveryChallanList";
            ChallanAdd model = new ChallanAdd();
            model.ClientDDList = dalinv.GetVendorDDList();
            model.ProjectDDList = dalConfig.GetProjectDDList();
            model.UnitDDList = dalch.UnitDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeliveryChallan(ChallanAdd model)
        {
            ViewBag.ActiveURL = "/Challan/DeliveryChallanList";
            if (ModelState.IsValid)
            {
                model.ChallanKeyModel.AddedBy = User.Identity.Name;
                ChallanSave _model = new ChallanSave();
                _model.ChallanKeyModel = model.ChallanKeyModel;
                _model.ChallanItemList = model.ChallanItemList;
                string result = dalch.SaveDeliveryChallan(_model);
                TempData["ErrMsg"] = result;
                if (result.Contains("Success"))
                {
                    return RedirectToAction("DeliveryChallanList");
                }
            }
            model.ClientDDList = dalinv.GetVendorDDList();
            model.ProjectDDList = dalConfig.GetProjectDDList();
            model.UnitDDList = dalch.UnitDDList();
            return View(model);
        }
        public ActionResult EditDeliveryChallan(string id)
        {
            ViewBag.ActiveURL = "/Challan/DeliveryChallanList";
            ChallanAdd model = new ChallanAdd();
            model.ClientDDList = dalinv.GetVendorDDList();
            model.ProjectDDList = dalConfig.GetProjectDDList();
            model.UnitDDList = dalch.UnitDDList();
            model.ChallanKeyModel = dalch.GetChallanDetailsByID(id);
            model.ChallanItemList = dalch.GetChallanItemListByID(id);
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditDeliveryChallan(ChallanAdd model)
        {
            ViewBag.ActiveURL = "/Challan/DeliveryChallanList";
            if (ModelState.IsValid)
            {
                model.ChallanKeyModel.AddedBy = User.Identity.Name;
                ChallanSave _model = new ChallanSave();
                _model.ChallanKeyModel = model.ChallanKeyModel;
                _model.ChallanItemList = model.ChallanItemList;
                string result = dalch.SaveDeliveryChallan(_model);
                TempData["ErrMsg"] = result;
                if (result.Contains("Success"))
                {
                    return RedirectToAction("DeliveryChallanList");
                }
            }
            model.ClientDDList = dalinv.GetVendorDDList();
            model.ProjectDDList = dalConfig.GetProjectDDList();
            model.UnitDDList = dalch.UnitDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CancelledChallan(string id)
        {
            string result = dalch.CancelledPO(id);
            TempData["ErrMsg"] = result;
            return RedirectToAction("DeliveryChallanList");
        }
        [HttpGet]
        public JsonResult GetUnitDDList(DateTime? Datevalue)
        {
            List<UnitDD> model = new List<UnitDD>();
            model = dalch.UnitDDList();
            return Json(model, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ViewDeliveryChallan(string ID)
        {
            ViewBag.ActiveURL = "/Challan/DeliveryChallanList";
            ChallanKeyView model = new ChallanKeyView();
            ViewBag.ChallanID = ID;
            model = dalch.GetDeliveryChallanDtlsByID(ID);
            return View(model);
        }
        public ActionResult ChallanItemListByID(string id)
        {
            List<ChallanItemView> model = new List<ChallanItemView>();
            model = dalch.GetChallanItemList(id);
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvChallanItemList", model);
            }
            return View(model);
        }
        public ActionResult PrintDeliveryChallan(string ID)
        {
            DeliveryChallanViewModel model = new DeliveryChallanViewModel();
            model.ChallanDetailsKey = dalch.GetDeliveryChallanDtlsByID(ID);
            model.ChallanItemList = dalch.GetChallanItemList(ID);
            return new Rotativa.PartialViewAsPdf("_pvPrintDeliveryChallan", model)
            {
                ViewData = ViewData,
                FileName = "Delivery_Challan" + model.ChallanDetailsKey.CHRefNo + ".pdf",
                PageMargins = new Rotativa.Options.Margins(5, 5, 10, 5),
                PageSize = Rotativa.Options.Size.A4
            };
        }
    }
}
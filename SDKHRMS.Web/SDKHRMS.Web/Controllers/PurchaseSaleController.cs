using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.Models;
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
    public class PurchaseSaleController : Controller
    {

        PurchaseSalesViewModel objmodel = new PurchaseSalesViewModel();
        dalConfiguration dalconf = new dalConfiguration();
        dalPurchaseSale dalPursale = new dalPurchaseSale();
        // GET: /PurchaseSale/
        #region Purchase
        [HttpGet]
        public ActionResult PurchaseList(int PageNo = 1, int PageSize = 20, string SearchTerm = "", String Type = "Purchase")
        {
            ViewBag.ActiveURL = "/PurchaseSale/PurchaseList";
            ViewBag.Type = Type;
            objmodel = dalPursale.GetPurchaseSaleList(PageNo, PageSize, SearchTerm,Type);
            objmodel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objmodel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPurchaseSaleList", objmodel);
            }
            return View(objmodel);
        }
        [HttpGet]
        public ActionResult AddPurchase(long ID=0)
        {
            ViewBag.ActiveURL = "/PurchaseSale/PurchaseList";
            ViewBag.PurchaseID = ID;
            objmodel.VendorDDList = dalPursale.GetVendorDDList();
            if(ID!=0)
            {
                objmodel.utblPurchaseSale = dalPursale.GetPurchaseSaleByID(ID);
            }
            return View(objmodel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddPurchase(PurchaseSalesViewModel ItemData)
        {
            ViewBag.IsIGST = ItemData.utblPurchaseSale.IsIGST;
            ViewBag.ActiveURL = "/PurchaseSale/PurchaseList";
            objmodel.VendorDDList = dalPursale.GetVendorDDList();
            //objmodel.ClientDDList = dalPursale.GetClientDDList();
            if (ItemData.utblPurchaseSale.IsIGST == true)
            {
                ItemData.utblPurchaseSale.CGST = 0;
                ItemData.utblPurchaseSale.SGST = 0;
            }
            else
            {
                ItemData.utblPurchaseSale.IGST = 0;
            }
            if (ItemData.utblPurchaseSale.VenderID == null)
            {
                TempData["ErrMsg"] = "Please select Vendor Name";
            }
            else
            {
                ItemData.utblPurchaseSale.PurchaseSaleType = "Purchase";
                if (ModelState.IsValid)
                {
                    ItemData.utblPurchaseSale.UserID = User.Identity.Name;
                    TempData["ErrMsg"] = dalPursale.SavePurchaseSale(ItemData.utblPurchaseSale);
                    if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                    {
                        return RedirectToAction("PurchaseList");
                    }
                }
            }
            return View(objmodel);
        }
        #endregion
        

        #region Sale Details
        [HttpGet]
        public ActionResult SaleList(int PageNo = 1, int PageSize = 20, string SearchTerm = "", String Type = "Sale")
        {
            ViewBag.ActiveURL = "/PurchaseSale/SaleList";
            ViewBag.Type = Type;
            objmodel = dalPursale.GetPurchaseSaleList(PageNo, PageSize, SearchTerm, Type);
            objmodel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objmodel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPurchaseSaleList", objmodel);
            }
            return View(objmodel);
        }
        [HttpGet]
        public ActionResult AddSale(long ID = 0)
        {
            ViewBag.ActiveURL = "/PurchaseSale/SaleList";
            ViewBag.PurchaseID = ID;
            //objmodel.VendorDDList = dalPursale.GetVendorDDList();
            objmodel.ClientDDList = dalPursale.GetClientDDList();
            if (ID != 0)
            {
                objmodel.utblPurchaseSale = dalPursale.GetPurchaseSaleByID(ID);
            }
            return View(objmodel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddSale(PurchaseSalesViewModel ItemData)
        {
            ViewBag.IsIGST = ItemData.utblPurchaseSale.IsIGST;
            ViewBag.ActiveURL = "/PurchaseSale/SaleList";
            //objmodel.VendorDDList = dalPursale.GetVendorDDList();
            objmodel.ClientDDList = dalPursale.GetClientDDList();
            if (ItemData.utblPurchaseSale.IsIGST == true)
            {
                ItemData.utblPurchaseSale.CGST = 0;
                ItemData.utblPurchaseSale.SGST = 0;
            }
            else
            {
                ItemData.utblPurchaseSale.IGST = 0;
            }
            if (ItemData.utblPurchaseSale.ClientID == null)
            {
                TempData["ErrMsg"] = "Please select Client Name";
            }
            else
            {
                ItemData.utblPurchaseSale.PurchaseSaleType = "Sale";
                if (ModelState.IsValid)
                {
                    ItemData.utblPurchaseSale.UserID = User.Identity.Name;
                    TempData["ErrMsg"] = dalPursale.SavePurchaseSale(ItemData.utblPurchaseSale);
                    if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                    {
                        return RedirectToAction("SaleList");
                    }
                }
            }
            return View(objmodel);
        }
        #endregion
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeletePurchaseSale(long ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "",string Type="")
        {
            TempData["ErrMsg"] = dalPursale.DeletePurchaseSale(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            if (Type == "Purchase")
            {
                return RedirectToAction("PurchaseList", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
            }
            else
            {
                return RedirectToAction("SaleList", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
            }
            
        }
        public ActionResult PurchaseSaleReport(int? Month, int? year)
        {
            ViewBag.ActiveURL = "/PurchaseSale/PurchaseSaleReport";
            int Mon = Month ?? DateTime.Now.Month;
            int Yr = year ?? DateTime.Now.Year;
            System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();
            string MonthName = mfi.GetMonthName(Mon).ToString();
            objmodel = dalPursale.GetPurchaseSaleReport(Mon, Yr);
            ViewBag.Year = Yr;
            ViewBag.Month = Mon;
            ViewBag.MonName = MonthName;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPurchaseSaleReport", objmodel);
            }
            return View(objmodel);
        }
        public ActionResult ExportAsPDF(int Month, int year)
        {
            System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();
            string MonthName = mfi.GetMonthName(Month).ToString();
            objmodel = dalPursale.GetPurchaseSaleReport(Month, year);
            ViewBag.MonthName = MonthName; ViewBag.Year = year;
            string filename = "Purchase & Sale Details of SDK Solutions For " + MonthName + "," + year + ".pdf";
            return new Rotativa.ViewAsPdf("ExportAsPDF", objmodel)
            {
                ViewData = ViewData,
                FileName = filename,
                PageOrientation = Rotativa.Options.Orientation.Landscape,
                PageSize = Rotativa.Options.Size.A4
            };
        }
    }

}
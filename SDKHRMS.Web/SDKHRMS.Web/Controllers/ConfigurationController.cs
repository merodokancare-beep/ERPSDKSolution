using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.Models;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.HtmlHelpers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;

namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin,Accountant")]
    public class ConfigurationController : Controller
    {
        MstConfigurationViewModel objConfigModel = new MstConfigurationViewModel();
        dalConfiguration objDalConfig = new dalConfiguration();
        // GET: Configuration
        #region Client/Vendor Master

        public ActionResult VendorList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Vendorlist";
            VendorClientVM model = new VendorClientVM();
            model = objDalConfig.getVendorList(PageNo, PageSize, SearchTerm);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvVendorList", model);
            }
            return View(model);
        }

        public ActionResult AddVendor()
        {
            ViewBag.ActiveURL = "/configuration/Vendorlist";
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddVendor(VendorClientAdd ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Vendorlist";
            if (ModelState.IsValid)
            {
                ItemData.ClientVendorAdd.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveClientVendor(ItemData.ClientVendorAdd);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("VendorList");
                }
            }
            return View(ItemData);
        }

        public ActionResult EditVendor(long id, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Vendorlist";
            VendorClientAdd model = new VendorClientAdd();
            model.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            model.ClientVendorAdd = objDalConfig.GetVendorByID(id);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditVendor(VendorClientAdd ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Vendorlist";
            if (ModelState.IsValid)
            {
                ItemData.ClientVendorAdd.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveClientVendor(ItemData.ClientVendorAdd);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("VendorList", new { PageNo = ItemData.PageParameter.PageNo, PageSize = ItemData.PageParameter.PageSize, SearchTerm = ItemData.PageParameter.SearchTerm });
                }
            }
            return View(ItemData);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteVendor(long ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalConfig.DeleteVendor(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("Vendorlist", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        #endregion
        #region Project Master
        public ActionResult ProjectList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Projectlist";
            ViewBag.SearchTerm = SearchTerm;
            ProjectVM model = new ProjectVM();
            model = objDalConfig.getProjectList(PageNo, PageSize, SearchTerm);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objConfigModel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvProjectList", model);
            }
            return View(model);
        }
        public ActionResult AddProject()
        {
            ViewBag.ActiveURL = "/configuration/Projectlist";
            ProjectAdd model = new ProjectAdd();
            model.VendorDDList = objDalConfig.GetVendorDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddProject(ProjectAdd model)
        {
            ViewBag.ActiveURL = "/configuration/Projectlist";
            string WOFileStatus = "Failure";
            string PCCFileStatus = "Failure";
            if (model.WOFile != null)
            {
                WOFileStatus = CheckAndUpload(model.WOFile, "WorkOrder");
                if (!WOFileStatus.Contains("Failure"))
                {
                    model.ProjectModelAdd.WOPath = WOFileStatus;
                }
                else
                {
                    ModelState.AddModelError("ProjectModelAdd.WOPath", WOFileStatus);
                    //TempData["ErrMsg"] = "Error: File Could not be uploaded. please Check";
                    //return RedirectToAction("AddProject");
                }
            }
            if (model.PCCFile != null)
            {
                PCCFileStatus = CheckAndUpload(model.PCCFile, "CompletionCertificate");
                if (!PCCFileStatus.Contains("Failure"))
                {
                    model.ProjectModelAdd.PCCPath = PCCFileStatus;
                }
                else
                {
                    ModelState.AddModelError("ProjectModelAdd.PCCPath", PCCFileStatus);
                }
            }
            if (ModelState.IsValid)
            {
                string Result = objDalConfig.SaveProject(model.ProjectModelAdd);
                if (!(Result.Contains("Error")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("ProjectOverView", "Projects", new { Area = "" });
                }
            }
            model.VendorDDList = objDalConfig.GetVendorDDList();
            return View(model);
        }

        public ActionResult EditProject(long id, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Projectlist";
            ViewBag.ProjID = id;
            ProjectAdd model = new ProjectAdd();
            model.VendorDDList = objDalConfig.GetVendorDDList();
            model.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            model.ProjectModelAdd = objDalConfig.GetProjectByID(id);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProject(ProjectAdd model)
        {
            ViewBag.ActiveURL = "/configuration/Projectlist";
            string WOFileStatus = "Failure";
            string PCCFileStatus = "Failure";
            string PrevWO = "";
            string PrevPCC = "";
            if (model.WOFile != null)
            {
                WOFileStatus = CheckAndUpload(model.WOFile, "WorkOrder");
                if (!WOFileStatus.Contains("Failure"))
                {
                    PrevWO = model.ProjectModelAdd.WOPath;
                    model.ProjectModelAdd.WOPath = WOFileStatus;
                }
                else
                {
                    ModelState.AddModelError("ProjectModelAdd.WOPath", WOFileStatus);
                }
            }
            if (model.PCCFile != null)
            {
                PCCFileStatus = CheckAndUpload(model.PCCFile, "CompletionCertificate");
                if (!PCCFileStatus.Contains("Failure"))
                {
                    PrevPCC = model.ProjectModelAdd.PCCPath;
                    model.ProjectModelAdd.PCCPath = PCCFileStatus;
                }
                else
                {
                    ModelState.AddModelError("ProjectModelAdd.PCCPath", PCCFileStatus);
                }
            }
            if (ModelState.IsValid)
            {
                string Result = objDalConfig.SaveProject(model.ProjectModelAdd);
                if (!(Result.Contains("Error")))
                {
                    if (!string.IsNullOrEmpty(PrevWO))
                    {
                        var fullPath = string.Concat(Server.MapPath("~/UploadFile/WorkOrder/" + PrevWO));
                        if (System.IO.File.Exists(fullPath))
                        {
                            System.IO.File.Delete(fullPath);
                        }
                    }
                    if (!string.IsNullOrEmpty(PrevPCC))
                    {
                        var fullPath = string.Concat(Server.MapPath("~/UploadFile/CompletionCertificate/" + PrevPCC));
                        if (System.IO.File.Exists(fullPath))
                        {
                            System.IO.File.Delete(fullPath);
                        }
                    }
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("ProjectOverView", "Projects", new { Area = "", PageNo = model.PageParameter.PageNo, PageSize = model.PageParameter.PageSize });
                }
            }
            model.VendorDDList = objDalConfig.GetVendorDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteProject(long ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            ProjectAdd model = new ProjectAdd();
            model.ProjectModelAdd = objDalConfig.GetProjectByID(ID);
            string PrevWOPath = model.ProjectModelAdd.WOPath;
            string PrevPCCPath = model.ProjectModelAdd.PCCPath;
            TempData["ErrMsg"] = objDalConfig.DeleteProject(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                if (!string.IsNullOrEmpty(PrevWOPath))
                {
                    var fullPath = string.Concat(Server.MapPath("~/UploadFile/WorkOrder/" + PrevWOPath));
                    if (System.IO.File.Exists(fullPath))
                    {
                        System.IO.File.Delete(fullPath);
                    }
                }
                if (!string.IsNullOrEmpty(PrevPCCPath))
                {
                    var fullPath = string.Concat(Server.MapPath("~/UploadFile/CompletionCertificate/" + PrevPCCPath));
                    if (System.IO.File.Exists(fullPath))
                    {
                        System.IO.File.Delete(fullPath);
                    }
                }
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("ProjectOverView", "Projects", new { Area = "", PageNo = PageNo, PageSize = PageSize });
        }
        #endregion
        #region ExpenseType Master

        public ActionResult ExpenseTypeList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {

            ExpenseTypeViewModel model = new ExpenseTypeViewModel();
            ViewBag.ActiveURL = "/configuration/ExpenseTypelist";
            model = objDalConfig.getExpenseTypeList(PageNo, PageSize, SearchTerm);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objConfigModel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvExpenseTypeList", model);
            }
            return View(model);
        }

        public ActionResult AddExpenseType()
        {
            ViewBag.ActiveURL = "/configuration/ExpenseTypelist";
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddExpenseType(ExpenseTypeADD ItemData)
        {
            ViewBag.ActiveURL = "/configuration/ExpenseTypelist";
            if (ItemData.utblMstExpenseType.CanReceiveDirectPayment && !ItemData.utblMstExpenseType.OpeningAmount.HasValue)
            {
                ModelState.AddModelError("utblMstExpenseType.OpeningAmount", "Enter Opening Amount");
            }
            if (ItemData.utblMstExpenseType.CanReceiveDirectPayment && !ItemData.utblMstExpenseType.OpeningDate.HasValue)
            {
                ModelState.AddModelError("utblMstExpenseType.OpeningDate", "Enter Opening Date");
            }
            if (ModelState.IsValid)
            {
                ItemData.utblMstExpenseType.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveExpenseType(ItemData.utblMstExpenseType);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("ExpenseTypeList");
                }
            }
            return View(ItemData);
        }

        public ActionResult EditExpenseType(long id, int PageNo, int PageSize, string SearchTerm = "")
        {
            ExpenseTypeADD model = new ExpenseTypeADD();
            ViewBag.ActiveURL = "/configuration/ExpenseTypelist";
            model.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            model.utblMstExpenseType = objDalConfig.GetExpenseTypeByID(id);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditExpenseType(ExpenseTypeADD ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Locationlist";
            if (ItemData.utblMstExpenseType.CanReceiveDirectPayment && !ItemData.utblMstExpenseType.OpeningAmount.HasValue)
            {
                ModelState.AddModelError("utblMstExpenseType.OpeningAmount", "Enter Opening Amount");
            }
            if (ItemData.utblMstExpenseType.CanReceiveDirectPayment && !ItemData.utblMstExpenseType.OpeningDate.HasValue)
            {
                ModelState.AddModelError("utblMstExpenseType.OpeningDate", "Enter Opening Date");
            }
            if (ModelState.IsValid)
            {
                ItemData.utblMstExpenseType.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveExpenseType(ItemData.utblMstExpenseType);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("ExpenseTypeList", new { PageNo = ItemData.PageParameter.PageNo, PageSize = ItemData.PageParameter.PageSize, SearchTerm = ItemData.PageParameter.SearchTerm });
                }
            }
            return View(ItemData);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteExpenseType(long ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalConfig.DeleteExpenseType(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("ExpenseTypelist", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        #endregion

        #region Finance Year
        public ActionResult FinancialYearList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/FinancialYearlist";
            FinancialYearVM model = new FinancialYearVM();
            model = objDalConfig.getFinancialYearList(PageNo, PageSize, SearchTerm);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvFinancialYearList", model);
            }
            return View(model);
        }

        public ActionResult AddFinancialYear()
        {
            ViewBag.ActiveURL = "/configuration/FinancialYearlist";
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddFinancialYear(FinancialYearAdd model)
        {
            ViewBag.ActiveURL = "/configuration/FinancialYearlist";
            if (ModelState.IsValid)
            {
                TempData["ErrMsg"] = objDalConfig.SaveFinancialYear(model.FinancialYear);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("FinancialYearList");
                }
            }
            return View(model);
        }

        public ActionResult EditFinancialYear(int id, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/FinancialYearlist";
            FinancialYearAdd model = new FinancialYearAdd();
            model.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            model.FinancialYear = objDalConfig.GetFinancialYearByID(id);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditFinancialYear(FinancialYearAdd model)
        {
            ViewBag.ActiveURL = "/configuration/Locationlist";
            if (ModelState.IsValid)
            {
                TempData["ErrMsg"] = objDalConfig.SaveFinancialYear(model.FinancialYear);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("FinancialYearList", new { PageNo = model.PageParameter.PageNo, PageSize = model.PageParameter.PageSize, SearchTerm = model.PageParameter.SearchTerm });
                }
            }
            return View(model);
        }
        #endregion

        #region Master Reference Number
        public ActionResult MstReferenceNumberList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/MstReferenceNumberlist";
            ReferenceNoVM model = new ReferenceNoVM();
            model = objDalConfig.getMstReferenceNumberList(PageNo, PageSize, SearchTerm);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvMstReferenceNumberList", model);
            }
            return View(model);
        }

        public ActionResult AddMstReferenceNumber()
        {
            ViewBag.ActiveURL = "/configuration/MstReferenceNumberlist";
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddMstReferenceNumber(ReferenceNoAdd model)
        {
            ViewBag.ActiveURL = "/configuration/MstReferenceNumberlist";
            if (ModelState.IsValid)
            {
                TempData["ErrMsg"] = objDalConfig.SaveMstReferenceNumber(model.MstReferenceNumber);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("MstReferenceNumberList");
                }
            }
            return View(model);
        }

        public ActionResult EditMstReferenceNumber(int id, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/MstReferenceNumberlist";
            ReferenceNoAdd model = new ReferenceNoAdd();
            model.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            model.MstReferenceNumber = objDalConfig.GetMstReferenceNumberByID(id);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditMstReferenceNumber(ReferenceNoAdd model)
        {
            ViewBag.ActiveURL = "/configuration/Locationlist";
            if (ModelState.IsValid)
            {
                TempData["ErrMsg"] = objDalConfig.SaveMstReferenceNumber(model.MstReferenceNumber);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("MstReferenceNumberList", new { PageNo = model.PageParameter.PageNo, PageSize = model.PageParameter.PageSize, SearchTerm = model.PageParameter.SearchTerm });
                }
            }
            return View(model);
        }
        #endregion
        #region Holiday Master
        public ActionResult HolidayList(int PageNo = 1, int PageSize = 10, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Holidaylist";
            HolidayVM model = new HolidayVM();
            model = objDalConfig.getHolidayList(PageNo, PageSize, SearchTerm);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;

            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvHolidayList", model);
            }
            return View(model);
        }

        public ActionResult AddHoliday()
        {
            ViewBag.ActiveURL = "/configuration/Holidaylist";
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddHoliday(HolidayAdd ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Holidaylist";
            if (ItemData.utblMstHoliday.DateTo < ItemData.utblMstHoliday.DateFrom)
                ModelState.AddModelError("utblMstHoliday.DateFrom", "Date To Must be greater then Date From");
            if (ModelState.IsValid)
            {
                if (ItemData.utblMstHoliday.DateFrom > ItemData.utblMstHoliday.DateTo)
                {
                    TempData["ErrMsg"] = "Date From Not Greater than Date To!";
                    return View(ItemData);
                }
                else
                {
                    ItemData.utblMstHoliday.UserID = User.Identity.Name;
                    TempData["ErrMsg"] = objDalConfig.SaveHoliday(ItemData.utblMstHoliday);
                    if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                    {
                        return RedirectToAction("HolidayList");
                    }
                }

            }
            return View(ItemData);
        }

        public ActionResult EditHoliday(string id, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Holidaylist";
            HolidayAdd model = new HolidayAdd();
            model.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            model.utblMstHoliday = objDalConfig.GetHolidayByID(id);
            // objConfigModel.DistrictListDD = objDalConfig.GetDistrictDDListforUnit();
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditHoliday(HolidayAdd ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Holidaylist";
            if (ItemData.utblMstHoliday.DateTo < ItemData.utblMstHoliday.DateFrom)
                ModelState.AddModelError("utblMstHoliday.DateFrom", "Date To Must be greater then Date From");
            if (ModelState.IsValid)
            {
                ItemData.utblMstHoliday.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveHoliday(ItemData.utblMstHoliday);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("HolidayList", new { PageNo = ItemData.PageParameter.PageNo, PageSize = ItemData.PageParameter.PageSize, SearchTerm = ItemData.PageParameter.SearchTerm });
                }
            }
            return View(ItemData);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteHoliday(string ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalConfig.DeleteHoliday(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("Holidaylist", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        #endregion
        #region Unit Master
        public ActionResult UnitList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            UnitVM model = new UnitVM();
            ViewBag.ActiveURL = "/configuration/UnitList";
            model = objDalConfig.getUnitList(PageNo, PageSize, SearchTerm);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvUnitList", model);
            }
            return View(model);
        }
        public ActionResult AddUnit(long id = 0)
        {
            utblMstUnit model = new utblMstUnit();
            ViewBag.ActiveURL = "/configuration/UnitList";
            if (id != 0)
                model = objDalConfig.GetUnitByID(id);
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddUnit(utblMstUnit model)
        {
            ViewBag.ActiveURL = "/configuration/Itemlist";
            if (ModelState.IsValid)
            {
                TempData["ErrMsg"] = objDalConfig.SaveUnit(model);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("UnitList");
                }
            }
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteUnit(long id)
        {
            TempData["ErrMsg"] = objDalConfig.DeleteUnit(id);
            return RedirectToAction("Unitlist");
        }
        #endregion
        #region Client Master
        public ActionResult ClientList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Clientlist";
            objConfigModel = objDalConfig.getClientList(PageNo, PageSize, SearchTerm);
            objConfigModel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objConfigModel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;

            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvClientList", objConfigModel);
            }
            return View(objConfigModel);
        }
        public ActionResult AddClient()
        {
            ViewBag.ActiveURL = "/configuration/Clientlist";
            return View(objConfigModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddClient(MstConfigurationViewModel ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Clientlist";
            if (ModelState.IsValid)
            {
                ItemData.utblMstClient.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveClient(ItemData.utblMstClient);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("ClientList");
                }
            }
            return View(ItemData);
        }

        public ActionResult EditClient(long id, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Clientlist";
            objConfigModel.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            objConfigModel.utblMstClient = objDalConfig.GetClientByID(id);
            // objConfigModel.DistrictListDD = objDalConfig.GetDistrictDDListforUnit();
            return View(objConfigModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditClient(MstConfigurationViewModel ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Locationlist";
            if (ModelState.IsValid)
            {
                ItemData.utblMstClient.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveClient(ItemData.utblMstClient);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("ClientList", new { PageNo = ItemData.PageParameter.PageNo, PageSize = ItemData.PageParameter.PageSize, SearchTerm = ItemData.PageParameter.SearchTerm });
                }
            }
            return View(ItemData);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteClient(long ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalConfig.DeleteClient(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("Clientlist", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        #endregion

        #region Item Master
        public ActionResult ItemList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Itemlist";
            objConfigModel = objDalConfig.getItemList(PageNo, PageSize, SearchTerm);
            objConfigModel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objConfigModel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvItemList", objConfigModel);
            }
            return View(objConfigModel);
        }
        public ActionResult AddItem()
        {
            ViewBag.ActiveURL = "/configuration/Itemlist";
            return View(objConfigModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddItem(MstConfigurationViewModel ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Itemlist";
            if (ModelState.IsValid)
            {
                ItemData.utblMstItem.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveItem(ItemData.utblMstItem);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("ItemList");
                }
            }
            return View(ItemData);
        }
        public ActionResult EditItem(long id, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/configuration/Itemlist";
            objConfigModel.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            objConfigModel.utblMstItem = objDalConfig.GetItemByID(id);
            return View(objConfigModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditItem(MstConfigurationViewModel ItemData)
        {
            ViewBag.ActiveURL = "/configuration/Locationlist";
            if (ModelState.IsValid)
            {
                ItemData.utblMstItem.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveItem(ItemData.utblMstItem);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("ItemList", new { PageNo = ItemData.PageParameter.PageNo, PageSize = ItemData.PageParameter.PageSize, SearchTerm = ItemData.PageParameter.SearchTerm });
                }
            }
            return View(ItemData);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteItem(long ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalConfig.DeleteItem(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("Itemlist", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        #endregion
        public ActionResult EmpAttendanceMapping(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            dalEmpManage objDalEmp = new dalEmpManage();
            ViewBag.ActiveURL = "/configuration/EmpAttendanceMapping";
            objConfigModel = objDalConfig.getEmpAttMappList(PageNo, PageSize, SearchTerm);
            objConfigModel.EmpListForDD = objDalEmp.GetUnMappedEmpList();
            objConfigModel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objConfigModel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvEmpDeviceMapList", objConfigModel);
            }
            return View(objConfigModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EmpAttendanceMapping(MstConfigurationViewModel ItemData)
        {
            ViewBag.ActiveURL = "/configuration/EmpAttendanceMapping";
            if (ModelState.IsValid)
            {
                ItemData.utblEmpAttendanceMapping.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalConfig.SaveDeviceMapping(ItemData.utblEmpAttendanceMapping);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("EmpAttendanceMapping");
                }
            }
            return View(objConfigModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteEmpAttMap(long ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalConfig.DeleteAttendanceMapping(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("EmpAttendanceMapping", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        #region File
        private string CheckAndUpload(IFormFile httpPostedFileBase, string filetype)
        {
            var status = "Failure";
            if (httpPostedFileBase == null || httpPostedFileBase.Length == 0)
            {
                status = "Failure, Please Upload a file";
            }
            else if (httpPostedFileBase.Length > 0)
            {
                string fileName = httpPostedFileBase.FileName;
                string fileContentType = httpPostedFileBase.ContentType;
                byte[] tempFileBytes = new byte[httpPostedFileBase.Length];
                using (var stream = httpPostedFileBase.OpenReadStream())
                {
                    stream.Read(tempFileBytes, 0, Convert.ToInt32(httpPostedFileBase.Length));
                }
                var types = FileUploadCheck.FileType.Image;
                var result = FileUploadCheck.isValidFile(tempFileBytes, types, fileContentType);
                if (result == false)
                {
                    types = FileUploadCheck.FileType.PDF;
                    result = FileUploadCheck.isValidFile(tempFileBytes, types, fileContentType);
                }
                if (result == true)
                {
                    int FileLength = 1024 * 1024 * 2;
                    if (httpPostedFileBase.Length > FileLength)
                    {
                        status = "Failure, Maximum allowed size is: " + FileLength + " MB";
                    }
                    else
                    {
                        string file_result = SaveFile(httpPostedFileBase, filetype);
                        if (!file_result.Contains("Error"))
                        {
                            status = file_result;
                        }
                    }
                }
                else
                {
                    status = "Failure, Invalid File. Only .pdf,.jpg|jpeg,.png files allowed";
                }
            }
            else
            {
                status = "Failure, Content Length Error";
            }
            return status;
        }
        private string SaveFile(IFormFile file, string foldername)
        {
            try
            {
                Guid key = Guid.NewGuid();
                string name = key.ToString();
                string FileExtension = Path.GetExtension(file.FileName);
                string filename = name + FileExtension;
                //Check if directory exist
                if (!System.IO.Directory.Exists(Server.MapPath("~/UploadFile/" + foldername)))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("~/UploadFile/" + foldername)); //Create directory if it doesn't exist
                }
                var path = Path.Combine(Server.MapPath("~/UploadFile/" + foldername), filename);
                file.SaveAs(path);
                return filename;
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        public class FileUploadCheck
        {
            private enum ImageFileExtension
            {
                none = 0,
                jpg = 1,
                jpeg = 2,
                bmp = 3,
                gif = 4,
                png = 5
            }
            private enum PDFFileExtension
            {
                none = 0,
                PDF = 1
            }
            public enum FileType
            {
                Image = 1,
                Video = 2,
                PDF = 3,
                Text = 4,
                DOC = 5,
                DOCX = 6,
                PPT = 7,
            }
            public static bool isValidFile(byte[] bytFile, FileType flType, String FileContentType)
            {
                bool isvalid = false;
                if (flType == FileType.Image)
                {
                    isvalid = isValidImageFile(bytFile, FileContentType);//we are going call this method
                }
                else if (flType == FileType.PDF)
                {
                    isvalid = isValidPDFFile(bytFile, FileContentType);
                }
                return isvalid;
            }
            public static bool isValidPDFFile(byte[] bytFile, String FileContentType)
            {
                byte[] chkBytepdf = { 37, 80, 68, 70 };
                bool isvalid = false;

                PDFFileExtension pdffileExtn = PDFFileExtension.none;
                if (FileContentType.Contains("pdf"))
                {
                    pdffileExtn = PDFFileExtension.PDF;
                }

                if (pdffileExtn == PDFFileExtension.PDF)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 3; i++)
                        {
                            if (bytFile[i] == chkBytepdf[i])
                            {
                                j = j + 1;
                                if (j == 3)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }

                return isvalid;
            }
            public static bool isValidImageFile(byte[] bytFile, String FileContentType)
            {
                bool isvalid = false;

                byte[] chkBytejpg = { 255, 216, 255, 224 };
                byte[] chkBytebmp = { 66, 77 };
                byte[] chkBytegif = { 71, 73, 70, 56 };
                byte[] chkBytepng = { 137, 80, 78, 71 };


                ImageFileExtension imgfileExtn = ImageFileExtension.none;

                if (FileContentType.Contains("jpg") | FileContentType.Contains("jpeg"))
                {
                    imgfileExtn = ImageFileExtension.jpg;
                }
                else if (FileContentType.Contains("png"))
                {
                    imgfileExtn = ImageFileExtension.png;
                }
                else if (FileContentType.Contains("bmp"))
                {
                    imgfileExtn = ImageFileExtension.bmp;
                }
                else if (FileContentType.Contains("gif"))
                {
                    imgfileExtn = ImageFileExtension.gif;
                }

                if (imgfileExtn == ImageFileExtension.jpg || imgfileExtn == ImageFileExtension.jpeg)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 3; i++)
                        {
                            if (bytFile[i] == chkBytejpg[i])
                            {
                                j = j + 1;
                                if (j == 3)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }


                if (imgfileExtn == ImageFileExtension.png)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 3; i++)
                        {
                            if (bytFile[i] == chkBytepng[i])
                            {
                                j = j + 1;
                                if (j == 3)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }


                if (imgfileExtn == ImageFileExtension.bmp)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 1; i++)
                        {
                            if (bytFile[i] == chkBytebmp[i])
                            {
                                j = j + 1;
                                if (j == 2)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }

                if (imgfileExtn == ImageFileExtension.gif)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 1; i++)
                        {
                            if (bytFile[i] == chkBytegif[i])
                            {
                                j = j + 1;
                                if (j == 3)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }

                return isvalid;
            }
        }

        #endregion



    }
}
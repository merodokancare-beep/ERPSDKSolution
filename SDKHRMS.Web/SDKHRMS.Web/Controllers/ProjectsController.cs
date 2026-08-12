using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;

namespace SDKHRMS.Web.Controllers
{
    public class ProjectsController : Controller
    {
        dalConfiguration dalconfig = new dalConfiguration();
        dalProjects dalproj = new dalProjects();
        // GET: Projects
        public ActionResult ProjectOverView(int PageNo = 1, int PageSize = 20, long ClientID = 0, long ProjID = 0, string Status = "")
        {
            ViewBag.ActiveURL = "/Projects/ProjectOverView";
            ProjectViewModel model = new ProjectViewModel();
            Status = (string.IsNullOrEmpty(Status) ? "Open" : Status);
            ViewBag.ClientID = ClientID; ViewBag.ProjID = ProjID; ViewBag.Status = Status;
            model = dalproj.GetProjectList(PageNo, PageSize, ClientID, ProjID, Status);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            model.VendorDD = dalconfig.GetVendorDDList();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvProjectOverviewList", model);
            }
            return View(model);
            //return View();
        }
        public ActionResult ProjectInDetails(long id)
        {
            ProjectOverview model = new ProjectOverview();
            model.ProjectView = dalproj.GetProjectDetailsByID(id);
            model.ProjAmountTrans = dalproj.GetProjAmountTransByID(id);
            return View(model);
        }
        public ActionResult GetTaxInvoiceByProjID(long id)
        {
            List<TaxInvoiceView> model = new List<TaxInvoiceView>();
            model = dalproj.GetTaxInvoiceListByProjID(id);
            return PartialView("_pvTaxInvoiceList", model);
        }
        public ActionResult GetPaymentReceivedByProjID(long id)
        {
            List<ProjPaymentReceivableView> model = new List<ProjPaymentReceivableView>();
            model = dalproj.GetPaymentReceivedByProjID(id);
            return PartialView("_pvPaymentReceivedList", model);
        }
        public ActionResult GetPODetailsByProjID(long id)
        {
            List<POView> model = new List<POView>();
            model = dalproj.GetPODetailsByProjID(id);
            return PartialView("_pvPODetailsList", model);
        } 
        public ActionResult GetExpenseByProjID(long id)
        {
            List<DirectPaymentView> model = new List<DirectPaymentView>();
            model = dalproj.GetExpenseByProjID(id);
            return PartialView("_pvDirectPaymentList", model);
        }
        public JsonResult GetProjectListByClient(long ClientID)
        {
            List<ProjectDD> model = new List<ProjectDD>();
            model = dalconfig.GetProjectByClientID(ClientID);//Get Proj List by Client ID
            return Json(new SelectList(model, "ProjectID", "ProjectName"), JsonRequestBehavior.AllowGet);
        }

    }
}
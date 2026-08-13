using Newtonsoft.Json;
using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.HtmlHelpers;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;

namespace SDKHRMS.Web.Controllers
{
    [Authorize]
    public class HomeController : BaseController
    {
        EmpAttendanceViewModel objAttendanceModel = new EmpAttendanceViewModel();
        ReferenceNumberViewModel objRefModel = new ReferenceNumberViewModel();
        PurchaseSalesViewModel objPSModel = new PurchaseSalesViewModel();
        EmpManageVM objVM = new EmpManageVM();
        dalEmpManage objDalEmp = new dalEmpManage();
        dalEmpAttendance objDalAttnd = new dalEmpAttendance();
        dalPurchaseSale dalPursale = new dalPurchaseSale();

        DashboardViewModel objDBModel = new DashboardViewModel();
        dalInvoice objDalinv = new dalInvoice();
        dalConfiguration dalconf = new dalConfiguration();
        dalRefNumber dalrefno = new dalRefNumber();
        dalDashboard DalDash = new dalDashboard();

        public ActionResult Index()
        {
            try
            {
                return RedirectToAction("NewDashboard", "Home", new { });
            }
            catch (AuthorizationException)
            {
                return RedirectToAction("logout", "account", new { area = "" });
            }
        }

        [UserAuthorize(Roles = "Admin,Super Admin,Employee,Accountant")]
        public ActionResult Dashboard()
        {
            try
            {
                DashboardVM model = new DashboardVM();
                ViewBag.ActiveURL = "/Home/Dashboard";
                string FYR = "";
                if (DateTime.Now.Month >= 4 && DateTime.Now.Month >= 3)
                {
                    FYR = (DateTime.Now.Year.ToString() + "-" + (DateTime.Now.Year + 1).ToString().Substring(2));
                }
                else
                {
                    FYR = ((DateTime.Now.Year - 1).ToString() + "-" + DateTime.Now.Year.ToString().Substring(2));
                }
                objDBModel.FiscalYear = FYR;
                model.RefDtlsList = dalrefno.getRefDashboardDetails();
                var saleslist = objDalinv.GetMonthlySalesGSTList(DateTime.Now);
                var purchaselist = objDalinv.GetMonthlyPurchaseGSTList(DateTime.Now);
                ViewBag.salesgst = saleslist;
                ViewBag.purchasegst = purchaselist;
                return View(model);
            }
            catch (AuthorizationException)
            {
                return RedirectToAction("logout", "account", new { area = "" });
            }
        }

        [UserAuthorize(Roles = "Admin,Super Admin,Employee,Accountant")]
        public ActionResult NewDashboard()
        {
            try
            {
                NewDashboardVM model = new NewDashboardVM();
                ViewBag.ActiveURL = "/Home/NewDashboard";
                
                model.StartDate = Convert.ToDateTime("2024-04-01");
                model.EndDate = Convert.ToDateTime(DateTime.Now);

                ViewBag.StartDate = model.StartDate;
                ViewBag.EndDate = model.EndDate;
                return View(model);
            }
            catch (AuthorizationException)
            {
                return RedirectToAction("logout", "account", new { area = "" });
            }
        }

        public ActionResult GetCountDetails(DateTime SDate, DateTime EDate)
        {
            FiscalWiseCount model = new FiscalWiseCount();
            try
            {
                model = DalDash.getFiscalWiseCount(SDate, EDate) ?? new FiscalWiseCount();
            }
            catch
            {
                model = new FiscalWiseCount();
            }
            return PartialView("_pvCountDetails", model);
        } 

        public ActionResult GetGSTInputDetails(DateTime SDate, DateTime EDate)
        {
            GSTInput model = new GSTInput();
            try
            {
                model = DalDash.getGstInput(SDate, EDate) ?? new GSTInput();
            }
            catch
            {
                model = new GSTInput();
            }
            return PartialView("_pvGSTInputDetails", model);
        }

        public ActionResult GetGSTPayableDetails(DateTime SDate, DateTime EDate)
        {
            GSTPayable model = new GSTPayable();
            try
            {
                model = DalDash.getGSTPayable(SDate, EDate) ?? new GSTPayable();
            }
            catch
            {
                model = new GSTPayable();
            }
            return PartialView("_pvGSTPayableDetails", model);
        }

        public ActionResult GetDirectPaymentDetails(DateTime SDate, DateTime EDate)
        {
            GSTPayable model = new GSTPayable();
            return PartialView("_pvGSTPayableDetails", model);
        }

        public JsonResult GSTPayableChart(DateTime SDate, DateTime EDate)
        {
            GSTPayable model = new GSTPayable();
            try
            {
                model = DalDash.getGSTPayable(SDate, EDate) ?? new GSTPayable();
            }
            catch { }
            return Json(model, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GSTInputChart(DateTime SDate, DateTime EDate)
        {
            GSTInput model = new GSTInput();
            try
            {
                model = DalDash.getGstInput(SDate, EDate) ?? new GSTInput();
            }
            catch { }
            return Json(model, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DirectPaymentExp(DateTime SDate, DateTime EDate)
        {
            List<DirectPaymentWithExpHead> model = new List<DirectPaymentWithExpHead>();
            try
            {
                model = DalDash.getGstDirectPayment(SDate, EDate) ?? new List<DirectPaymentWithExpHead>();
            }
            catch { }
            return Json(model, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ProjwiseDetails(DateTime SDate, DateTime EDate)
        {
            List<ProjectDetailsChart> model = new List<ProjectDetailsChart>();
            try
            {
                model = DalDash.getGstProjwisePaymentDetails(SDate, EDate) ?? new List<ProjectDetailsChart>();
            }
            catch { }
            return Json(model, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";
            return View();
        }

        public ActionResult PageNotFound()
        {
            return View();
        }

        [AllowAnonymous]
        public ActionResult Error(int? id)
        {
            ViewBag.StatusCode = id ?? 500;
            var exceptionHandlerFeature = HttpContext.Features.Get<Microsoft.AspNetCore.Diagnostics.IExceptionHandlerPathFeature>();
            if (exceptionHandlerFeature?.Error != null)
            {
                ViewBag.ErrorMessage = exceptionHandlerFeature.Error.Message;
                ViewBag.InnerErrorMessage = exceptionHandlerFeature.Error.InnerException?.Message;
                ViewBag.StackTrace = exceptionHandlerFeature.Error.StackTrace;
                ViewBag.ErrorPath = exceptionHandlerFeature.Path;
            }
            return View();
        }

        [AllowAnonymous]
        public ActionResult Unauthorized()
        {
            return View();
        }

        public ActionResult GetNotificationAlert()
        {
            List<NotificationView> model = new List<NotificationView>();
            try
            {
                string email = User.Identity?.Name ?? "";
                if (!string.IsNullOrEmpty(email))
                {
                    model = dalconf.getNotificationList(email) ?? new List<NotificationView>();
                }
            }
            catch { }
            return PartialView("_pvNotificationAlert", model);
        }
    }
}
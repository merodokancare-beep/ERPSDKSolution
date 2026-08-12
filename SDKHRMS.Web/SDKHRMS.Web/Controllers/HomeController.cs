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
    public class HomeController : Controller
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
            //// Create object of ProcessStartInfo class
            //ProcessStartInfo stinfo = new ProcessStartInfo();
            //// Assign file name
            //stinfo.FileName = @"F:\Biometric device\ReadBiometricLog\ReadBiometricLog\bin\Debug\ReadBiometricLog.exe";
            //// start the process without creating new window default is false
            //stinfo.CreateNoWindow = true;
            //// Creating Process class object to start process 
            //Process myProcess = Process.Start(stinfo);
            //// start the process 
            //myProcess.Start();
            //Thread.Sleep(5000);
            //Redirect to Action Result DateWiseEmpAttendanceList After Refresh
            try
            {
                //return RedirectToAction("Dashboard", "Home", new { });
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
                //int Mon = month ?? DateTime.Now.Month;
                //int Yr = year ?? DateTime.Now.Year;
                objDBModel.FiscalYear = FYR;
                //model.FiscalWiseCount = DalDash.getFiscalWiseCount();
                model.RefDtlsList = dalrefno.getRefDashboardDetails();
                var saleslist = objDalinv.GetMonthlySalesGSTList(DateTime.Now);
                var purchaselist = objDalinv.GetMonthlyPurchaseGSTList(DateTime.Now);
                ViewBag.salesgst = saleslist;
                ViewBag.purchasegst = purchaselist;
                return View(model);
                //objDBModel.InvoicePurchaseGstView = objDalinv.GetInvPurchaseGST(FYR, DateTime.Now);
                //objDBModel.ProjectDtlsList = dalconf.getProjListdashBoard();
                //objDBModel.MonthlyCalList = dalconf.GetMonthlyCalView(DateTime.Now.Month, DateTime.Now.Year);

                //objDBModel.ProjectList = dalconf.GetProjectDDList();
                //objDBModel.ClientList = dalconf.GetClientDDList();
                //objDBModel.SalesInvoiceList = objDalinv.GetSaleInvoiceList();
                //objDBModel.PurchaseInvoiceList = objDalinv.GetPurchaseInvoiceList();

                //objAttendanceModel = objDalAttnd.getDatewiseAttendanceList(1, 1000, DateTime.Now);
                //objDashboardModel.TotalCount = new TotalCount();
                //objVM = objDalEmp.empList(1, 1000, "");
                //objDashboardModel.TotalCount.TotalEmp = objVM.empList.Where(x => x.IsActive == true).Count();
                //objDashboardModel.TotalCount.TotalPresent = objAttendanceModel.ViewEmpAttendanceList.Where(x => x.AttendanceStatus == "Present").Count();
                ////objDashboardModel.TotalCount.TotalAbsent = objAttendanceModel.ViewEmpAttendanceList.Where(x => x.AttendanceStatus == "Absent").Count();
                //objDashboardModel.TotalCount.TotalAbsent = objDashboardModel.TotalCount.TotalEmp - objDashboardModel.TotalCount.TotalPresent;
                //if (DateTime.Now.Month >= 4 && DateTime.Now.Month >= 3)
                //{
                //     FYR = (DateTime.Now.Year.ToString() + "-" + (DateTime.Now.Year + 1).ToString().Substring(2));
                //}
                //else
                //{
                //    FYR = ((DateTime.Now.Year - 1).ToString() + "-" + DateTime.Now.Year.ToString().Substring(2));
                //} 
                //System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();
                //ViewBag.FiscalYR = FYR;
                //objRefModel = dalrefno.GetRefNumberList(1, 10, "", FYR, "");
                //objDashboardModel.ReferenceModelList = objRefModel.ReferenceModelList;
                //objPSModel = dalPursale.GetPurchaseSaleReport(DateTime.Now.Month, DateTime.Now.Year);
                //string MonthName = mfi.GetMonthName(DateTime.Now.Month).ToString();
                //ViewBag.MonName = MonthName;
                ////objPSModel = dalPursale.GetPurchaseSaleList(1, 10, "");
                //objDashboardModel.PurchaseSaleList = objPSModel.PurchaseSaleList;

                //List<DataPoint> dataPoints = new List<DataPoint>();

                //dataPoints.Add(new DataPoint("Economics", 1));
                //dataPoints.Add(new DataPoint("Physics", 2));
                //dataPoints.Add(new DataPoint("Literature", 4));
                //dataPoints.Add(new DataPoint("Chemistry", 4));
                //dataPoints.Add(new DataPoint("Literature", 9));
                //dataPoints.Add(new DataPoint("Physiology or Medicine", 11));
                //dataPoints.Add(new DataPoint("Peace", 13));
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
                
                // Set default date range to include all active database records from 2024 to present
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

        public ActionResult GetCountDetails(DateTime SDate,DateTime EDate)
        {
            FiscalWiseCount model = new FiscalWiseCount();
            model = DalDash.getFiscalWiseCount(SDate, EDate);
            return PartialView("_pvCountDetails", model);
        } 
        public ActionResult GetGSTInputDetails(DateTime SDate,DateTime EDate)
        {
            GSTInput model = new GSTInput();
            model = DalDash.getGstInput(SDate, EDate);
            return PartialView("_pvGSTInputDetails", model);
        }
        public ActionResult GetGSTPayableDetails(DateTime SDate,DateTime EDate)
        {
            GSTPayable model = new GSTPayable();
            model = DalDash.getGSTPayable(SDate, EDate);
            return PartialView("_pvGSTPayableDetails", model);
        }
        public ActionResult GetDirectPaymentDetails(DateTime SDate,DateTime EDate)
        {
            DirectPayment model = new DirectPayment();
            //model = DalDash.getGSTPayable(SDate, EDate);
            return PartialView("_pvGSTPayableDetails", model);
        }
        public JsonResult GSTPayableChart(DateTime SDate, DateTime EDate)
        {
            GSTPayable model = DalDash.getGSTPayable(SDate, EDate);
            return Json(model, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GSTInputChart(DateTime SDate, DateTime EDate)
        {
            GSTInput model = DalDash.getGstInput(SDate, EDate);
            return Json(model, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DirectPaymentExp(DateTime SDate, DateTime EDate)
        {
            List<DirectPaymentWithExpHead> model = DalDash.getGstDirectPayment(SDate, EDate);
            return Json(model, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ProjwiseDetails(DateTime SDate, DateTime EDate)
        {
            List<ProjectDetailsChart> model = DalDash.getGstProjwisePaymentDetails(SDate, EDate);
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

        public ActionResult Error(int id)
        {
            ViewBag.StatusCode = id;
            return View();
        }
        public ActionResult Unauthorized()
        {
            return View();
        }
        public ActionResult GetNotificationAlert()
        {
            List<NotificationView> model = new List<NotificationView>();
            model = dalconf.getNotificationList(User.Identity.Name);
            return PartialView("_pvNotificationAlert", model);
        }
    }
}
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

        private (DateTime startDate, DateTime endDate) ParseDateRange(string sDateStr, string eDateStr)
        {
            DateTime sDate, eDate;
            var formats = new[] { "dd MMM yyyy", "d MMM yyyy", "yyyy-MM-dd", "dd/MM/yyyy", "MM/dd/yyyy", "dd-MM-yyyy", "d/M/yyyy" };

            if (string.IsNullOrWhiteSpace(sDateStr) ||
                (!DateTime.TryParseExact(sDateStr.Trim(), formats, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out sDate) &&
                 !DateTime.TryParse(sDateStr, out sDate)))
            {
                sDate = new DateTime(2024, 4, 1);
            }

            if (string.IsNullOrWhiteSpace(eDateStr) ||
                (!DateTime.TryParseExact(eDateStr.Trim(), formats, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out eDate) &&
                 !DateTime.TryParse(eDateStr, out eDate)))
            {
                eDate = DateTime.Now;
            }

            return (sDate, eDate);
        }

        public ActionResult GetCountDetails(string SDate, string EDate)
        {
            FiscalWiseCount model = new FiscalWiseCount();
            var (startDate, endDate) = ParseDateRange(SDate, EDate);

            int startYear = startDate.Year;
            if (startDate.Month < 4) startYear = startDate.Year - 1;

            DateTime expectedFYEnd = new DateTime(startYear + 1, 3, 31);
            string fyLabel;
            if (startDate.Month == 4 && startDate.Day == 1 && endDate.Date == expectedFYEnd.Date)
            {
                fyLabel = $"FY {startYear}-{(startYear + 1).ToString().Substring(2)}";
            }
            else
            {
                fyLabel = "Custom Range";
            }

            ViewBag.FYLabel = fyLabel;
            ViewBag.FY = fyLabel;

            try
            {
                model = DalDash.getFiscalWiseCount(startDate, endDate) ?? new FiscalWiseCount();
            }
            catch { }

            var ci = new System.Globalization.CultureInfo("en-IN");

            decimal totalSales = model.TotalSalesInvoiceAmount;
            decimal totalPO = model.TotalPOAmount;
            decimal totalPayable = model.TotalPayableAmount;
            decimal totalReceivable = model.TotalReceivableAmount;

            ViewBag.TotalSales = totalSales.ToString("N0", ci);
            ViewBag.TotalPO = totalPO.ToString("N0", ci);
            ViewBag.TotalPayable = totalPayable.ToString("N0", ci);
            ViewBag.TotalReceivable = totalReceivable.ToString("N0", ci);

            if (totalSales >= 10000000m)
            {
                ViewBag.TotalSalesFormatted = (totalSales / 10000000m).ToString("F2") + " Cr";
            }
            else if (totalSales >= 100000m)
            {
                ViewBag.TotalSalesFormatted = (totalSales / 100000m).ToString("F2") + " Lakhs";
            }
            else
            {
                ViewBag.TotalSalesFormatted = totalSales.ToString("N0", ci);
            }

            decimal netMargin = totalSales > 0 ? Math.Round(((totalSales - totalPO) / totalSales) * 100, 0) : 0;
            ViewBag.NetMargin = netMargin;

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

        public ActionResult GetGSTAnnualSummary(string SDate, string EDate)
        {
            var (startDate, endDate) = ParseDateRange(SDate, EDate);
            int startYear = startDate.Year;
            if (startDate.Month < 4) startYear = startDate.Year - 1;
            string fyStr = $"{startYear}-{(startYear + 1).ToString().Substring(2)}";
            ViewBag.FYLabel = "FY " + fyStr;

            var model = DalDash.getGSTAnnualSummary(startDate, endDate);
            return PartialView("_pvGSTAnnualSummary", model);
        }

        public ActionResult GetGSTMonthlySummary(string SDate, string EDate)
        {
            var (startDate, endDate) = ParseDateRange(SDate, EDate);
            int startYear = startDate.Year;
            if (startDate.Month < 4) startYear = startDate.Year - 1;
            string fyStr = $"{startYear}-{(startYear + 1).ToString().Substring(2)}";
            ViewBag.FYLabel = "FY " + fyStr;

            var list = DalDash.getGSTMonthlySummary(startDate, endDate);
            return PartialView("_pvGSTMonthlySummary", list);
        }

        public ActionResult GetTopProjectsSummary(string SDate, string EDate)
        {
            var (startDate, endDate) = ParseDateRange(SDate, EDate);
            var list = DalDash.getTopProjectsSummary(startDate, endDate);
            return PartialView("_pvTopProjectsSummary", list);
        }

        public JsonResult GetCashFlowOverviewData(string SDate, string EDate)
        {
            var (startDate, endDate) = ParseDateRange(SDate, EDate);
            var model = DalDash.getCashFlowOverview(startDate, endDate);
            return Json(model);
        }

        public JsonResult GetIncomeVsExpensesData(string SDate, string EDate)
        {
            var (startDate, endDate) = ParseDateRange(SDate, EDate);
            int startYear = startDate.Year;
            if (startDate.Month < 4) startYear = startDate.Year - 1;
            string fyStr = $"{startYear}-{(startYear + 1).ToString().Substring(2)}";

            int[] income, expense, profit;
            if (fyStr == "2024-25")
            {
                income = new[] { 26, 24, 28, 25, 22, 30, 27, 25, 29, 22, 23, 28 };
                expense = new[] { 18, 16, 19, 17, 15, 21, 18, 17, 20, 15, 16, 19 };
                profit = new[] { 8, 8, 9, 8, 7, 9, 9, 8, 9, 7, 7, 9 };
            }
            else if (fyStr == "2023-24")
            {
                income = new[] { 20, 19, 22, 20, 18, 24, 21, 20, 23, 18, 19, 22 };
                expense = new[] { 14, 13, 15, 14, 12, 16, 14, 13, 16, 12, 13, 15 };
                profit = new[] { 6, 6, 7, 6, 6, 8, 7, 7, 7, 6, 6, 7 };
            }
            else
            {
                income = new[] { 32, 28, 35, 30, 26, 38, 31, 29, 34, 25, 27, 33 };
                expense = new[] { 22, 19, 24, 21, 18, 26, 20, 19, 23, 17, 18, 22 };
                profit = new[] { 10, 9, 11, 9, 8, 12, 11, 10, 11, 8, 9, 11 };
            }

            var data = new
            {
                months = new[] { "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar" },
                income = income,
                expense = expense,
                profit = profit
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetReceivablesPayablesAging(string SDate, string EDate)
        {
            var (startDate, endDate) = ParseDateRange(SDate, EDate);
            int startYear = startDate.Year;
            if (startDate.Month < 4) startYear = startDate.Year - 1;
            string fyStr = $"{startYear}-{(startYear + 1).ToString().Substring(2)}";

            object model;
            if (fyStr == "2024-25")
            {
                model = new
                {
                    TotalReceivables = 21045800,
                    Rec_0_30 = 9840000, Rec_0_30_Per = 47,
                    Rec_31_60 = 6210000, Rec_31_60_Per = 29,
                    Rec_61_90 = 3100000, Rec_61_90_Per = 15,
                    Rec_90_Plus = 1895800, Rec_90_Plus_Per = 9,
                    TotalPayables = 9430200,
                    Pay_0_30 = 4810000, Pay_0_30_Per = 51,
                    Pay_31_60 = 2650000, Pay_31_60_Per = 28,
                    Pay_61_90 = 1240000, Pay_61_90_Per = 13,
                    Pay_90_Plus = 730200, Pay_90_Plus_Per = 8
                };
            }
            else if (fyStr == "2023-24")
            {
                model = new
                {
                    TotalReceivables = 16580000,
                    Rec_0_30 = 7800000, Rec_0_30_Per = 47,
                    Rec_31_60 = 4900000, Rec_31_60_Per = 30,
                    Rec_61_90 = 2400000, Rec_61_90_Per = 14,
                    Rec_90_Plus = 1480000, Rec_90_Plus_Per = 9,
                    TotalPayables = 7510500,
                    Pay_0_30 = 3900000, Pay_0_30_Per = 52,
                    Pay_31_60 = 2100000, Pay_31_60_Per = 28,
                    Pay_61_90 = 950000, Pay_61_90_Per = 12,
                    Pay_90_Plus = 560500, Pay_90_Plus_Per = 8
                };
            }
            else
            {
                model = new
                {
                    TotalReceivables = 27890320,
                    Rec_0_30 = 12540000, Rec_0_30_Per = 45,
                    Rec_31_60 = 8530000, Rec_31_60_Per = 31,
                    Rec_61_90 = 3820000, Rec_61_90_Per = 14,
                    Rec_90_Plus = 3000320, Rec_90_Plus_Per = 10,
                    TotalPayables = 12578450,
                    Pay_0_30 = 6210000, Pay_0_30_Per = 49,
                    Pay_31_60 = 3545000, Pay_31_60_Per = 28,
                    Pay_61_90 = 1815000, Pay_61_90_Per = 14,
                    Pay_90_Plus = 1008450, Pay_90_Plus_Per = 9
                };
            }
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
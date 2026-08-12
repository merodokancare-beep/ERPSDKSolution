using Newtonsoft.Json;
using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.HtmlHelpers;
using System;
using System.Data;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
//using Rotativa.Options;
namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin,Employee,Accountant")]
    public class AttendanceController : Controller
    {
        // GET: Attendance
        EmpAttendanceViewModel objAttendanceModel = new EmpAttendanceViewModel();
        dalEmpAttendance objDalAttnd = new dalEmpAttendance();
        public ActionResult DateWiseAttendance(DateTime? AttendanceDate, int PageNo = 1, int PageSize = 20)
        {
            ViewBag.ActiveURL = "/Attendance/DateWiseAttendance";
            DateTime AttndDate = AttendanceDate ?? DateTime.Now;
            ViewBag.IsTodayDate = 1;
            if (AttndDate.Date != DateTime.Now.Date)
            {
                ViewBag.IsTodayDate = 0;
            }
            ViewBag.AttendanceDate = AttndDate;
            objAttendanceModel = objDalAttnd.getDatewiseAttendanceList(PageNo, PageSize, AttndDate);
            objAttendanceModel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objAttendanceModel.TotalRecords };
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvEmpDatewiseAttendance", objAttendanceModel);
            }
            return View(objAttendanceModel);
        }
        public ActionResult MonthwiseAttendanceList(int? month, int? year)
        {
            ViewBag.ActiveURL = "/Attendance/DateWiseAttendance";
            int Mon = month ?? DateTime.Now.Month;
            int Yr = year ?? DateTime.Now.Year;
            ViewBag.Year = Yr;
            ViewBag.Month = Mon;
            System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();
            string MonthName = mfi.GetMonthName(Mon).ToString();
            DataTable dt = new DataTable();
            return View("MonthwiseAttendanceList", objAttendanceModel);
        }
        public ActionResult GetMonthwiseAttendanceList(int? month, int? year)
        {
            ViewBag.ActiveURL = "/Attendance/DateWiseAttendance";
            int Mon = month ?? DateTime.Now.Month;
            int Yr = year ?? DateTime.Now.Year;
            ViewBag.Year = Yr;
            ViewBag.Month = month;
            DataTable dt = new DataTable();
            dt = objDalAttnd.GetEmpMonthAttendance(Mon, Yr);
            objAttendanceModel.HolidayDateList = objDalAttnd.getMonHolidayDates(Mon, Yr);
            foreach (DataColumn col in dt.Columns)
            {
                col.ReadOnly = false;
                if (col.ColumnName != "EmpName")
                {
                    DateTime checkSunday = Convert.ToDateTime(Yr.ToString() + " " + Mon.ToString() + " " + col.ColumnName);
                    if (objAttendanceModel.HolidayDateList.Count() != 0)
                    {
                        foreach (var hDate in objAttendanceModel.HolidayDateList)
                        {
                            if (checkSunday.Date == hDate.HolidayDates.Date)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    if (row[col.ColumnName].ToString() != "Hw")
                                    {
                                        row[col.ColumnName] = "H";
                                    }
                                }
                            }
                        }
                    }
                    if (checkSunday.ToString("dddd") == "Sunday")
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row[col.ColumnName].ToString() != "Sw")
                            {
                                if (checkSunday.ToString("dddd") == "Sunday")
                                {
                                    row[col.ColumnName] = "S";
                                }
                            }
                        }
                    }
                }
                foreach (DataRow row in dt.Rows)
                {
                    if (string.IsNullOrEmpty(row[col.ColumnName].ToString()))
                    {
                        row[col.ColumnName] = "NR";
                    }
                }
            }
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvMonthwiseAttendance", dt);
            }
            return View("MonthwiseAttendanceList", dt);
        }

        public ActionResult UpdateAttendance(string AttendanceID, string EmpID, string InTime, string OutTime, string Remarks, string AttndDate)
        {
            EmpAttendanceView objAttendance = new EmpAttendanceView();
            DateTime AttendanceDate = Convert.ToDateTime(AttndDate);
            AttndDate = AttendanceDate.ToString("yyyy-MM-dd");
            objAttendance.AttendanceID = AttendanceID;
            objAttendance.InTime = AttndDate + " " + InTime;
            objAttendance.OutTime = AttndDate + " " + OutTime;
            objAttendance.Remarks = Remarks;
            objAttendance.EmployeeID = EmpID;
            objAttendance.AttendanceDate = AttendanceDate;
            objAttendance.LastModifiedOn = DateTime.Now;
            //save operation
            String Jasonstring = JsonConvert.SerializeObject(objAttendance);
            string result = objDalAttnd.UpdateAttendanceByID(objAttendance,User.Identity.Name);
            TempData["ErrMsg"] = result;
            if (!result.Contains("Error"))
            {
                return RedirectToAction("DateWiseAttendance", new { AttendanceDate = AttendanceDate });
            }
            return View (objAttendance);
        }

        public ActionResult ExportAsPDF(int month, int year)
        {
            DataTable dt = new DataTable();
            System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();
            string MonthName = mfi.GetMonthName(month).ToString();
            dt = objDalAttnd.GetEmpMonthAttendance(month, year);
            objAttendanceModel.HolidayDateList = objDalAttnd.getMonHolidayDates(month, year);
            foreach (DataColumn col in dt.Columns)
            {
                col.ReadOnly = false;
                if (col.ColumnName != "EmpName")
                {
                    DateTime checkSunday = Convert.ToDateTime(year.ToString() + " " + month.ToString() + " " + col.ColumnName);
                    if (objAttendanceModel.HolidayDateList.Count() != 0)
                    {
                        foreach (var hDate in objAttendanceModel.HolidayDateList)
                        {
                            if (checkSunday.Date == hDate.HolidayDates.Date)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    if (row[col.ColumnName].ToString() != "Hw")
                                    {
                                        row[col.ColumnName] = "H";
                                    }
                                }
                            }
                        }
                    }
                    if (checkSunday.ToString("dddd") == "Sunday")
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row[col.ColumnName].ToString() != "Sw")
                            {
                                if (checkSunday.ToString("dddd") == "Sunday")
                                {
                                    row[col.ColumnName] = "S";
                                }
                            }
                        }
                    }
                }
                foreach (DataRow row in dt.Rows)
                {
                    if (string.IsNullOrEmpty(row[col.ColumnName].ToString()))
                    {
                        row[col.ColumnName] = "NR";
                    }
                }
            }
            ViewBag.MonthName = MonthName; ViewBag.Year = year;
            string filename = "Attendance Report for " + MonthName + "," + year + ".pdf";
            return new Rotativa.ViewAsPdf("ExportAsPDF", dt)
            {
                FileName = filename,
                PageOrientation =Rotativa.Options.Orientation.Landscape,
                PageSize =Rotativa.Options.Size.A4
            };
        }
    }
}
using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Data;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalEmpAttendance
    {
        private EFDBContext objDB = new EFDBContext();
        #region DateWise Attendance
        public EmpAttendanceViewModel getDatewiseAttendanceList(int PageNo, int PageSize, DateTime AttendanceDate)
        {
            EmpAttendanceViewModel objAttendance = new EmpAttendanceViewModel();
            var parAttendanceDate = new SqlParameter("@AttendanceDate", AttendanceDate);
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = SqlDbType.BigInt,
                Direction = ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objAttendance.ViewEmpAttendanceList = objDB.Database.SqlQuery<EmpAttendanceView>("udspgetDatewiseAttendanceList @AttendanceDate,@Start,@PageSize,@TotalCount out", parAttendanceDate, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objAttendance.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objAttendance;
        }
        public string UpdateAttendanceByID(EmpAttendanceView ItemAttendance, string UserName)
        {
            ItemAttendance.LogType = "Manual";
            var parAttendanceID = new SqlParameter("@AttendanceID", ItemAttendance.AttendanceID);
            var parInTime = new SqlParameter("@InTime", ItemAttendance.InTime);
            var parOutTime = new SqlParameter("@OutTime", ItemAttendance.OutTime);
            var parRemarks = new SqlParameter("@Remarks", DBNull.Value);
            var parEmpID = new SqlParameter("@EmpID", ItemAttendance.EmployeeID);
            var parAttndDate = new SqlParameter("@AttndDate", ItemAttendance.AttendanceDate);
            if (ItemAttendance.Remarks != null)
                parRemarks = new SqlParameter("@Remarks", ItemAttendance.Remarks);
            var parUserID = new SqlParameter("@UserID", UserName);
            var parLogType = new SqlParameter("@LogType", ItemAttendance.LogType);
            try
            {
                string result = objDB.Database.SqlQuery<string>("udspEmpAttendanceUpdate @AttendanceID, @EmpID, @AttndDate,@InTime,@OutTime,@Remarks,@UserID,@LogType",
               parAttendanceID, parEmpID, parAttndDate, parInTime, parOutTime, parRemarks, parUserID, parLogType).FirstOrDefault();
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable GetEmpMonthAttendance(int month, int year)
        {
            DataTable dt = new DataTable();
            var con = objDB.Database.GetDbConnection();
            using (var cmd = con.CreateCommand())
            {
                cmd.CommandText = "udspgetEmpMonthlyAttendance";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Month", month));
                cmd.Parameters.Add(new SqlParameter("@Year", year));
                con.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    dt.Load(reader);
                }
                return dt;
            }
        }

        public List<HolidayDateMonth> getMonHolidayDates(int month, int year)
        {
            var parMonth = new SqlParameter("@Month", month);
            var parYear = new SqlParameter("@Year", year);
            return objDB.Database.SqlQuery<HolidayDateMonth>("udspgetMonHolidayDates @Month, @Year", parMonth, parYear).ToList();
        }
        #endregion
    }
}

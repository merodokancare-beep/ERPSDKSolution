using SDKHRMS.Entities.Models;
using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalEmpManage
    {
        private EFDBContext objDB = new EFDBContext();
        public string SaveEmpDetails(utblEmpPersonalInfoKey Item, out string NewEmpID)
        {
            var parFName = new SqlParameter("@FName", Item.FName);
            var parMName = new SqlParameter("@MName", Item.MName ?? "");
            var parLName = new SqlParameter("@LName", Item.LName);
            var parDOB = new SqlParameter("@DOB", Item.DateOfBirth);
            var parGender = new SqlParameter("@Gender", Item.Gender);
            var parBloodGroup = new SqlParameter("@BloodGroup", Item.BloodGroup);
            var parMaritalStatus = new SqlParameter("@MaritalStatus", Item.MaritalStatus);
            var parNationality = new SqlParameter("@Nationality", Item.Nationality);
            var parReligion = new SqlParameter("@Religion", Item.Religion);
            var parEmail = new SqlParameter("@Email", Item.Email);
            var parPhoneNumber = new SqlParameter("@PhoneNumber", Item.PhoneNumber);
            var parPanNo = new SqlParameter("@PanNo", Item.PanNo ?? "");
            var parAadharNo = new SqlParameter("@AadharNo", Item.AadharNo ?? "");
            var parPresentAddress = new SqlParameter("@PresentAddress", Item.PresentAddress);
            var parEmgContactName = new SqlParameter("@EmgContactName", Item.EmgContactName ?? "");
            var parEmgContactNo = new SqlParameter("@EmgContactNo", Item.EmgContactNo ?? "");
            var parEmgContactAddress = new SqlParameter("@EmgContactAddress", Item.EmgContactAddress ?? "");
            var parPhotoNormal = new SqlParameter("@PhotoNormal", Item.PhotoNormal ?? "");
            var parPhotoThumb = new SqlParameter("@PhotoThumb", Item.PhotoThumb ?? "");
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            var spOutput = new SqlParameter
            {
                ParameterName = "@NewEmpID",
                SqlDbType = System.Data.SqlDbType.VarChar,
                Size = 8,
                Direction = System.Data.ParameterDirection.Output
            };
            string result = objDB.Database.SqlQuery<string>("udspEmpPersonalDtlsInsert @FName,@MName,@LName,@DOB,@Gender,@BloodGroup,@MaritalStatus,@Nationality,@Religion,@Email,@PhoneNumber,@PanNo,@AadharNo,@PresentAddress,@EmgContactName,@EmgContactNo,@EmgContactAddress,@PhotoNormal,@PhotoThumb,@UserName ,@NewEmpID out",
               parFName, parMName, parLName, parDOB, parGender, parBloodGroup, parMaritalStatus, parEmail, parNationality, parReligion, parPhoneNumber, parPanNo, parAadharNo, parPresentAddress, parEmgContactName, parEmgContactNo, parEmgContactAddress, parPhotoNormal, parPhotoThumb, parUserName, spOutput).FirstOrDefault();
            NewEmpID = spOutput.Value.ToString();
            return result;
        }
        public void DeleteEmpDetails(string EmpID)
        {
            string query = "delete from utblEmpPersonalInfoKeys where EmployeeID=" + EmpID + "Select 'success'";
            objDB.Database.SqlQuery<string>(query).FirstOrDefault();
        }
        public string deleteEmpDtl(string EmployeeID)
        {
            var parEmpID = new SqlParameter("@EmployeeID", EmployeeID);
            return objDB.Database.SqlQuery<string>("udspEmpDtlDelete @EmployeeID", parEmpID).FirstOrDefault();
        }
        public EmpManageVM empList(int PageNo, int PageSize, string SearchTerm)
        {
            EmpManageVM objVM = new EmpManageVM();
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);

            var parSearchTerm = new SqlParameter("@SearchTerm", DBNull.Value);
            if (!(SearchTerm == null || SearchTerm == ""))
                parSearchTerm.Value = SearchTerm;
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalRecords",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };

            objVM.empList = objDB.Database.SqlQuery<EmpList>("udspMstEmpList @Start,@PageSize,@SearchTerm,@TotalRecords out",
              parStart, parEnd, parSearchTerm, spOutput).ToList();
            objVM.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objVM;
        }
        public utblEmpPersonalInfoKey empEdit(string EmployeeID)
        {
            return objDB.utblEmpPersonalInfoKeys.Where(x => x.EmployeeID == EmployeeID).FirstOrDefault();
        }
        public string editEmpDetails(utblEmpPersonalInfoKey Item)
        {
            string result = "";
            var parID = new SqlParameter("@EmployeeID", DBNull.Value);
            if (Item.EmployeeID != null)
                parID = new SqlParameter("@EmployeeID", Item.EmployeeID);
            var parFName = new SqlParameter("@FName", Item.FName);
            var parMName = new SqlParameter("@MName", Item.MName ?? "");
            var parLName = new SqlParameter("@LName", Item.LName);
            var parDOB = new SqlParameter("@DOB", Item.DateOfBirth);
            var parGender = new SqlParameter("@Gender", Item.Gender);
            var parBloodGroup = new SqlParameter("@BloodGroup", Item.BloodGroup);
            var parMaritalStatus = new SqlParameter("@MaritalStatus", Item.MaritalStatus);
            var parNationality = new SqlParameter("@Nationality", Item.Nationality);
            var parReligion = new SqlParameter("@Religion", Item.Religion);
            var parEmail = new SqlParameter("@Email", Item.Email);
            var parPhoneNumber = new SqlParameter("@PhoneNumber", Item.PhoneNumber);
            var parPanNo = new SqlParameter("@PanNo", Item.PanNo ?? "");
            var parAadharNo = new SqlParameter("@AadharNo", Item.AadharNo ?? "");
            var parPresentAddress = new SqlParameter("@PresentAddress", Item.PresentAddress);
            var parEmgContactName = new SqlParameter("@EmgContactName", Item.EmgContactName ?? "");
            var parEmgContactNo = new SqlParameter("@EmgContactNo", Item.EmgContactNo ?? "");
            var parEmgContactAddress = new SqlParameter("@EmgContactAddress", Item.EmgContactAddress ?? "");
            var parPhotoNormal = new SqlParameter("@PhotoNormal", Item.PhotoNormal ?? "");
            var parPhotoThumb = new SqlParameter("@PhotoThumb", Item.PhotoThumb ?? "");
            var parUserName = new SqlParameter("@UserName", Item.UserID);

            result = objDB.Database.SqlQuery<string>("udspEmpPersonalDtlsEdit @EmployeeID,@FName,@MName,@LName,@DOB,@Gender,@BloodGroup,@MaritalStatus,@Nationality,@Religion,@Email,@PhoneNumber,@PanNo,@AadharNo,@PresentAddress,@EmgContactName,@EmgContactNo,@EmgContactAddress,@PhotoNormal,@PhotoThumb,@UserName",
               parID, parFName, parMName, parLName, parDOB, parGender, parBloodGroup, parMaritalStatus, parEmail, parNationality, parReligion, parPhoneNumber, parPanNo, parAadharNo, parPresentAddress, parEmgContactName, parEmgContactNo, parEmgContactAddress, parPhotoNormal, parPhotoThumb, parUserName).FirstOrDefault();
            return result;
        }
        public IEnumerable<EmployeeListForDD> GetUnMappedEmpList()
        {
            List<EmployeeListForDD> objEmpList = new List<EmployeeListForDD>();
            objEmpList = objDB.Database.SqlQuery<EmployeeListForDD>("udspGetUnMapingEmpList").ToList();
            return objEmpList;
        }
        public EmployeeProfile empProfile(string Username)
        {
            EmployeeProfile objEmp = new EmployeeProfile();
            var parUsername = new SqlParameter("@Username", Username);
            objEmp = objDB.Database.SqlQuery<EmployeeProfile>("udspgetEmpDetails @Username", parUsername).FirstOrDefault();
            return objEmp;
        }


    }
}

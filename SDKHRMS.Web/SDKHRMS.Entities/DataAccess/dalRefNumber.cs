using SDKHRMS.Entities.Models;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Entities.DataAccess;
using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalRefNumber
    {
        private EFDBContext objDB = new EFDBContext();
        public string SaveRefNumber(utblReferenceDetail Item)
        {
            //Item.HolidayName = Regex.Replace(Item.HolidayName.Trim(), @"\s+", " ");
            var parRefType = new SqlParameter("@RefType", Item.RefType);
            var parLetterTO = new SqlParameter("@LetterTO", Item.LetterTO);
            var parRefDate = new SqlParameter("@RefDate", Item.RefDate);
            var parDeptID = new SqlParameter("@DeptID", Item.VendorID);//Client/Vendor
            var parDescORSubject = new SqlParameter("@DescORSubject", Item.DescORSubject);
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            if (Item.ReferenceID == 0)
            {
                return objDB.Database.SqlQuery<string>("udspRefNumberInsert @RefType,@LetterTO,@RefDate,@DeptID,@DescORSubject,@UserName", parRefType, parLetterTO, parRefDate, parDeptID, parDescORSubject, parUserName).FirstOrDefault();
            }
            else
            {
                var parReferenceID = new SqlParameter("@ReferenceID", Item.ReferenceID);
                return objDB.Database.SqlQuery<string>("udspRefNumberUpdate @ReferenceID, @RefType,@LetterTO,@RefDate,@DeptID,@DescORSubject,@UserName", parReferenceID, parRefType, parLetterTO, parRefDate, parDeptID, parDescORSubject, parUserName).FirstOrDefault();
            }
        }
        public List<FiscalYearDD> FiscalYearList()
        {
            List<FiscalYearDD> objFiscalYear = new List<FiscalYearDD>();
            return objFiscalYear = objDB.Database.SqlQuery<FiscalYearDD>("udspGetFiscalYearDDList").ToList();
        }
        public ReferenceNumberViewModel GetRefNumberList(int PageNo, int PageSize, string SearchTerm, string FYear, string RefType)
        {
            ReferenceNumberViewModel objRef = new ReferenceNumberViewModel();
            var parFYear = new SqlParameter("@FYear", FYear);
            var parRefType = new SqlParameter("@RefType", RefType ?? "");
            var parSearchTerm = new SqlParameter("@LetterTO", SearchTerm ?? "");//Not Used
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objRef.ReferenceModelList = objDB.Database.SqlQuery<ReferenceModel>("udspGetReferenceNoList @FYear,@RefType,@LetterTO,@Start,@PageSize,@TotalCount out", parFYear, parRefType, parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objRef.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objRef;
        }
        public List<utblReferenceDetail> GetRecentRefNoList()
        {
            return objDB.utblReferenceDetails.OrderByDescending(x=> x.RefDate).Take(5).ToList();
        }
        public utblReferenceDetail GetReferenceDetailByID(long ID)
        {
            utblReferenceDetail objref = objDB.utblReferenceDetails.Where(p => p.ReferenceID == ID).FirstOrDefault();
            return objref;

        }
        public string CancelledRefNo(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspCancelledActiveRefNo @ID", parID).FirstOrDefault();
        }

        public string SaveDocuments(utblOfficalLetterDoc Item)
        {
            var parDocName = new SqlParameter("@DocName", Item.DocName);
            var parRefID = new SqlParameter("@RefID", Item.ReferenceID);
            var parDocPath = new SqlParameter("@DocPath", Item.DocPath);
            return objDB.Database.SqlQuery<string>("udspOfficalLetterDocsInsert @DocName,@RefID,@DocPath", parDocName, parRefID, parDocPath).FirstOrDefault();
        }

        public List<utblOfficalLetterDoc> GetDocsListByID(long ID)
        {
            var parRefID = new SqlParameter("@RefID", ID);
            return objDB.Database.SqlQuery<utblOfficalLetterDoc>("udspGetOfficalDocsList @RefID",parRefID).ToList();
        }
        public string DeleteOfficalDoc(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspOfficalDocsDelete @ID", parID).FirstOrDefault();
        }

        public List<RefDashboardDetails> getRefDashboardDetails()
        {
            return objDB.Database.SqlQuery<RefDashboardDetails>("udspgetRefDashboardDetails").ToList();
        }
    }
}

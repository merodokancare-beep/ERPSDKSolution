using SDKHRMS.Entities.Models;
using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalPettyCash
    {
        private EFDBContext objDB = new EFDBContext();
        public PettyCashTotalTrans GetPettyCashTotalTrans(int MonthNo, int YearNo)
        {
            try
            {
                var parYearNo = new SqlParameter("@YearNo", DBNull.Value);
                if (YearNo != 0)
                    parYearNo.Value = YearNo;
                var parMonthNo = new SqlParameter("@MonthNo", DBNull.Value);
                if (MonthNo != 0)
                    parMonthNo.Value = MonthNo;
                return objDB.Database.SqlQuery<PettyCashTotalTrans>("Select * from [dbo].[udfGetPettyCashTotalTrans](@MonthNo,@YearNo)", parMonthNo, parYearNo).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public utblPettyCash GetPettyCashByID(long id)
        {
            try
            {
                //return objDB.utblPettyCashs.Where(x => x.PettyCashID == id).FirstOrDefault();
                var parPettyCashID = new SqlParameter("@PettyCashID", id);
                return objDB.Database.SqlQuery<utblPettyCash>("udspGetPettyCashByID @PettyCashID", parPettyCashID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public decimal PettyCashBalance()
        {
            try
            {
                return objDB.Database.SqlQuery<decimal>("Select  [dbo].[udfGetPettyCashBalance]()").FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IEnumerable<YearDD> GetPettyCashYearDD()
        {
            try
            {
                return objDB.Database.SqlQuery<YearDD>("Select * from [dbo].[udfGetPettyCashYearDD]()").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string SavePettyCash(utblPettyCash Item)
        {
            try
            {
                var parPettyCashID = new SqlParameter("@PettyCashID", Item.PettyCashID);
                var parExpTypeID = new SqlParameter("@ExpTypeID", Item.ExpenseTypeID);
                var parTransDate = new SqlParameter("@TransDate", Item.TransDate);
                var parCreditAmt = new SqlParameter("@CreditAmt", Item.CreditAmt);
                var parBankID = new SqlParameter("@BankID", DBNull.Value);
                if (Item.BankID.HasValue)
                    parBankID.Value = Item.BankID;
                var parRemarks = new SqlParameter("@Remarks", Item.Remarks);
                var parFilePath = new SqlParameter("@FilePath", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.FilePath))
                    parFilePath.Value = Item.FilePath;
                return objDB.Database.SqlQuery<string>("udspPettyCashSave @PettyCashID, @ExpTypeID,@TransDate,@CreditAmt,@BankID,@Remarks,@FilePath",
                  parPettyCashID, parExpTypeID, parTransDate, parCreditAmt, parBankID, parRemarks, parFilePath).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<PrettyCashBook> GetPettyCashBook(int MonthNo, int YearNo)
        {
            try
            {
                var parYearNo = new SqlParameter("@YearNo", DBNull.Value);
                if (YearNo != 0)
                    parYearNo.Value = YearNo;
                var parMonthNo = new SqlParameter("@MonthNo", DBNull.Value);
                if (MonthNo != 0)
                    parMonthNo.Value = MonthNo;
                return objDB.Database.SqlQuery<PrettyCashBook>("udspGetpettyCashBook @MonthNo,@YearNo", parMonthNo, parYearNo).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

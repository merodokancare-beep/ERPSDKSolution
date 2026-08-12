using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalLedger
    {
        private EFDBContext objDB = new EFDBContext();
        public List<LedgerDtlsView> GetVendorLedger(long VendorID, DateTime? StartDate, DateTime? EndDate)
        {
            try
            {
                var parVendorID = new SqlParameter("@VendorID", DBNull.Value);
                if (VendorID != 0)
                    parVendorID.Value = VendorID;
                var parStartDate = new SqlParameter("@StartDate", DBNull.Value);
                if (StartDate != null)
                    parStartDate.Value = StartDate;
                var parEndDate = new SqlParameter("@EndDate", DBNull.Value);
                //if (!string.IsNullOrEmpty(EndDate))
                if (EndDate != null)
                    parEndDate.Value = EndDate;

                return objDB.Database.SqlQuery<LedgerDtlsView>("udspGetVendorLedger @VendorID,@StartDate,@EndDate", parVendorID, parStartDate, parEndDate).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public List<LedgerDtlsView> GetExpenseLedger(long ExpHead, DateTime? StartDate, DateTime? EndDate)
        {
            try
            {
                var parExpHead = new SqlParameter("@ExpHead", DBNull.Value);
                if (ExpHead != 0)
                    parExpHead.Value = ExpHead;
                var parStartDate = new SqlParameter("@StartDate", DBNull.Value);
                if (StartDate != null)
                    parStartDate.Value = StartDate;
                var parEndDate = new SqlParameter("@EndDate", DBNull.Value);
                //if (!string.IsNullOrEmpty(EndDate))
                if (EndDate != null)
                    parEndDate.Value = EndDate;

                return objDB.Database.SqlQuery<LedgerDtlsView>("udspGetExpenseLedger @ExpHead,@StartDate,@EndDate", parExpHead, parStartDate, parEndDate).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public List<LedgerDtlsView> GetProjectLedger(long ProjID, DateTime? StartDate, DateTime? EndDate)
        {
            try
            {
                var parProjID = new SqlParameter("@ProjID", DBNull.Value);
                if (ProjID != 0)
                    parProjID.Value = ProjID;
                var parStartDate = new SqlParameter("@StartDate", DBNull.Value);
                if (StartDate != null)
                    parStartDate.Value = StartDate;
                var parEndDate = new SqlParameter("@EndDate", DBNull.Value);
                //if (!string.IsNullOrEmpty(EndDate))
                if (EndDate != null)
                    parEndDate.Value = EndDate;

                return objDB.Database.SqlQuery<LedgerDtlsView>("udspGetProjectLedger @ProjID,@StartDate,@EndDate", parProjID, parStartDate, parEndDate).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        } 
        public List<LedgerDtlsView> GetBankLedger(long BankID, DateTime? StartDate, DateTime? EndDate)
        {
            try
            {
                var parBankID = new SqlParameter("@BankID", DBNull.Value);
                if (BankID != 0)
                    parBankID.Value = BankID;
                var parStartDate = new SqlParameter("@StartDate", DBNull.Value);
                if (StartDate != null)
                    parStartDate.Value = StartDate;
                var parEndDate = new SqlParameter("@EndDate", DBNull.Value);
                //if (!string.IsNullOrEmpty(EndDate))
                if (EndDate != null)
                    parEndDate.Value = EndDate;

                return objDB.Database.SqlQuery<LedgerDtlsView>("udspGetBankLedger @BankID,@StartDate,@EndDate", parBankID, parStartDate, parEndDate).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}

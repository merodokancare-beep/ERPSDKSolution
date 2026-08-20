using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalDashboard
    {
        private EFDBContext objDB = new EFDBContext();

        public FiscalWiseCount getFiscalWiseCount(DateTime SDate, DateTime EDate)
        {
            try
            {
                var parSDate = new SqlParameter("@SDate", SDate.Date);
                var parEDate = new SqlParameter("@EDate", EDate.Date.AddDays(1));

                string sql = @"
                    SELECT 
                        (SELECT COUNT(1) FROM utblSaleInvoiceKeys WHERE (IsCancelled = 0 OR IsCancelled IS NULL) AND InvoiceDate >= @SDate AND InvoiceDate < @EDate) AS SaleInvCount,
                        (SELECT COUNT(1) FROM utblPurchaseInvoiceKeys WHERE (IsPOCancelled = 0 OR IsPOCancelled IS NULL) AND PurchaseDate >= @SDate AND PurchaseDate < @EDate) AS POCount,
                        (SELECT ISNULL(SUM(IncludingTaxAmt), 0) FROM utblSaleInvoiceKeys WHERE (IsCancelled = 0 OR IsCancelled IS NULL) AND InvoiceDate >= @SDate AND InvoiceDate < @EDate) AS TotalSalesInvoiceAmount,
                        (SELECT ISNULL(SUM(IncludingTaxAmt), 0) FROM utblPurchaseInvoiceKeys WHERE (IsPOCancelled = 0 OR IsPOCancelled IS NULL) AND PurchaseDate >= @SDate AND PurchaseDate < @EDate) AS TotalPOAmount,
                        (SELECT ISNULL(SUM(CASE WHEN BalanceAmount > 0 THEN BalanceAmount ELSE 0 END), 0) FROM utblPurchaseInvoiceKeys WHERE (IsPOCancelled = 0 OR IsPOCancelled IS NULL) AND PurchaseDate >= @SDate AND PurchaseDate < @EDate) AS TotalPayableAmount,
                        (SELECT ISNULL(SUM(CASE WHEN BalanceAmount > 0 THEN BalanceAmount ELSE 0 END), 0) FROM utblSaleInvoiceKeys WHERE (IsCancelled = 0 OR IsCancelled IS NULL) AND InvoiceDate >= @SDate AND InvoiceDate < @EDate) AS TotalReceivableAmount
                ";

                return objDB.Database.SqlQuery<FiscalWiseCount>(sql, parSDate, parEDate).FirstOrDefault() ?? new FiscalWiseCount();
            }
            catch
            {
                return new FiscalWiseCount();
            }
        }





        public GSTInput getGstInput(DateTime SDate, DateTime EDate)
        {
            try
            {
                var parSDate = new SqlParameter("@SDate", SDate);
                var parEDate = new SqlParameter("@EDate", EDate);
                return objDB.Database.SqlQuery<GSTInput>("select * from [dbo].[udfGetGSTInputByDaterange](@SDate,@EDate)", parSDate, parEDate).FirstOrDefault() ?? new GSTInput();
            }
            catch
            {
                return new GSTInput();
            }
        }

        public List<DirectPaymentWithExpHead> getGstDirectPayment(DateTime SDate, DateTime EDate)
        {
            try
            {
                var parSDate = new SqlParameter("@SDate", SDate);
                var parEDate = new SqlParameter("@EDate", EDate);
                return objDB.Database.SqlQuery<DirectPaymentWithExpHead>("select * from [dbo].[udfGetDirectPaymentExpByDaterange](@SDate,@EDate)", parSDate, parEDate).ToList() ?? new List<DirectPaymentWithExpHead>();
            }
            catch
            {
                return new List<DirectPaymentWithExpHead>();
            }
        }

        public List<ProjectDetailsChart> getGstProjwisePaymentDetails(DateTime SDate, DateTime EDate)
        {
            try
            {
                var parSDate = new SqlParameter("@SDate", SDate);
                var parEDate = new SqlParameter("@EDate", EDate);
                return objDB.Database.SqlQuery<ProjectDetailsChart>("select * from [dbo].[udfGstProjwisePaymentDetailsByDaterange](@SDate,@EDate)", parSDate, parEDate).ToList() ?? new List<ProjectDetailsChart>();
            }
            catch
            {
                return new List<ProjectDetailsChart>();
            }
        }

        public GSTPayable getGSTPayable(DateTime SDate, DateTime EDate)
        {
            try
            {
                var parSDate = new SqlParameter("@SDate", SDate);
                var parEDate = new SqlParameter("@EDate", EDate);
                return objDB.Database.SqlQuery<GSTPayable>("select * from [dbo].[udfGetGSTPayableByDaterange](@SDate,@EDate)", parSDate, parEDate).FirstOrDefault() ?? new GSTPayable();
            }
            catch
            {
                return new GSTPayable();
            }
        }
    }
}

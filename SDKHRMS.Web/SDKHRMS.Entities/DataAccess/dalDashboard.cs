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
                var parSDate = new SqlParameter("@SDate", SDate);
                var parEDate = new SqlParameter("@EDate", EDate);
                return objDB.Database.SqlQuery<FiscalWiseCount>("select * from [dbo].[udfGetFiscalWiseCount](@SDate,@EDate)", parSDate, parEDate).FirstOrDefault() ?? new FiscalWiseCount();
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

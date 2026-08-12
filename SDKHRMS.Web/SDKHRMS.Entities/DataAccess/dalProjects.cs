using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalProjects
    {
        private EFDBContext objDB = new EFDBContext();
        public ProjectViewModel GetProjectList(int PageNo, int PageSize, long ClientID, long ProjID, string Status)
        {
            ProjectViewModel objProject = new ProjectViewModel();
            var parClientID = new SqlParameter("@ClientID", DBNull.Value);
            if (ClientID != 0)
                parClientID.Value = ClientID;
            var parProjID = new SqlParameter("@ProjID", DBNull.Value);
            if (ProjID != 0)
                parProjID.Value = ProjID;
            var parStatus = new SqlParameter("@Status", DBNull.Value);
            if (!string.IsNullOrEmpty(Status))
                parStatus.Value = Status;
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            ////calling stored procedure to get paged data.
            objProject.ProjectViewList = objDB.Database.SqlQuery<ProjectView>("udspGetProjectListByNewFilter @ClientID,@ProjID,@Status,@Start,@PageSize,@TotalCount out",
                parClientID, parProjID, parStatus, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objProject.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objProject;
        }

        public ProjectView GetProjectDetailsByID(long ID)
        {
            try
            {
                var parProjID = new SqlParameter("@ProjID", ID);
                return objDB.Database.SqlQuery<ProjectView>("udspGetProjectDetailsByID @ProjID", parProjID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public ProjAmountTrans GetProjAmountTransByID(long ID)
        {
            try
            {
                var parProjID = new SqlParameter("@ProjID", ID);
                return objDB.Database.SqlQuery<ProjAmountTrans>("udspGetProjAmountTransByID @ProjID", parProjID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<TaxInvoiceView> GetTaxInvoiceListByProjID(long ID)
        {
            try
            {
                var parProjID = new SqlParameter("@ProjID", ID);
                return objDB.Database.SqlQuery<TaxInvoiceView>("udspGetTaxInvoiceListByProjID @ProjID", parProjID).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ProjPaymentReceivableView> GetPaymentReceivedByProjID(long ID)
        {
            try
            {
                var parProjID = new SqlParameter("@ProjID", ID);
                return objDB.Database.SqlQuery<ProjPaymentReceivableView>("udspGetPaymentReceivedListByProjID @ProjID", parProjID).ToList();

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public List<POView> GetPODetailsByProjID(long ID)
        {
            try
            {
                var parProjID = new SqlParameter("@ProjID", ID);
                return objDB.Database.SqlQuery<POView>("udspGetPODetailsByProjID @ProjID", parProjID).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public List<DirectPaymentView> GetExpenseByProjID(long ID)
        {
            try
            {
                var parProjID = new SqlParameter("@ProjID", ID);
                return objDB.Database.SqlQuery<DirectPaymentView>("udspGetDirectPaymentByProjID @ProjID", parProjID).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}

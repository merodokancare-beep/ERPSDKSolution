using SDKHRMS.Entities.Models;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalChallan
    {
        private EFDBContext objDB = new EFDBContext();

        public List<UnitDD> UnitDDList()
        {
            return objDB.utblMstUnits.Select(x => new UnitDD() { UnitID = x.UnitID, UnitName = x.UnitName }).OrderBy(x => x.UnitName).ToList();
        }
        public DeliveryChallanVM GetDeliveryChallanList(int PageNo, int PageSize, string SearchTerm, string FiscalYear, long Client)
        {
            try
            {
                DeliveryChallanVM model = new DeliveryChallanVM();
                var parFiscalYear = new SqlParameter("@FiscalYear", DBNull.Value);
                if (!string.IsNullOrEmpty(FiscalYear))
                    parFiscalYear.Value = FiscalYear;
                var parClient = new SqlParameter("@Client", DBNull.Value);
                if (Client != 0)
                    parClient.Value = Client;
                var parSearchTerm = new SqlParameter("@SearchTerm", DBNull.Value);
                if (!string.IsNullOrEmpty(SearchTerm))
                    parSearchTerm.Value = SearchTerm;
                var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
                var parEnd = new SqlParameter("@PageSize", PageSize);
                var spOutput = new SqlParameter
                {
                    ParameterName = "@TotalCount",
                    SqlDbType = System.Data.SqlDbType.BigInt,
                    Direction = System.Data.ParameterDirection.Output
                };
                //calling stored procedure to get paged data.
                model.ChallanKeyList = objDB.Database.SqlQuery<ChallanKeyView>("udspGetChallanListWithPaged @FiscalYear,@Client,@SearchTerm,@Start,@PageSize,@TotalCount out",
                   parFiscalYear, parClient, parSearchTerm, parStart, parEnd, spOutput).ToList();
                // setting total number of records
                model.TotalRecords = int.Parse(spOutput.Value.ToString());
                return model;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public string SaveDeliveryChallan(ChallanSave item)
        {
            try
            {
                ConvertListToDT objDT = new ConvertListToDT();
                var dt = objDT.ConvertIEnumerableToDataTable(item.ChallanItemList);
                var parItemDtls = new SqlParameter("@ItemDtlsList", dt);
                parItemDtls.SqlDbType = SqlDbType.Structured;
                parItemDtls.TypeName = "dbo.AddChallanItemDtlsTVP";

                var parChallanID = new SqlParameter("@ChallanID", DBNull.Value);
                if (item.ChallanKeyModel.ChallanID != null)
                    parChallanID.Value = item.ChallanKeyModel.ChallanID;
                var parClientID = new SqlParameter("@ClientID", item.ChallanKeyModel.VenderID);
                var parProjectID = new SqlParameter("@ProjectID", DBNull.Value);
                if (item.ChallanKeyModel.ProjectID != null)
                    parProjectID.Value = item.ChallanKeyModel.ProjectID;
                var parCHRefNo = new SqlParameter("@CHRefNo", DBNull.Value);
                if (!string.IsNullOrEmpty(item.ChallanKeyModel.CHRefNo))
                    parCHRefNo.Value = item.ChallanKeyModel.CHRefNo;
                var parCHDate = new SqlParameter("@CHDate", item.ChallanKeyModel.CHDate);
                var parCHToName = new SqlParameter("@CHToName", item.ChallanKeyModel.CHToName);
                var parClientAddress = new SqlParameter("@ClientAddress", item.ChallanKeyModel.ClientAddress);
                var parRemarks = new SqlParameter("@Remarks", item.ChallanKeyModel.Remarks);
                var parAddedBy = new SqlParameter("@AddedBy", item.ChallanKeyModel.AddedBy);
                return objDB.Database.SqlQuery<string>("udspDeliveryChallanSave @ItemDtlsList,@ChallanID,@ClientID,@ProjectID,@CHRefNo,@CHDate,@CHToName,@ClientAddress,@Remarks,@AddedBy",
                    parItemDtls, parChallanID, parClientID, parProjectID, parCHRefNo, parCHDate, parCHToName, parClientAddress, parRemarks, parAddedBy).FirstOrDefault();

            }
            catch (SqlException sqex)
            {
                throw sqex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public utblChallanKey GetChallanDetailsByID(string id)
        {
            try
            {
                return objDB.utblChallanKeys.FirstOrDefault(p => p.ChallanID == id);
            }
            catch (Exception ex) { throw ex; }
        }
        public List<utblChallanItem> GetChallanItemListByID(string id)
        {
            try
            {
                return objDB.utblChallanItems.Where(p => p.ChallanID == id).OrderBy(x => x.SlNo).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public string CancelledPO(string ID)
        {
            try
            {
                var parID = new SqlParameter("@ID", ID);
                return objDB.Database.SqlQuery<string>("udspChallanCancelledActive @ID", parID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IEnumerable<string> GetCHFiscalYearDD()
        {
            return objDB.Database.SqlQuery<string>("udspGetChallanFiscalYearDDList").ToList();
        }
        public ChallanKeyView GetDeliveryChallanDtlsByID(string ID)
        {
            try
            {
                var parID = new SqlParameter("@ID", ID);
                return objDB.Database.SqlQuery<ChallanKeyView>("udspGetDeliveryChallanDetailsByID  @ID", parID).FirstOrDefault();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public List<ChallanItemView> GetChallanItemList(string id)
        {
            try
            {
                var parID = new SqlParameter("@ID", id);
                return objDB.Database.SqlQuery<ChallanItemView>("udspGetDeliveryChallanItemList  @ID", parID).ToList();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

    }
}

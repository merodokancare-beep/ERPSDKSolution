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
    public class dalPurchaseSale
    {
        private EFDBContext objDB = new EFDBContext();
        public string SavePurchaseSale(utblPurchaseSale Item)
        {
            var parPSDate = new SqlParameter("@PSDate", Item.PurchaseSaleDate);
            var parInvoiceNo = new SqlParameter("@InvoiceNo", Item.PurchaseSaleInvoiceNo);
            var parVenderID = new SqlParameter("@VenderID", DBNull.Value);
            if(Item.VenderID!=null)
                parVenderID = new SqlParameter("@VenderID", Item.VenderID);
            var parClientID = new SqlParameter("@ClientID", DBNull.Value);
            if (Item.ClientID != null)
                parClientID = new SqlParameter("@ClientID", Item.ClientID);
            var parHSNSAC = new SqlParameter("@HSNSAC", Item.HSNSAC??"");
            var parIGST = new SqlParameter("@IGST", Item.IGST);
            var parCGST = new SqlParameter("@CGST", Item.CGST);
            var parSGST = new SqlParameter("@SGST", Item.SGST);
            var parAmount = new SqlParameter("@Amount", Item.TaxableAmount);
            var parPSType = new SqlParameter("@PSType", Item.PurchaseSaleType);
            var parDescription = new SqlParameter("@Description", Item.Description??"");
            var parIsIGST = new SqlParameter("@IsIGST", Item.IsIGST);
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            if (Item.PurchaseSaleID == 0)
            {
                return objDB.Database.SqlQuery<string>("udspPurchaseSaleInsert @PSDate,@InvoiceNo,@VenderID,@ClientID,@HSNSAC,@IGST,@CGST,@SGST,@Amount,@PSType,@Description,@IsIGST,@UserName",
                    parPSDate, parInvoiceNo, parVenderID, parClientID, parHSNSAC, parIGST, parCGST, parSGST, parAmount, parPSType, parDescription,parIsIGST, parUserName).FirstOrDefault();
            }
            else
            {
                var parPurchaseSaleID = new SqlParameter("@PurchaseSaleID", Item.PurchaseSaleID);
                return objDB.Database.SqlQuery<string>("udspPurchaseSaleUpdate @PurchaseSaleID, @PSDate,@InvoiceNo,@VenderID,@ClientID,@HSNSAC,@IGST,@CGST,@SGST,@Amount,@PSType,@Description,@IsIGST,@UserName",
                    parPurchaseSaleID,parPSDate, parInvoiceNo, parVenderID, parClientID, parHSNSAC, parIGST, parCGST, parSGST, parAmount, parPSType, parDescription,parIsIGST, parUserName).FirstOrDefault();
            }
        }
        public PurchaseSalesViewModel GetPurchaseSaleList(int PageNo, int PageSize, string SearchTerm,string Type)
        {
            PurchaseSalesViewModel objPS = new PurchaseSalesViewModel();
            var parSearchTerm = new SqlParameter("@SearchTerm", SearchTerm ?? "");
            var parType = new SqlParameter("@Type", Type);
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objPS.PurchaseSaleList = objDB.Database.SqlQuery<PurchaseSaleView>("udspGetPurchaseSaleList @SearchTerm,@Type,@Start,@PageSize,@TotalCount out", parSearchTerm,parType, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objPS.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objPS;
        }
        public List<VendorDDList> GetVendorDDList()
        {
            PurchaseSalesViewModel objPS = new PurchaseSalesViewModel();
            return objPS.VendorDDList = objDB.Database.SqlQuery<VendorDDList>("udspGetVendorDDList").ToList();
        }
        public List<ClientDDList> GetClientDDList()
        {
            PurchaseSalesViewModel objPS = new PurchaseSalesViewModel();
            return objPS.ClientDDList = objDB.Database.SqlQuery<ClientDDList>("udspGetClientDDList").ToList();
        }
        public utblPurchaseSale GetPurchaseSaleByID(long ID)
        {
            var parID = new SqlParameter("@ID", ID);//Not Used
            utblPurchaseSale objPS = objDB.Database.SqlQuery<utblPurchaseSale>("udspGetPurchaseSaleDetailsByID @ID", parID).FirstOrDefault();
            return objPS;
        }
        public PurchaseSalesViewModel GetPurchaseSaleReport(int Month, int Year)
        {
            PurchaseSalesViewModel objPS = new PurchaseSalesViewModel();
            var parMonth = new SqlParameter("@Month", Month);
            var parYear = new SqlParameter("@Year", Year);
            //calling stored procedure to get paged data.
            objPS.PurchaseSaleList = objDB.Database.SqlQuery<PurchaseSaleView>("udspGetPurchaseSaleReport @Month,@Year", parMonth,parYear).ToList();
            return objPS;
        }

        public string DeletePurchaseSale(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspPurchaseSaleDelete @ID", parID).FirstOrDefault();
        }

        #region Sale
        public PurchaseSalesViewModel GetSaleList(int PageNo, int PageSize, string SearchTerm)
        {
            PurchaseSalesViewModel objPS = new PurchaseSalesViewModel();
            var parSearchTerm = new SqlParameter("@ClientName", SearchTerm ?? "");//Not Used
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objPS.PurchaseSaleList = objDB.Database.SqlQuery<PurchaseSaleView>("udspGetSaleList @ClientName,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objPS.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objPS;
        }
        #endregion
    }
}

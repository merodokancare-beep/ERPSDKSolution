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
    public class dalInvoice
    {
        private EFDBContext objDB = new EFDBContext();
        public List<ItemDD> GetItemList(string q)
        {
            List<ItemDD> objItem = new List<ItemDD>();
            var parSearch = new SqlParameter("@Search", q);
            return objItem = objDB.Database.SqlQuery<ItemDD>("udspGetItemAutoSearch @Search", parSearch).ToList();
        }
        public List<VendorDDList> GetVendorDDList()
        {
            InvoiceViewModel obINV = new InvoiceViewModel();
            return obINV.VendorDDList = objDB.Database.SqlQuery<VendorDDList>("udspGetVendorDDList").ToList();
        }
        public ReferenecNoDtls GetInvoiceDetails(DateTime Datevalue)
        {
            InvoiceViewModel obINV = new InvoiceViewModel();
            var parBillingDate = new SqlParameter("@BillingDate", Datevalue);
            return obINV.InvoiveNoDetails = objDB.Database.SqlQuery<ReferenecNoDtls>("udspGetNewReferenceNumber @BillingDate", parBillingDate).FirstOrDefault();
        }
        public ProjectClientDtls GetProjClienByID(long ProjID)
        {
            var parProjID = new SqlParameter("@ProjID", ProjID);
            return objDB.Database.SqlQuery<ProjectClientDtls>("udspGetProjClientByID @ProjID", parProjID).FirstOrDefault();
        }
        #region Sale Invoice Dal
        public string SaveSaleInvoice(InvoiceAddViewModel item)
        {
            try
            {
                ConvertListToDT objDT = new ConvertListToDT();
                var dt = objDT.ConvertIEnumerableToDataTable(item.CustomInvoiceItemList);
                var parItemDtls = new SqlParameter("@ItemDtlsList", dt);
                parItemDtls.SqlDbType = SqlDbType.Structured;
                parItemDtls.TypeName = "dbo.AddItemDtlsTVP";

                var parInvoiceTo = new SqlParameter("@InvoiceTo", item.SaleInvoiceKeyModel.InvoiceTo);
                var parProjectID = new SqlParameter("@ProjectID", item.SaleInvoiceKeyModel.ProjectID);
                var parVenderID = new SqlParameter("@VenderID", item.SaleInvoiceKeyModel.VenderID);
                var parOrderNo = new SqlParameter("@OrderNo", item.SaleInvoiceKeyModel.OrderNo ?? "");
                var parOrderDate = new SqlParameter("@OrderDate", DBNull.Value);
                if (item.SaleInvoiceKeyModel.OrderDate != null)
                {
                    parOrderDate = new SqlParameter("@OrderDate", item.SaleInvoiceKeyModel.OrderDate);
                }
                var parInvoiceDate = new SqlParameter("@InvoiceDate", item.SaleInvoiceKeyModel.InvoiceDate);
                var parReferenceNo = new SqlParameter("@ReferenceNo", item.SaleInvoiceKeyModel.ReferenceNo);
                var parExcludingTaxAmt = new SqlParameter("@ExcludingTaxAmt", item.SaleInvoiceKeyModel.ExcludingTaxAmt);
                var parIGSTAmount = new SqlParameter("@IGSTAmount", item.SaleInvoiceKeyModel.IGSTAmount);
                var parCGSTAmount = new SqlParameter("@CGSTAmount", item.SaleInvoiceKeyModel.CGSTAmount);
                var parSGSTAmount = new SqlParameter("@SGSTAmount", item.SaleInvoiceKeyModel.SGSTAmount);
                var parIncludingTaxAmt = new SqlParameter("@IncludingTaxAmt", item.SaleInvoiceKeyModel.IncludingTaxAmt);
                var parAmountReceived = new SqlParameter("@AmountReceived", item.SaleInvoiceKeyModel.AdvanceReceived);//Adv Or Dec Amount
                var parReceivedRemarks = new SqlParameter("@ReceivedRemarks", item.SaleInvoiceKeyModel.ReceivedRemarks ?? "");//Adv Or Dec Remarks
                var parBalanceAmount = new SqlParameter("@BalanceAmount", item.SaleInvoiceKeyModel.BalanceAmount);
                var parUserName = new SqlParameter("@UserName", item.SaleInvoiceKeyModel.UserID);
                var parRemarks = new SqlParameter("@Remarks", item.SaleInvoiceKeyModel.Remarks);

                if (string.IsNullOrEmpty(item.SaleInvoiceKeyModel.SaleInvoiceID))
                {
                    return objDB.Database.SqlQuery<string>("udspSaleInvoiceInsert @ItemDtlsList,@InvoiceTo,@ProjectID,@VenderID,@OrderNo,@OrderDate,@InvoiceDate,@ReferenceNo,@ExcludingTaxAmt,@IGSTAmount,@CGSTAmount,@SGSTAmount,@IncludingTaxAmt,@AmountReceived,@ReceivedRemarks,@BalanceAmount,@UserName,@Remarks",
                        parItemDtls, parInvoiceTo, parProjectID, parVenderID, parOrderNo, parOrderDate, parInvoiceDate, parReferenceNo, parExcludingTaxAmt, parIGSTAmount, parCGSTAmount, parSGSTAmount, parIncludingTaxAmt, parAmountReceived, parReceivedRemarks, parBalanceAmount, parUserName, parRemarks).FirstOrDefault();
                }
                else
                {
                    var parSaleInvoiceID = new SqlParameter("@SaleInvoiceID", item.SaleInvoiceKeyModel.SaleInvoiceID);
                    return objDB.Database.SqlQuery<string>("udspSaleInvoiceUpdate  @SaleInvoiceID,@ItemDtlsList,@InvoiceTo,@ProjectID,@VenderID,@OrderNo,@OrderDate,@InvoiceDate,@ReferenceNo,@ExcludingTaxAmt,@IGSTAmount,@CGSTAmount,@SGSTAmount,@IncludingTaxAmt,@AmountReceived,@ReceivedRemarks,@BalanceAmount,@UserName,@Remarks",
                        parSaleInvoiceID, parItemDtls, parInvoiceTo, parProjectID, parVenderID, parOrderNo, parOrderDate, parInvoiceDate, parReferenceNo, parExcludingTaxAmt, parIGSTAmount, parCGSTAmount, parSGSTAmount, parIncludingTaxAmt, parAmountReceived, parReceivedRemarks, parBalanceAmount, parUserName, parRemarks).FirstOrDefault();
                }
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
        public SaleInvoiceVM GetSaleInvoiceList(int PageNo, int PageSize, string SearchTerm, int YearNo, int MonNo, long Client)
        {
            try
            {
                SaleInvoiceVM objInv = new SaleInvoiceVM();
                var parYearNo = new SqlParameter("@YearNo", DBNull.Value);
                if (YearNo != 0)
                    parYearNo.Value = YearNo;
                var parMonNo = new SqlParameter("@MonNo", DBNull.Value);
                if (MonNo != 0)
                    parMonNo.Value = MonNo;
                var parClient = new SqlParameter("@Client", DBNull.Value);
                if (Client != 0)
                    parClient.Value = Client;
                var parSearchTerm = new SqlParameter("@SearchTerm", SearchTerm ?? "");
                var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
                var parEnd = new SqlParameter("@PageSize", PageSize);
                var spOutput = new SqlParameter
                {
                    ParameterName = "@TotalCount",
                    SqlDbType = System.Data.SqlDbType.BigInt,
                    Direction = System.Data.ParameterDirection.Output
                };
                //calling stored procedure to get paged data.
                objInv.SaleInvoiceKeyViewList = objDB.Database.SqlQuery<SaleInvoiceKeyView>("udspGetSaleInvoiceList  @YearNo,@MonNo,@Client, @SearchTerm,@Start,@PageSize,@TotalCount out",
                    parYearNo, parMonNo, parClient, parSearchTerm, parStart, parEnd, spOutput).ToList();
                // setting total number of records
                objInv.TotalRecords = int.Parse(spOutput.Value.ToString());
                return objInv;
            }
            catch (Exception e)
            {
                throw e;
            }


        }
        public utblSaleInvoiceKey GetSaleInvDetailsByID(string id)
        {
            utblSaleInvoiceKey obINV = objDB.utblSaleInvoiceKeys.FirstOrDefault(p => p.SaleInvoiceID == id);
            return obINV;
        }
        public List<CustomInvoiceItems> GetSaleInvItemListByID(string id)
        {
            try
            {
                List<CustomInvoiceItems> obINV = new List<CustomInvoiceItems>();
                var parInvID = new SqlParameter("@SaleInvID", id);
                return obINV = objDB.Database.SqlQuery<CustomInvoiceItems>("udspGetSaleInvItemList @SaleInvID", parInvID).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public List<ItemsView> GetItemListByID(string id, string Type)
        {
            try
            {
                //List<CustomInvoiceItems> obINV = new List<CustomInvoiceItems>();
                var parID = new SqlParameter("@ID", id);
                var parType = new SqlParameter("@Type", Type);// Invoiceor Purchase
                return objDB.Database.SqlQuery<ItemsView>("udspGetItemsListByID @ID, @Type", parID, parType).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public IEnumerable<YearDD> GetSaleYearDD()
        {
            return objDB.Database.SqlQuery<YearDD>("udspGetSaleYearDDList").ToList();
        }
        public List<utblSaleInvoiceKey> GetSaleInvoiceList()
        {
            return objDB.utblSaleInvoiceKeys.OrderByDescending(x => x.InvoiceDate).ToList();
        }
        public SaleInvoiceKeyView GetSaleInvoceDtlsByID(string ID)
        {
            try
            {
                var parID = new SqlParameter("@ID", ID);
                return objDB.Database.SqlQuery<SaleInvoiceKeyView>("udspGetSaleInvoiceDetails  @ID", parID).FirstOrDefault();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public string CancelledSaleInvoice(string ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspCancelledActiveSaleInvoice @ID", parID).FirstOrDefault();
        }
        #endregion

        #region Purchase Invoice Dal
        public string SavePurchaseInvoice(PurchaseAddViewModel item)
        {
            try
            {
                ConvertListToDT objDT = new ConvertListToDT();
                var dt = objDT.ConvertIEnumerableToDataTable(item.CustomInvoiceItemList);
                var parItemDtls = new SqlParameter("@ItemDtlsList", dt);
                parItemDtls.SqlDbType = SqlDbType.Structured;
                parItemDtls.TypeName = "dbo.AddItemDtlsTVP";

                var parProjectID = new SqlParameter("@ProjectID", DBNull.Value);
                if (item.PurchaseInvoiceKeyModel.ProjectID != null)
                    parProjectID.Value = item.PurchaseInvoiceKeyModel.ProjectID;
                var parVenderID = new SqlParameter("@VenderID", item.PurchaseInvoiceKeyModel.VenderID);
                var parPurchaseDate = new SqlParameter("@PurchaseDate", item.PurchaseInvoiceKeyModel.PurchaseDate);
                var parBillNo = new SqlParameter("@BillNo", DBNull.Value);
                if (!string.IsNullOrEmpty(item.PurchaseInvoiceKeyModel.BillNo))
                    parBillNo.Value = item.PurchaseInvoiceKeyModel.BillNo;
                var parExcludingTaxAmt = new SqlParameter("@ExcludingTaxAmt", item.PurchaseInvoiceKeyModel.ExcludingTaxAmt);
                var parIGSTAmount = new SqlParameter("@IGSTAmount", item.PurchaseInvoiceKeyModel.IGSTAmount);
                var parCGSTAmount = new SqlParameter("@CGSTAmount", item.PurchaseInvoiceKeyModel.CGSTAmount);
                var parSGSTAmount = new SqlParameter("@SGSTAmount", item.PurchaseInvoiceKeyModel.SGSTAmount);
                var parIncludingTaxAmt = new SqlParameter("@IncludingTaxAmt", item.PurchaseInvoiceKeyModel.IncludingTaxAmt);
                var parAmountPaid = new SqlParameter("@AmountPaid", item.PurchaseInvoiceKeyModel.AmountPaid);
                var parBalanceAmount = new SqlParameter("@BalanceAmount", item.PurchaseInvoiceKeyModel.BalanceAmount);
                var parUploadBill = new SqlParameter("@UploadBill", item.PurchaseInvoiceKeyModel.UploadBill ?? "");
                var parUserName = new SqlParameter("@UserName", item.PurchaseInvoiceKeyModel.UserID);
                var parRemarks = new SqlParameter("@Remarks", item.PurchaseInvoiceKeyModel.Remarks);
                //Modified
                var parPORefNo = new SqlParameter("@PORefNo", DBNull.Value);
                if (!string.IsNullOrEmpty(item.PurchaseInvoiceKeyModel.PORefNo))
                    parPORefNo.Value = item.PurchaseInvoiceKeyModel.PORefNo;
                var parPOType = new SqlParameter("@POType", item.PurchaseInvoiceKeyModel.POType);
                var parShipTo = new SqlParameter("@ShipTo", item.PurchaseInvoiceKeyModel.ShipTo ?? "");
                var parTermsConditions = new SqlParameter("@TermsConditions", DBNull.Value);
                if (!string.IsNullOrEmpty(item.PurchaseInvoiceKeyModel.TermsConditions))
                    parTermsConditions.Value = item.PurchaseInvoiceKeyModel.TermsConditions;
                if (string.IsNullOrEmpty(item.PurchaseInvoiceKeyModel.PurchaseInvoiceID))
                {
                    return objDB.Database.SqlQuery<string>("udspPurchaseInvoiceInsert @ItemDtlsList,@ProjectID,@VenderID,@PurchaseDate,@BillNo,@ExcludingTaxAmt,@IGSTAmount,@CGSTAmount,@SGSTAmount,@IncludingTaxAmt,@AmountPaid,@BalanceAmount,@UploadBill,@UserName,@Remarks,@PORefNo,@POType,@ShipTo,@TermsConditions",
                        parItemDtls, parProjectID, parVenderID, parPurchaseDate, parBillNo, parExcludingTaxAmt, parIGSTAmount, parCGSTAmount, parSGSTAmount, parIncludingTaxAmt, parAmountPaid, parBalanceAmount, parUploadBill, parUserName, parRemarks, parPORefNo, parPOType, parShipTo, parTermsConditions).FirstOrDefault();
                }
                else
                {
                    var parPurchaseInvoiceID = new SqlParameter("@PurchaseInvoiceID", item.PurchaseInvoiceKeyModel.PurchaseInvoiceID);
                    return objDB.Database.SqlQuery<string>("udspPurchaseInvoiceUpdate  @PurchaseInvoiceID,@ItemDtlsList,@ProjectID,@VenderID,@PurchaseDate,@BillNo,@ExcludingTaxAmt,@IGSTAmount,@CGSTAmount,@SGSTAmount,@IncludingTaxAmt,@AmountPaid,@BalanceAmount,@UploadBill,@UserName,@Remarks,@PORefNo,@POType,@ShipTo,@TermsConditions",
                        parPurchaseInvoiceID, parItemDtls, parProjectID, parVenderID, parPurchaseDate, parBillNo, parExcludingTaxAmt, parIGSTAmount, parCGSTAmount, parSGSTAmount, parIncludingTaxAmt, parAmountPaid, parBalanceAmount, parUploadBill, parUserName, parRemarks, parPORefNo, parPOType, parShipTo, parTermsConditions).FirstOrDefault();
                }
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
        public PurchaseInvoiceVM GetPurchaseInvoiceList(int PageNo, int PageSize, string SearchTerm, int YearNo, int MonNo, long Vendor)
        {
            try
            {
                PurchaseInvoiceVM objInv = new PurchaseInvoiceVM();
                var parYearNo = new SqlParameter("@YearNo", DBNull.Value);
                if (YearNo != 0)
                    parYearNo.Value = YearNo;
                var parMonNo = new SqlParameter("@MonNo", DBNull.Value);
                if (MonNo != 0)
                    parMonNo.Value = MonNo;
                var parVendor = new SqlParameter("@Vendor", DBNull.Value);
                if (Vendor != 0)
                    parVendor.Value = Vendor;
                var parSearchTerm = new SqlParameter("@SearchTerm", SearchTerm ?? "");
                var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
                var parEnd = new SqlParameter("@PageSize", PageSize);
                var spOutput = new SqlParameter
                {
                    ParameterName = "@TotalCount",
                    SqlDbType = System.Data.SqlDbType.BigInt,
                    Direction = System.Data.ParameterDirection.Output
                };
                //calling stored procedure to get paged data.
                objInv.PurchaseInvoiceKeyViewList = objDB.Database.SqlQuery<PurchaseInvoiceKeyView>("udspGetPurchaseInvoiceList @YearNo,@MonNo,@Vendor,@SearchTerm,@Start,@PageSize,@TotalCount out",
                   parYearNo, parMonNo, parVendor, parSearchTerm, parStart, parEnd, spOutput).ToList();
                // setting total number of records
                objInv.TotalRecords = int.Parse(spOutput.Value.ToString());
                return objInv;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public utblPurchaseInvoiceKey GetPurchaseInvDetailsByID(string id)
        {
            utblPurchaseInvoiceKey obINV = objDB.utblPurchaseInvoiceKeys.FirstOrDefault(p => p.PurchaseInvoiceID == id);
            return obINV;
        }
        public List<CustomInvoiceItems> GetPurchaseInvItemListByID(string id)
        {
            try
            {
                List<CustomInvoiceItems> obINV = new List<CustomInvoiceItems>();
                var parInvID = new SqlParameter("@PurchaseInvID", id);
                return obINV = objDB.Database.SqlQuery<CustomInvoiceItems>("udspGetPurchaseInvItemList @PurchaseInvID", parInvID).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public string CancelledPO(string ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspCancelledActivePO @ID", parID).FirstOrDefault();
        }
        public string MarkForPayment(string ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspMarkForPaymentPO @ID", parID).FirstOrDefault();
        }

        public IEnumerable<YearDD> GetPurchaseYearDD()
        {
            return objDB.Database.SqlQuery<YearDD>("udspGetPurchaseYearDDList").ToList();
        }
        public List<utblPurchaseInvoiceKey> GetPurchaseInvoiceList()
        {
            return objDB.utblPurchaseInvoiceKeys.OrderByDescending(x => x.PurchaseDate).ToList();
        }

        public string DeletePO(string ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspDeletePODetails @ID", parID).FirstOrDefault();
        }
        #endregion

        public InvoicePurchaseGst GetInvPurchaseGST(string FiscalYear, DateTime DtVal)
        {
            try
            {
                var parFiscalYear = new SqlParameter("@FiscalYear", FiscalYear);
                var parDtVal = new SqlParameter("@DtVal", DtVal);
                return objDB.Database.SqlQuery<InvoicePurchaseGst>("udspGetInvPurchaseGST @FiscalYear,@DtVal", parFiscalYear, parDtVal).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string GetMonthlySalesGSTList(DateTime DtVal)
        {
            try
            {
                var parDtVal = new SqlParameter("@DtVal", DtVal);
                return objDB.Database.SqlQuery<string>("udspGetMonthlySaleGSTList @DtVal", parDtVal).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string GetMonthlyPurchaseGSTList(DateTime DtVal)
        {
            try
            {
                var parDtVal = new SqlParameter("@DtVal", DtVal);
                return objDB.Database.SqlQuery<string>("udspGetMonthlyPurchaseGSTList @DtVal", parDtVal).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

using SDKHRMS.Entities.Models;
using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalPayment
    {
        private EFDBContext objDB = new EFDBContext();
        #region Manage Payment
        public PaymentViewModel GetPaymentList(int PageNo, int PageSize, string SearchTerm, string PayType)
        {
            PaymentViewModel objpay = new PaymentViewModel();
            var parSearchTerm = new SqlParameter("@ExpType", SearchTerm ?? "");
            var parPaymentType = new SqlParameter("@PaymentType", PayType);
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objpay.PaymentViewList = objDB.Database.SqlQuery<PaymentView>("udspGetPaymentPages @ExpType,@PaymentType,@Start,@PageSize,@TotalCount out",
                parSearchTerm, parPaymentType, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objpay.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objpay;
        }
        public string SavePayments(utblPaymentDetail Item)
        {
            try
            {
                var parExpTypeID = new SqlParameter("@ExpTypeID", Item.ExpenseTypeID);
                var parPaymentDate = new SqlParameter("@PaymentDate", Item.PaymentDate);
                var parPaymentAmt = new SqlParameter("@PaymentAmt", Item.PaymentAmt);
                var parPaymentMode = new SqlParameter("@PaymentMode", Item.PaymentMode);

                var parBankID = new SqlParameter("@BankID", DBNull.Value);
                if (Item.BankID.HasValue)
                    parBankID.Value = Item.BankID;
                var parChequeTransNo = new SqlParameter("@ChequeTransNo", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.ChequeTransNo))
                    parChequeTransNo.Value = Item.ChequeTransNo;
                var parFilePath = new SqlParameter("@FilePath", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.PaymentFile))
                    parFilePath.Value = Item.PaymentFile;

                var parProjectID = new SqlParameter("@ProjectID", DBNull.Value);
                if (Item.ProjectID.HasValue)
                    parProjectID.Value = Item.ProjectID;
                var parVendorID = new SqlParameter("@VendorID", DBNull.Value);
                if (Item.VendorID.HasValue)
                    parVendorID.Value = Item.VendorID;
                var parPaymentType = new SqlParameter("@PaymentType", Item.PaymentType);
                var parRemarks = new SqlParameter("@Remarks", Item.Remarks);
                var parUserName = new SqlParameter("@UserName", Item.UserID);
                if (string.IsNullOrEmpty(Item.PaymentID))
                {
                    return objDB.Database.SqlQuery<string>("udspPaymentsInsert @ExpTypeID,@PaymentDate,@PaymentAmt,@PaymentMode,@BankID,@ChequeTransNo,@FilePath,@ProjectID,@VendorID,@PaymentType,@Remarks,@UserName",
                        parExpTypeID, parPaymentDate, parPaymentAmt, parPaymentMode, parBankID, parChequeTransNo, parFilePath, parProjectID, parVendorID, parPaymentType, parRemarks, parUserName).FirstOrDefault();
                }
                else
                {
                    var parPaymentID = new SqlParameter("@PaymentID", Item.PaymentID);
                    return objDB.Database.SqlQuery<string>("udspPaymentsUpdate @PaymentID, @ExpTypeID,@PaymentDate,@PaymentAmt,@PaymentMode,@BankID,@ChequeTransNo,@FilePath,@ProjectID,@VendorID,@PaymentType,@Remarks,@UserName",
                      parPaymentID, parExpTypeID, parPaymentDate, parPaymentAmt, parPaymentMode, parBankID, parChequeTransNo, parFilePath, parProjectID, parVendorID, parPaymentType, parRemarks, parUserName).FirstOrDefault();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public utblPaymentDetail GetPaymentByID(string ID)
        {
            return objDB.utblPaymentDetails.FirstOrDefault(p => p.PaymentID == ID);
        }
        #endregion

        #region Direct Payment Receivalbe
        public string SavePaymentReceivable(utblPaymentReceivable Item)
        {
            try
            {
                var parReceivedID = new SqlParameter("@ReceivedID", Item.ReceivedID);
                var parExpTypeID = new SqlParameter("@ExpTypeID", Item.ExpenseTypeID);
                var parAmtReceived = new SqlParameter("@AmtReceived", Item.AmtReceived);
                var parReceivedDate = new SqlParameter("@ReceivedDate", Item.ReceivedDate);
                var parReceivedMode = new SqlParameter("@ReceivedMode", Item.ReceivedMode);

                var parBankID = new SqlParameter("@BankID", DBNull.Value);
                if (Item.BankID.HasValue)
                    parBankID.Value = Item.BankID;

                var parTransactionNo = new SqlParameter("@TransactionNo", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.TransactionNo))
                    parTransactionNo.Value = Item.TransactionNo;

                var parFilePath = new SqlParameter("@FilePath", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.UploadedFile))
                    parFilePath.Value = Item.UploadedFile;

                var parRemarks = new SqlParameter("@Remarks", Item.Remarks);
                var parUserName = new SqlParameter("@UserName", Item.AddedBy);
                return objDB.Database.SqlQuery<string>("udspPaymentReceivedSave @ReceivedID, @ExpTypeID,@AmtReceived,@ReceivedDate,@ReceivedMode,@BankID,@TransactionNo,@FilePath,@Remarks,@UserName",
                  parReceivedID, parExpTypeID, parAmtReceived, parReceivedDate, parReceivedMode, parBankID, parTransactionNo, parFilePath, parRemarks, parUserName).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IEnumerable<YearDD> GetReceivePaymentYearDD()
        {
            try
            {
                return objDB.Database.SqlQuery<YearDD>("Select * from [dbo].[udfGetReceivePaymentYearDD]()").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public PaymentReceivedVM GetReceiveDirectPayment(int PageNo, int PageSize, int YearNo = 0, int MonNo = 0, long ExpHeadID = 0)
        {
            try
            {
                PaymentReceivedVM objpay = new PaymentReceivedVM();
                var parExpType = new SqlParameter("@ExpType", DBNull.Value);
                if (ExpHeadID != 0)
                    parExpType.Value = ExpHeadID;
                var parYearNo = new SqlParameter("@YearNo", DBNull.Value);
                if (YearNo != 0)
                    parYearNo.Value = YearNo;
                var parMonNo = new SqlParameter("@MonNo", DBNull.Value);
                if (MonNo != 0)
                    parMonNo.Value = MonNo;
                var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
                var parEnd = new SqlParameter("@PageSize", PageSize);
                var spOutput = new SqlParameter
                {
                    ParameterName = "@TotalCount",
                    SqlDbType = System.Data.SqlDbType.BigInt,
                    Direction = System.Data.ParameterDirection.Output
                };
                //calling stored procedure to get paged data.
                objpay.ReceivePayment = objDB.Database.SqlQuery<PaymentReceivableView>("udspGetReceiveDirectPaymentPages @ExpType,@YearNo,@MonNo,@Start,@PageSize,@TotalCount out",
                    parExpType, parYearNo, parMonNo, parStart, parEnd, spOutput).ToList();
                // setting total number of records
                objpay.TotalRecords = int.Parse(spOutput.Value.ToString());
                return objpay;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public utblPaymentReceivable GetReceiveDirectPaymentByID(long id)
        {
            return objDB.utblPaymentReceivables.FirstOrDefault(p => p.ReceivedID == id);
        }
        public string Delete(long id)
        {
            try
            {
                var parID = new SqlParameter("@ID", id);
                return objDB.Database.SqlQuery<string>("udspDeleteReceiveDirectPayment @ID", parID).FirstOrDefault();

            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
        #endregion

        #region Project Payment Received
        public utblProjPaymentReceivable GetProjPaymentReceiveByID(long id)
        {
            return objDB.utblProjPaymentReceivables.FirstOrDefault(p => p.ProjPaymentReceiveID == id);
        }
        public string SaveProjPaymentReceive(utblProjPaymentReceivable Item)
        {
            try
            {
                var parReceivedID = new SqlParameter("@ReceivedID", Item.ProjPaymentReceiveID);
                var parProjectID = new SqlParameter("@ProjectID", Item.ProjectID);
                var parBankID = new SqlParameter("@BankID", DBNull.Value);
                if (Item.BankID.HasValue)
                    parBankID.Value = Item.BankID;
                var parReceivedDate = new SqlParameter("@ReceivedDate", Item.ReceivedDate);
                var parReceivedMode = new SqlParameter("@ReceivedMode", Item.ReceivedMode);
                var parRemarks = new SqlParameter("@Remarks", Item.Remarks);
                var parNetAmt = new SqlParameter("@NetAmt", Item.NetAmtReceived);
                var parTDSAmt = new SqlParameter("@TDSAmt", Item.TDSDeductionAmt);
                var parGSTAmt = new SqlParameter("@GSTAmt", Item.GstDeductionAmt);
                var parSDAmt = new SqlParameter("@SDAmt", Item.SecurityDepositAmt);
                var parOtherAmt = new SqlParameter("@OtherAmt", Item.OtherDeductionAmt);
                var parIsAdvance = new SqlParameter("@IsAdvance", Item.IsAdvance);
                var parFilePath = new SqlParameter("@FilePath", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.UploadedFile))
                    parFilePath.Value = Item.UploadedFile;
                var parSalInv = new SqlParameter("@SalInv", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.SaleInvoiceID))
                    parSalInv.Value = Item.SaleInvoiceID;

                return objDB.Database.SqlQuery<string>("udspProjPaymentReceivedSave @ReceivedID, @ProjectID,@BankID,@ReceivedDate,@ReceivedMode,@Remarks,@NetAmt,@TDSAmt,@GSTAmt,@SDAmt,@OtherAmt,@IsAdvance,@FilePath,@SalInv",
                  parReceivedID, parProjectID, parBankID, parReceivedDate, parReceivedMode, parRemarks, parNetAmt, parTDSAmt, parGSTAmt, parSDAmt, parOtherAmt, parIsAdvance, parFilePath, parSalInv).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IEnumerable<YearDD> GetProjPaymentReceiveYearDD()
        {
            try
            {
                return objDB.Database.SqlQuery<YearDD>("Select * from [dbo].[udfGetProjPaymentReceiveYearDD]()").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public ProjPaymentReceivedVM GetProjPaymentReceived(int PageNo, int PageSize, int YearNo = 0, int MonNo = 0, long Project = 0)
        {
            try
            {
                ProjPaymentReceivedVM objpay = new ProjPaymentReceivedVM();
                var parProject = new SqlParameter("@Project", DBNull.Value);
                if (Project != 0)
                    parProject.Value = Project;
                var parYearNo = new SqlParameter("@YearNo", DBNull.Value);
                if (YearNo != 0)
                    parYearNo.Value = YearNo;
                var parMonNo = new SqlParameter("@MonNo", DBNull.Value);
                if (MonNo != 0)
                    parMonNo.Value = MonNo;
                var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
                var parEnd = new SqlParameter("@PageSize", PageSize);
                var spOutput = new SqlParameter
                {
                    ParameterName = "@TotalCount",
                    SqlDbType = System.Data.SqlDbType.BigInt,
                    Direction = System.Data.ParameterDirection.Output
                };
                //calling stored procedure to get paged data.
                objpay.ProjPaymentReceivable = objDB.Database.SqlQuery<ProjPaymentReceivableView>("udspGetProjPaymentReceivedPages @Project,@YearNo,@MonNo,@Start,@PageSize,@TotalCount out",
                    parProject, parYearNo, parMonNo, parStart, parEnd, spOutput).ToList();
                // setting total number of records
                objpay.TotalRecords = int.Parse(spOutput.Value.ToString());
                return objpay;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public string DeleteProjPaymentReceive(long id)
        {

            try
            {
                var parID = new SqlParameter("@ID", id);
                return objDB.Database.SqlQuery<string>("udspDeleteProjPaymentReceive @ID", parID).FirstOrDefault();

            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
            //try
            //{
            //    utblProjPaymentReceivable curObj = objDB.utblProjPaymentReceivables.Find(id);
            //    objDB.utblProjPaymentReceivables.Remove(curObj);
            //    objDB.SaveChangesAsync();
            //    return "Success: Record Removed";
            //}
            //catch (SqlException ex)
            //{
            //    if (ex.Errors.Count > 0) // Assume the interesting stuff is in the first error
            //    {
            //        switch (ex.Errors[0].Number)
            //        {
            //            case 547: // Foreign Key violation
            //                return "This record has dependencies on other records, so cannot be removed.";
            //            default:
            //                return "Error: " + ex.Message;
            //        }
            //    }
            //    return "Error while operation. Error Message: " + ex.Message;
            //}
            //catch (Exception ex)
            //{
            //    return "Error: " + ex.Message;
            //}
        }


        #endregion

        #region Po Payment Released
        public POPaymentVM GetPOPaymentList(int PageNo, int PageSize, string SearchTerm, long Vendor, string Status)
        {
            try
            {
                POPaymentVM objpay = new POPaymentVM();
                var parVendor = new SqlParameter("@Vendor", DBNull.Value);
                if (Vendor != 0)
                    parVendor.Value = Vendor;
                var parStatus = new SqlParameter("@Status", DBNull.Value);
                if (!string.IsNullOrEmpty(Status))
                    parStatus.Value = Status;
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
                objpay.POPaymentList = objDB.Database.SqlQuery<POPaymentView>("udspGetPOPaymentListPages @Vendor,@Status,@SearchTerm,@Start,@PageSize,@TotalCount out",
                    parVendor, parStatus, parSearchTerm, parStart, parEnd, spOutput).ToList();
                // setting total number of records
                objpay.TotalRecords = int.Parse(spOutput.Value.ToString());
                return objpay;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public POPaymentView GetPOPaymentDtlsByID(string id)
        {
            try
            {
                var parID = new SqlParameter("@ID", id);
                return objDB.Database.SqlQuery<POPaymentView>("udspGetPOPaymentDtlsByID @ID", parID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public List<PaymentReleaseView> GetPaymentTransByPOID(string id)
        {

            var parID = new SqlParameter("@ID", id);
            //var parPaymentFor = new SqlParameter("@PaymentFor", PaymentFor);
            return objDB.Database.SqlQuery<PaymentReleaseView>("udspGetPOPaymentReleaseByID @ID", parID).ToList();
        }
        public string SavePaymentRelease(utblPaymentReleasedTran Item, long ExpType)
        {
            try
            {
                //var parPaymentID = new SqlParameter("@PaymentID", Item.PaymentID);
                var parPaymentDate = new SqlParameter("@PaymentDate", Item.PaymentDate);
                var parPaymentAmt = new SqlParameter("@PaymentAmt", Item.PaymentAmt);
                var parPaymentMode = new SqlParameter("@PaymentMode", Item.PaymentMode);
                var parPOID = new SqlParameter("@POID", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.PurchaseInvoiceID))
                    parPOID.Value = Item.PurchaseInvoiceID;
                var parDirectPaymentID = new SqlParameter("@DirectPaymentID", DBNull.Value);
                if (Item.DirectPaymentID != null)
                    parDirectPaymentID.Value = Item.DirectPaymentID;
                var parBankID = new SqlParameter("@BankID", DBNull.Value);
                if (Item.BankID.HasValue)
                    parBankID.Value = Item.BankID;

                var parTransactionNo = new SqlParameter("@TransactionNo", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.PaymentTransNo))
                    parTransactionNo.Value = Item.PaymentTransNo;

                var parFilePath = new SqlParameter("@FilePath", DBNull.Value);
                if (!string.IsNullOrEmpty(Item.UploadedFile))
                    parFilePath.Value = Item.UploadedFile;

                var parRemarks = new SqlParameter("@Remarks", Item.Remarks);
                var parUserName = new SqlParameter("@UserName", Item.AddedBy);
                var parExpType = new SqlParameter("@ExpType", ExpType);
                return objDB.Database.SqlQuery<string>("udspPaymentReleaseSave  @PaymentDate,@PaymentAmt,@PaymentMode,@POID,@DirectPaymentID,@BankID,@TransactionNo,@FilePath,@Remarks,@UserName,@ExpType",
                  parPaymentDate, parPaymentAmt, parPaymentMode, parPOID, parDirectPaymentID, parBankID, parTransactionNo, parFilePath, parRemarks, parUserName, parExpType).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string DeletePOPaymentTrans(long id)
        {
            try
            {
                var parID = new SqlParameter("@ID", id);
                return objDB.Database.SqlQuery<string>("udspDeletePoPaymentTransByID @ID", parID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region Direct Payment Released
        public DirectPaymentVM GetDirectPayment(int PageNo, int PageSize, int YearNo, int MonNo, long ExpHeadID, string Status)
        {
            try
            {
                DirectPaymentVM objpay = new DirectPaymentVM();
                var parExpType = new SqlParameter("@ExpType", DBNull.Value);
                if (ExpHeadID != 0)
                    parExpType.Value = ExpHeadID;
                var parYearNo = new SqlParameter("@YearNo", DBNull.Value);
                if (YearNo != 0)
                    parYearNo.Value = YearNo;
                var parMonNo = new SqlParameter("@MonNo", DBNull.Value);
                if (MonNo != 0)
                    parMonNo.Value = MonNo;
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
                //calling stored procedure to get paged data.
                objpay.DirectPayment = objDB.Database.SqlQuery<DirectPaymentView>("udspGetDirectPaymentListPages @ExpType,@YearNo,@MonNo,@Status,@Start,@PageSize,@TotalCount out",
                    parExpType, parYearNo, parMonNo, parStatus, parStart, parEnd, spOutput).ToList();
                // setting total number of records
                objpay.TotalRecords = int.Parse(spOutput.Value.ToString());
                return objpay;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public utblDirectPayment GetDirectPaymentByID(long id)
        {
            try
            {
                return objDB.utblDirectPayments.FirstOrDefault(p => p.DirectPaymentID == id);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public IEnumerable<YearDD> GetDirectPaymentYearDD()
        {
            try
            {
                return objDB.Database.SqlQuery<YearDD>("Select * from [dbo].[udfGetDirectPaymentYearDD]()").ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string SaveDirectPayment(utblDirectPayment Item)
        {
            try
            {
                var parDirectPaymentID = new SqlParameter("@DirectPaymentID", Item.DirectPaymentID);
                var parExpenseTypeID = new SqlParameter("@ExpenseTypeID", Item.ExpenseTypeID);
                var parProjectID = new SqlParameter("@ProjectID", DBNull.Value);
                if (Item.ProjectID != null)
                    parProjectID.Value = Item.ProjectID;
                var parPaymentDate = new SqlParameter("@PaymentDate", Item.PaymentDate);
                var parPaymentAmt = new SqlParameter("@PaymentAmt", Item.PaymentAmt);
                var parPurpose = new SqlParameter("@Purpose", Item.Purpose);
                var parRemarks = new SqlParameter("@Remarks", Item.Remarks);
                var parUserName = new SqlParameter("@UserName", Item.AddedBy);
                return objDB.Database.SqlQuery<string>("udspDirectPaymentSave  @DirectPaymentID,@ExpenseTypeID,@ProjectID,@PaymentDate,@PaymentAmt,@Purpose,@Remarks,@UserName",
                  parDirectPaymentID, parExpenseTypeID, parProjectID, parPaymentDate, parPaymentAmt, parPurpose, parRemarks, parUserName).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string DeleteDirectPaymentByID(long id)
        {
            try
            {
                var parID = new SqlParameter("@ID", id);
                return objDB.Database.SqlQuery<string>("udspDeleteDirectPaymentByID @ID", parID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DirectPaymentView GetDirectPaymentDtlsByID(long id)
        {
            try
            {
                var parID = new SqlParameter("@ID", id);
                return objDB.Database.SqlQuery<DirectPaymentView>("udspGetDirectPaymentDtlsByID @ID", parID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public string ApprovedPayment(long ID)
        {
            try
            {
                var parID = new SqlParameter("@ID", ID);
                return objDB.Database.SqlQuery<string>("udspApprovedPayment @ID", parID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string DeclinedPayment(long ID)
        {
            try
            {
                var parID = new SqlParameter("@ID", ID);
                return objDB.Database.SqlQuery<string>("udspDeclinedPayment @ID", parID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<PaymentReleaseView> GetPaymentTransByID(long id)
        {

            var parID = new SqlParameter("@ID", id);
            return objDB.Database.SqlQuery<PaymentReleaseView>("udspGetDirectPaymentReleaseByID @ID", parID).ToList();
        }
        #endregion
    }
}

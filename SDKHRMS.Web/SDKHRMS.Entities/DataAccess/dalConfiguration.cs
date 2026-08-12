using SDKHRMS.Entities.Models;
using SDKHRMS.Entities.ViewModels;
using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.DataAccess
{
    public class dalConfiguration
    {
        private EFDBContext objDB = new EFDBContext();
        #region Vendor Configuration
        public VendorClientVM getVendorList(int PageNo, int PageSize, string SearchTerm)
        {
            VendorClientVM objVendor = new VendorClientVM();
            var parSearchTerm = new SqlParameter("@VenderName", DBNull.Value);
            if (!(SearchTerm == "" || SearchTerm == null))
                parSearchTerm = new SqlParameter("@VenderName", SearchTerm);
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objVendor.VendorDetailsList = objDB.Database.SqlQuery<utblMstVendorDetail>("udspgetVendorList @VenderName,@Start,@PageSize,@TotalCount out",
                parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objVendor.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objVendor;
        }
        public string SaveClientVendor(utblMstVendorDetail Item)
        {
            Item.VenderName = Regex.Replace(Item.VenderName.Trim(), @"\s+", " ");
            var parVenderName = new SqlParameter("@VenderName", Item.VenderName);
            var parGSTNo = new SqlParameter("@GSTNo", Item.GSTNo ?? "");
            var parContactName = new SqlParameter("@ContactName", Item.ContactName ?? "");
            var parContactNo = new SqlParameter("@ContactNo", Item.ContactNo ?? "");
            var parAddress = new SqlParameter("@Address", Item.VenderAddress);
            var parEmail = new SqlParameter("@Email", Item.Email ?? "");
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            if (Item.VenderID == 0)
            {
                return objDB.Database.SqlQuery<string>("udspMstVendorInsert @VenderName,@GSTNo,@ContactName,@ContactNo,@Address,@Email, @UserName", parVenderName, parGSTNo, parContactName, parContactNo, parAddress, parEmail, parUserName).FirstOrDefault();
            }
            else
            {
                var parVenderID = new SqlParameter("@VenderID", Item.VenderID);
                return objDB.Database.SqlQuery<string>("udspMstVendorUpdate @VenderID,@VenderName,@GSTNo,@ContactName,@ContactNo,@Address,@Email,@UserName", parVenderID, parVenderName, parGSTNo, parContactName, parContactNo, parAddress, parEmail, parUserName).FirstOrDefault();
            }
        }
        public utblMstVendorDetail GetVendorByID(long ID)
        {
            utblMstVendorDetail objMstVender = objDB.utblMstVendorDetails.FirstOrDefault(p => p.VenderID == ID);
            return objMstVender;
        }
        public string DeleteVendor(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspMstVendorDelete @ID", parID).FirstOrDefault();
        }
        public List<VendorDDList> GetVendorDDList()
        {
            List<VendorDDList> objVendor = new List<VendorDDList>();
            return objVendor = objDB.Database.SqlQuery<VendorDDList>("udspGetVendorDDList").ToList();
        }
        #endregion
        #region ExpenseType Configuration
        public ExpenseTypeViewModel getExpenseTypeList(int PageNo, int PageSize, string SearchTerm)
        {
            try
            {
                ExpenseTypeViewModel objExpenseType = new ExpenseTypeViewModel();
                var parSearchTerm = new SqlParameter("@ExpenseTypeName", SearchTerm ?? "");
                var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
                var parEnd = new SqlParameter("@PageSize", PageSize);
                var spOutput = new SqlParameter
                {
                    ParameterName = "@TotalCount",
                    SqlDbType = System.Data.SqlDbType.BigInt,
                    Direction = System.Data.ParameterDirection.Output
                };
                //calling stored procedure to get paged data.
                objExpenseType.ExpenseTypeList = objDB.Database.SqlQuery<utblMstExpenseType>("udspgetExpenseTypeList @ExpenseTypeName,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
                // setting total number of records
                objExpenseType.TotalRecords = int.Parse(spOutput.Value.ToString());
                return objExpenseType;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        public string SaveExpenseType(utblMstExpenseType Item)
        {
            Item.ExpenseType = Regex.Replace(Item.ExpenseType.Trim(), @"\s+", " ");
            var parExpenseType = new SqlParameter("@ExpenseType", Item.ExpenseType);
            var parDescription = new SqlParameter("@Description", Item.Description);
            var parIsProjectRelated = new SqlParameter("@IsProjectRelated", Item.IsProjectRelated);
            var parCanReceiveDirectPayment = new SqlParameter("@CanReceiveDirectPayment", Item.CanReceiveDirectPayment);
            var parOpeningAmount = new SqlParameter("@OpeningAmount", DBNull.Value);
            if (Item.OpeningAmount != null)
                parOpeningAmount.Value = Item.OpeningAmount;
            var parOpeningDate = new SqlParameter("@OpeningDate", DBNull.Value);
            if (Item.OpeningDate != null)
                parOpeningDate.Value = Item.OpeningDate;
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            if (Item.ExpenseTypeID == 0)
            {
                return objDB.Database.SqlQuery<string>("udspMstExpenseTypeInsert @ExpenseType,@Description,@IsProjectRelated,@CanReceiveDirectPayment,@OpeningAmount,@OpeningDate,@UserName",
                    parExpenseType, parDescription, parIsProjectRelated, parCanReceiveDirectPayment, parOpeningAmount, parOpeningDate, parUserName).FirstOrDefault();
            }
            else
            {
                var parExpenseTypeID = new SqlParameter("@ExpenseTypeID", Item.ExpenseTypeID);
                return objDB.Database.SqlQuery<string>("udspMstExpenseTypeUpdate @ExpenseTypeID,@ExpenseType,@Description,@IsProjectRelated,@CanReceiveDirectPayment,@OpeningAmount,@OpeningDate,@UserName",
                    parExpenseTypeID, parExpenseType, parDescription, parIsProjectRelated, parCanReceiveDirectPayment, parOpeningAmount, parOpeningDate, parUserName).FirstOrDefault();
            }
        }
        public utblMstExpenseType GetExpenseTypeByID(long ID)
        {
            utblMstExpenseType objMstExpenseType = objDB.utblMstExpenseTypes.FirstOrDefault(p => p.ExpenseTypeID == ID);
            return objMstExpenseType;
        }
        public string DeleteExpenseType(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspMstExpenseTypeDelete @ID", parID).FirstOrDefault();
        }
        public List<ExpenseTypeDD> GetExpenseTypeDD()
        {
            return objDB.Database.SqlQuery<ExpenseTypeDD>("udspGetExpenseTypeDDList").ToList();
        }
        #endregion
        #region Client Configuration
        public MstConfigurationViewModel getClientList(int PageNo, int PageSize, string SearchTerm)
        {
            MstConfigurationViewModel objClient = new MstConfigurationViewModel();
            var parSearchTerm = new SqlParameter("@ClientName", SearchTerm ?? "");
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objClient.ClientList = objDB.Database.SqlQuery<utblMstClient>("udspgetClientList @ClientName,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objClient.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objClient;
        }
        public string SaveClient(utblMstClient Item)
        {
            Item.ClientName = Regex.Replace(Item.ClientName.Trim(), @"\s+", " ");
            var parClientName = new SqlParameter("@ClientName", Item.ClientName);
            var parClientAddress = new SqlParameter("@ClientAddress", Item.ClientAddress);
            var parGSTNo = new SqlParameter("@GSTNo", Item.GSTNo);
            var parContactNo = new SqlParameter("@ContactNo", Item.ContactNo ?? "");
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            if (Item.ClientID == 0)
            {
                return objDB.Database.SqlQuery<string>("udspMstClientInsert @ClientName,@ClientAddress,@GSTNo,@ContactNo,@UserName", parClientName, parClientAddress, parGSTNo, parContactNo, parUserName).FirstOrDefault();
            }
            else
            {
                var parClientID = new SqlParameter("@ClientID", Item.ClientID);
                return objDB.Database.SqlQuery<string>("udspMstClientUpdate @ClientID,@ClientName,@ClientAddress,@GSTNo,@ContactNo,@UserName", parClientID, parClientName, parClientAddress, parGSTNo, parContactNo, parUserName).FirstOrDefault();
            }
        }
        public utblMstClient GetClientByID(long ID)
        {
            utblMstClient objMstClient = objDB.utblMstClients.FirstOrDefault(p => p.ClientID == ID);
            return objMstClient;
        }
        public string DeleteClient(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspMstClientDelete @ID", parID).FirstOrDefault();
        }
        public List<ClientDDList> GetClientDDList()
        {
            PurchaseSalesViewModel objPS = new PurchaseSalesViewModel();
            return objPS.ClientDDList = objDB.Database.SqlQuery<ClientDDList>("udspGetClientDDList").ToList();
        }
        #endregion
        #region Holiday Configuration
        public HolidayVM getHolidayList(int PageNo, int PageSize, string SearchTerm)
        {
            HolidayVM objHoliday = new HolidayVM();
            var parSearchTerm = new SqlParameter("@HolidayName", SearchTerm ?? "");
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objHoliday.HolidayList = objDB.Database.SqlQuery<MstHolidayView>("udspgetHolidayList @HolidayName,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objHoliday.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objHoliday;
        }
        public string SaveHoliday(utblMstHoliday Item)
        {
            DateTime DT = Item.DateTo;
            DateTime DF = Item.DateFrom;
            TimeSpan ts = DT.Subtract(DF);
            int total = ts.Days;
            int NoofDays = total + 1;
            Item.HolidayName = Regex.Replace(Item.HolidayName.Trim(), @"\s+", " ");
            var parHolidayName = new SqlParameter("@HolidayName", Item.HolidayName);
            var parHolidayDesc = new SqlParameter("@HolidayDesc", Item.HolidayDesc ?? "");
            var parDateFrom = new SqlParameter("@DateFrom", Item.DateFrom);
            var parDateTo = new SqlParameter("@DateTo", Item.DateTo);
            var parNoofDays = new SqlParameter("@NoofDays", NoofDays);
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            if (Item.HolidayID == null)
            {
                return objDB.Database.SqlQuery<string>("udspMstHolidayInsert @HolidayName,@HolidayDesc,@DateFrom,@DateTo,@NoofDays,@UserName", parHolidayName, parHolidayDesc, parDateFrom, parDateTo, parNoofDays, parUserName).FirstOrDefault();
            }
            else
            {
                var parHolidayID = new SqlParameter("@HolidayID", Item.HolidayID);
                return objDB.Database.SqlQuery<string>("udspMstHolidayUpdate @HolidayID,@HolidayName,@HolidayDesc,@DateFrom,@DateTo,@NoofDays,@UserName", parHolidayID, parHolidayName, parHolidayDesc, parDateFrom, parDateTo, parNoofDays, parUserName).FirstOrDefault();
            }
        }
        public utblMstHoliday GetHolidayByID(string ID)
        {
            utblMstHoliday objMstHoliday = objDB.utblMstHolidays.FirstOrDefault(p => p.HolidayID == ID);
            return objMstHoliday;
        }
        public string DeleteHoliday(string ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspMstHolidayDelete @ID", parID).FirstOrDefault();
        }
        public IEnumerable<MonthlyCalView> GetMonthlyCalView(int MonthNo, int YearNo)
        {
            var parMonthNo = new SqlParameter("@MonthNo", MonthNo);
            var parYearNo = new SqlParameter("@YearNo", YearNo);
            return objDB.Database.SqlQuery<MonthlyCalView>("udspGetMonthlyCalander @MonthNo,@YearNo", parMonthNo, parYearNo).ToList();
        }
        #endregion
        #region Item Configuration
        public MstConfigurationViewModel getItemList(int PageNo, int PageSize, string SearchTerm)
        {
            MstConfigurationViewModel objItem = new MstConfigurationViewModel();
            var parSearchTerm = new SqlParameter("@ItemName", SearchTerm ?? "");
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objItem.ItemList = objDB.Database.SqlQuery<utblMstItem>("udspgetItemList @ItemName,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objItem.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objItem;
        }
        public string SaveItem(utblMstItem Item)
        {
            Item.ItemName = Regex.Replace(Item.ItemName.Trim(), @"\s+", " ");
            var parName = new SqlParameter("@Name", Item.ItemName);
            var parHSN = new SqlParameter("@Hsn", Item.ItemHSNCode);
            var parGST = new SqlParameter("@Gst", Item.GSTPercentage);
            var parDesc = new SqlParameter("@Desc", Item.ItemDescription);
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            if (Item.ItemID == 0)
            {
                return objDB.Database.SqlQuery<string>("udspMstItemInsert @Name,@Hsn,@Gst,@Desc,@UserName", parName, parHSN, parGST, parDesc, parUserName).FirstOrDefault();
            }
            else
            {
                var parItemID = new SqlParameter("@ItemID", Item.ItemID);
                return objDB.Database.SqlQuery<string>("udspMstItemUpdate @ItemID,@Name,@Hsn,@Gst,@Desc,@UserName", parItemID, parName, parHSN, parGST, parDesc, parUserName).FirstOrDefault();
            }
        }
        public utblMstItem GetItemByID(long ID)
        {
            utblMstItem objMstItem = objDB.utblMstItems.FirstOrDefault(p => p.ItemID == ID);
            return objMstItem;
        }
        public string DeleteItem(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspMstItemDelete @ID", parID).FirstOrDefault();
        }
        //public List<utblMstItem> GetItemDDList()
        //{
        //    ReferenceNumberViewModel objref = new ReferenceNumberViewModel();
        //    return objref.ItemDDList = objDB.Database.SqlQuery<ItemDD>("udspGetItemDDList").ToList();
        //}
        #endregion
        #region Device Mapping Configuration
        public MstConfigurationViewModel getEmpAttMappList(int PageNo, int PageSize, string SearchTerm)
        {
            MstConfigurationViewModel objDev = new MstConfigurationViewModel();
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
            objDev.EmpAttDevMappingList = objDB.Database.SqlQuery<EmpDeviceView>("udspgetEmpAttMappList @SearchTerm,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objDev.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objDev;
        }
        public string SaveDeviceMapping(utblEmpAttendanceMapping Item)
        {
            var parEmployeeID = new SqlParameter("@EmployeeID", Item.EmployeeID);
            var parEmpDeviceID = new SqlParameter("@EmpDeviceID", Item.EmpDeviceID);
            var parUserName = new SqlParameter("@UserName", Item.UserID);
            return objDB.Database.SqlQuery<string>("udspEmpDeviceMappingInsert @EmployeeID,@EmpDeviceID,@UserName", parEmployeeID, parEmpDeviceID, parUserName).FirstOrDefault();
        }
        public string DeleteAttendanceMapping(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspAttendanceMappingDelete @ID", parID).FirstOrDefault();
        }

        #endregion
        #region FinancialYear Configuration
        public FinancialYearVM getFinancialYearList(int PageNo, int PageSize, string SearchTerm)
        {
            FinancialYearVM objFinancialYear = new FinancialYearVM();
            var parSearchTerm = new SqlParameter("@Symbol", SearchTerm ?? "");
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objFinancialYear.FinancialYearList = objDB.Database.SqlQuery<UtblMstFinancialYear>("udspgetFinancialYearList @Symbol,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objFinancialYear.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objFinancialYear;
        }
        public string SaveFinancialYear(UtblMstFinancialYear FinancialYear)
        {
            var parStartDate = new SqlParameter("@StartDate", FinancialYear.StartDate);
            var parEndDate = new SqlParameter("@Enddate", FinancialYear.EndDate);
            var parSymbol = new SqlParameter("@Symbol", FinancialYear.FiscalYearSymbol);
            var parActive = new SqlParameter("@Active", FinancialYear.Active);
            if (FinancialYear.FiscalID == 0)
            {
                return objDB.Database.SqlQuery<string>("udspMstFinancialYearInsert @StartDate,@Enddate,@Symbol,@Active", parStartDate, parEndDate, parSymbol, parActive).FirstOrDefault();
            }
            else
            {
                var parID = new SqlParameter("@ID", FinancialYear.FiscalID);
                return objDB.Database.SqlQuery<string>("udspMstFinancialYearUpdate @ID, @StartDate,@Enddate,@Symbol,@Active", parID, parStartDate, parEndDate, parSymbol, parActive).FirstOrDefault();
            }
        }
        public UtblMstFinancialYear GetFinancialYearByID(int ID)
        {
            UtblMstFinancialYear objMstFinancialYear = objDB.UtblMstFinancialYears.FirstOrDefault(p => p.FiscalID == ID);
            return objMstFinancialYear;
        }
        #endregion
        #region MstReferenceNumber Configuration
        public ReferenceNoVM getMstReferenceNumberList(int PageNo, int PageSize, string SearchTerm)
        {
            ReferenceNoVM objMstReferenceNumber = new ReferenceNoVM();
            var parSearchTerm = new SqlParameter("@Symbol", SearchTerm ?? "");
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objMstReferenceNumber.MstReferenceNumberList = objDB.Database.SqlQuery<utblMstReferenceNumber>("udspgetMstReferenceNumberList @Symbol,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objMstReferenceNumber.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objMstReferenceNumber;
        }
        public string SaveMstReferenceNumber(utblMstReferenceNumber MstReferenceNumber)
        {
            try
            {
                var parPrefix = new SqlParameter("@Prefix", MstReferenceNumber.Prefix);
                var parSuffix = new SqlParameter("@Suffix", MstReferenceNumber.Suffix);
                var parSymbol = new SqlParameter("@Symbol", MstReferenceNumber.FiscalYearSymbol);
                var parStartNo = new SqlParameter("@StartNo", MstReferenceNumber.StartNo);
                var parCurrentNo = new SqlParameter("@CurrentNo", MstReferenceNumber.CurrentNo);

                if (MstReferenceNumber.RefID == 0)
                {
                    return objDB.Database.SqlQuery<string>("udspMstReferenceNumberInsert @Prefix,@Suffix,@Symbol,@StartNo,@CurrentNo",
                        parPrefix, parSuffix, parSymbol, parStartNo, parCurrentNo).FirstOrDefault();
                }
                else
                {
                    var parID = new SqlParameter("@ID", MstReferenceNumber.RefID);
                    return objDB.Database.SqlQuery<string>("udspMstMstReferenceNumberUpdate @ID, @Prefix,@Suffix,@Symbol,@StartNo,@CurrentNo",
                        parID, parPrefix, parSuffix, parSymbol, parStartNo, parCurrentNo).FirstOrDefault();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public utblMstReferenceNumber GetMstReferenceNumberByID(int ID)
        {
            utblMstReferenceNumber objMstMstReferenceNumber = objDB.utblMstReferenceNumbers.FirstOrDefault(p => p.RefID == ID);
            return objMstMstReferenceNumber;
        }
        #endregion
        #region Project Configuration
        public ProjectVM getProjectList(int PageNo, int PageSize, string SearchTerm)
        {
            ProjectVM objProject = new ProjectVM();
            var parSearchTerm = new SqlParameter("@ProjName", DBNull.Value);
            if (!(SearchTerm == "" || SearchTerm == null))
                parSearchTerm = new SqlParameter("@ProjName", SearchTerm);
            var parStart = new SqlParameter("@Start", (PageNo - 1) * PageSize);
            var parEnd = new SqlParameter("@PageSize", PageSize);
            var spOutput = new SqlParameter
            {
                ParameterName = "@TotalCount",
                SqlDbType = System.Data.SqlDbType.BigInt,
                Direction = System.Data.ParameterDirection.Output
            };
            //calling stored procedure to get paged data.
            objProject.ProjectDetailsList = objDB.Database.SqlQuery<ProjectView>("udspgetProjectList @ProjName,@Start,@PageSize,@TotalCount out",
                parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objProject.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objProject;
        }
        public string SaveProject(utblMstProject Item)
        {
            Item.ProjectName = Regex.Replace(Item.ProjectName.Trim(), @"\s+", " ");
            var parProjectName = new SqlParameter("@ProjectName", Item.ProjectName);
            var parVendorID = new SqlParameter("@VendorID", Item.VendorID);
            var parProjStartDate = new SqlParameter("@ProjStartDate", Item.ProjStartDate);
            var parProjEndDate = new SqlParameter("@ProjEndDate", DBNull.Value);
            if (Item.ProjEndDate != null)
                parProjEndDate.Value = Item.ProjEndDate;
            var parProjStatus = new SqlParameter("@ProjStatus", Item.ProjStatus ?? "");
            var parProjValue = new SqlParameter("@ProjValue", Item.ProjValue);
            var parProjDescription = new SqlParameter("@ProjDescription", Item.ProjDescription);
            var parWODate = new SqlParameter("@WODate", DBNull.Value);
            if (Item.WODate != null)
                parWODate.Value = Item.WODate;
            var parWONo = new SqlParameter("@WONo", DBNull.Value);
            if (Item.WONo != null)
                parWONo.Value = Item.WONo;
            var parWOPath = new SqlParameter("@WOPath", DBNull.Value);
            if (Item.WOPath != null)
                parWOPath.Value = Item.WOPath;
            var parPCCPath = new SqlParameter("@PCCPath", DBNull.Value);
            if (Item.PCCPath != null)
                parPCCPath.Value = Item.PCCPath;
            if (Item.ProjectID == 0)
            {
                return objDB.Database.SqlQuery<string>("udspMstProjectInsert @ProjectName,@VendorID,@ProjStartDate,@ProjEndDate,@ProjStatus,@ProjValue, @ProjDescription,@WODate,@WONo,@WOPath, @PCCPath",
                    parProjectName, parVendorID, parProjStartDate, parProjEndDate, parProjStatus, parProjValue, parProjDescription, parWODate, parWONo, parWOPath, parPCCPath).FirstOrDefault();
            }
            else
            {
                var parProjectID = new SqlParameter("@ProjectID", Item.ProjectID);
                return objDB.Database.SqlQuery<string>("udspMstProjectUpdate @ProjectID,@ProjectName,@VendorID,@ProjStartDate,@ProjEndDate,@ProjStatus,@ProjValue, @ProjDescription,@WODate,@WONo,@WOPath, @PCCPath",
                    parProjectID, parProjectName, parVendorID, parProjStartDate, parProjEndDate, parProjStatus, parProjValue, parProjDescription, parWODate, parWONo, parWOPath, parPCCPath).FirstOrDefault();
            }
        }
        public utblMstProject GetProjectByID(long ID)
        {
            utblMstProject objMstVender = objDB.utblMstProjects.FirstOrDefault(p => p.ProjectID == ID);
            return objMstVender;
        }
        public string DeleteProject(long ID)
        {
            var parID = new SqlParameter("@ID", ID);
            return objDB.Database.SqlQuery<string>("udspMstProjectDelete @ID", parID).FirstOrDefault();
        }
        public List<ProjectDD> GetProjectDDList()
        {
            List<ProjectDD> objproj = new List<ProjectDD>();
            return objproj = objDB.Database.SqlQuery<ProjectDD>("udspMstProjectDDList").ToList();
        }
        public List<ProjectDashboardDetails> getProjListdashBoard()
        {
            return objDB.Database.SqlQuery<ProjectDashboardDetails>("udspgetDashboardProjList").ToList();
        }
        public List<ProjectDD> GetProjectByClientID(long ClientID)
        {
            try
            {
                return objDB.utblMstProjects.Where(x => x.VendorID == ClientID).Select(x => new ProjectDD() { ProjectID = x.ProjectID, ProjectName = x.ProjectName }).OrderBy(x => x.ProjectName).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
        #region Bank
        public List<utblMstBank> GetBankDD()
        {
            return objDB.utblMstBanks.OrderBy(p => p.BankName).ToList();
        }
        #endregion
        public int EmailExist(string Email)
        {
            var parEmail = new SqlParameter("@Email", Email);
            return objDB.Database.SqlQuery<int>("if exists (select UserName from AspNetUsers where UserName =@Email )select 1 else select 0", parEmail).FirstOrDefault();
        }
        #region Unit Master
        public UnitVM getUnitList(int PageNo, int PageSize, string SearchTerm)
        {
            UnitVM objItem = new UnitVM();
            var parSearchTerm = new SqlParameter("@UnitName", DBNull.Value);
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
            objItem.UnitList = objDB.Database.SqlQuery<utblMstUnit>("udspgetUnitList @UnitName,@Start,@PageSize,@TotalCount out", parSearchTerm, parStart, parEnd, spOutput).ToList();
            // setting total number of records
            objItem.TotalRecords = int.Parse(spOutput.Value.ToString());
            return objItem;
        }
        public string SaveUnit(utblMstUnit Item)
        {
            try
            {
                var parID = new SqlParameter("@ID", Item.UnitID);
                var parName = new SqlParameter("@Name", Item.UnitName);
                var parDesc = new SqlParameter("@Desc", Item.UnitDescription);
                return objDB.Database.SqlQuery<string>("udspMstUnitAddEdit @ID,@Name,@Desc", parID, parName, parDesc).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public utblMstUnit GetUnitByID(long id)
        {
            return objDB.utblMstUnits.FirstOrDefault(p => p.UnitID == id);
        }
        public string DeleteUnit(long id)
        {
            try
            {
                utblMstUnit obj = objDB.utblMstUnits.Find(id);
                objDB.utblMstUnits.Remove(obj);
                objDB.SaveChangesAsync();
                return "Success: Data Remove Successfully";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
        #endregion
        public List<NotificationView> getNotificationList(string Email)
        {
            var parEmail = new SqlParameter("@Email", Email);
            return objDB.Database.SqlQuery<NotificationView>("udspGetNotificationAlert @Email", parEmail).ToList();
        }
        public List<SalInvDD> GetSalInvListByProj(long ProjID)
        {
            try
            {
                return objDB.utblSaleInvoiceKeys.Where(x => x.ProjectID == ProjID).Select(x => new SalInvDD() { SaleInvoiceID = x.SaleInvoiceID, InvRefNo = x.ReferenceNo }).OrderBy(x => x.SaleInvoiceID).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<VendorDDList> GetStateDDList()
        {
            return new List<VendorDDList>();
        }
    }
}

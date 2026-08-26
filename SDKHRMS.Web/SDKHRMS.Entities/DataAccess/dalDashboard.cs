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





        public GSTAnnualSummaryModel getGSTAnnualSummary(DateTime SDate, DateTime EDate)
        {
            try
            {
                var parSDate1 = new SqlParameter("@SDate", SDate.Date);
                var parEDate1 = new SqlParameter("@EDate", EDate.Date.AddDays(1));

                string sqlSale = @"
                    SELECT 
                        ISNULL(SUM(ISNULL(IGSTAmount, 0)), 0) AS TotalIGST, 
                        ISNULL(SUM(ISNULL(CGSTAmount, 0)), 0) AS TotalCGST, 
                        ISNULL(SUM(ISNULL(SGSTAmount, 0)), 0) AS TotalSGST,
                        ISNULL(SUM(CASE WHEN ISNULL(CGSTAmount, 0) > 0 OR ISNULL(SGSTAmount, 0) > 0 THEN ISNULL(ExcludingTaxAmt, 0) ELSE 0 END), 0) AS CGSTTaxable,
                        ISNULL(SUM(CASE WHEN ISNULL(IGSTAmount, 0) > 0 THEN ISNULL(ExcludingTaxAmt, 0) ELSE 0 END), 0) AS IGSTTaxable,
                        ISNULL(SUM(ISNULL(ExcludingTaxAmt, 0)), 0) AS TotalTaxable,
                        ISNULL(SUM(ISNULL(IGSTAmount, 0) + ISNULL(CGSTAmount, 0) + ISNULL(SGSTAmount, 0)), 0) AS TotalTax
                    FROM utblSaleInvoiceKeys
                    WHERE InvoiceDate >= @SDate AND InvoiceDate < @EDate AND ISNULL(IsCancelled, 0) = 0;
                ";

                var saleGST = objDB.Database.SqlQuery<GSTSummaryRaw>(sqlSale, parSDate1, parEDate1).FirstOrDefault() ?? new GSTSummaryRaw();

                var parSDate2 = new SqlParameter("@SDate", SDate.Date);
                var parEDate2 = new SqlParameter("@EDate", EDate.Date.AddDays(1));

                string sqlPur = @"
                    SELECT  
                        ISNULL(SUM(ISNULL(IGSTAmount, 0)), 0) AS TotalIGST,  
                        ISNULL(SUM(ISNULL(CGSTAmount, 0)), 0) AS TotalCGST,
                        ISNULL(SUM(ISNULL(SGSTAmount, 0)), 0) AS TotalSGST,
                        ISNULL(SUM(CASE WHEN ISNULL(CGSTAmount, 0) > 0 OR ISNULL(SGSTAmount, 0) > 0 THEN ISNULL(ExcludingTaxAmt, 0) ELSE 0 END), 0) AS CGSTTaxable,
                        ISNULL(SUM(CASE WHEN ISNULL(IGSTAmount, 0) > 0 THEN ISNULL(ExcludingTaxAmt, 0) ELSE 0 END), 0) AS IGSTTaxable,
                        ISNULL(SUM(ISNULL(ExcludingTaxAmt, 0)), 0) AS TotalTaxable,
                        ISNULL(SUM(ISNULL(IGSTAmount, 0) + ISNULL(CGSTAmount, 0) + ISNULL(SGSTAmount, 0)), 0) AS TotalTax 
                    FROM utblPurchaseInvoiceKeys
                    WHERE PurchaseDate >= @SDate AND PurchaseDate < @EDate AND ISNULL(IsPOCancelled, 0) = 0;
                ";

                var purGST = objDB.Database.SqlQuery<GSTSummaryRaw>(sqlPur, parSDate2, parEDate2).FirstOrDefault() ?? new GSTSummaryRaw();

                decimal totalOutputTax = saleGST.TotalTax;
                decimal totalInputTax = purGST.TotalTax;
                decimal netGSTPayable = totalOutputTax - totalInputTax;

                decimal cgstTaxable = saleGST.CGSTTaxable > 0 ? saleGST.CGSTTaxable : 0;
                decimal sgstTaxable = saleGST.CGSTTaxable > 0 ? saleGST.CGSTTaxable : 0;
                decimal igstTaxable = saleGST.IGSTTaxable > 0 ? saleGST.IGSTTaxable : (saleGST.TotalIGST > 0 ? (saleGST.TotalTaxable - cgstTaxable) : 0);

                var result = new GSTAnnualSummaryModel
                {
                    TotalGSTAmount = totalOutputTax,
                    CGSTTaxable = cgstTaxable,
                    CGSTAmount = saleGST.TotalCGST,
                    CGSTTotal = saleGST.TotalCGST,
                    SGSTTaxable = sgstTaxable,
                    SGSTAmount = saleGST.TotalSGST,
                    SGSTTotal = saleGST.TotalSGST,
                    IGSTTaxable = igstTaxable,
                    IGSTAmount = saleGST.TotalIGST,
                    IGSTTotal = saleGST.TotalIGST,
                    CESSTaxable = 0,
                    CESSAmount = 0,
                    CESSTotal = 0,
                    TotalTaxable = saleGST.TotalTaxable,
                    TotalTax = saleGST.TotalTax,
                    GrandTotal = saleGST.TotalTax,
                    OutputGST = totalOutputTax,
                    InputGST = totalInputTax,
                    NetGSTPayable = netGSTPayable
                };

                return result;
            }
            catch
            {
                return new GSTAnnualSummaryModel();
            }
        }

        public List<GSTMonthlySummaryRow> getGSTMonthlySummary(DateTime SDate, DateTime EDate)
        {
            var list = new List<GSTMonthlySummaryRow>();
            try
            {
                var parSDate1 = new SqlParameter("@SDate", SDate.Date);
                var parEDate1 = new SqlParameter("@EDate", EDate.Date.AddDays(1));

                string sqlSale = @"
                    SELECT  
                        MONTH(InvoiceDate) AS MonthNo, 
                        DATENAME(MONTH, InvoiceDate) AS MonthName,
                        SUM(ISNULL(IGSTAmount, 0)) AS TotalIGST,
                        SUM(ISNULL(CGSTAmount, 0)) AS TotalCGST,
                        SUM(ISNULL(SGSTAmount, 0)) AS TotalSGST,
                        SUM(ISNULL(IGSTAmount, 0) + ISNULL(CGSTAmount, 0) + ISNULL(SGSTAmount, 0)) AS TotalGST
                    FROM utblSaleInvoiceKeys
                    WHERE InvoiceDate >= @SDate AND InvoiceDate < @EDate AND ISNULL(IsCancelled, 0) = 0
                    GROUP BY MONTH(InvoiceDate), DATENAME(MONTH, InvoiceDate);
                ";

                var saleMonthly = objDB.Database.SqlQuery<GSTMonthlyRaw>(sqlSale, parSDate1, parEDate1).ToList();

                var parSDate2 = new SqlParameter("@SDate", SDate.Date);
                var parEDate2 = new SqlParameter("@EDate", EDate.Date.AddDays(1));

                string sqlPur = @"
                    SELECT  
                        MONTH(PurchaseDate) AS MonthNo, 
                        DATENAME(MONTH, PurchaseDate) AS MonthName,
                        SUM(ISNULL(IGSTAmount, 0)) AS TotalIGST,
                        SUM(ISNULL(CGSTAmount, 0)) AS TotalCGST,
                        SUM(ISNULL(SGSTAmount, 0)) AS TotalSGST,
                        SUM(ISNULL(IGSTAmount, 0) + ISNULL(CGSTAmount, 0) + ISNULL(SGSTAmount, 0)) AS TotalGST
                    FROM utblPurchaseInvoiceKeys
                    WHERE PurchaseDate >= @SDate AND PurchaseDate < @EDate AND ISNULL(IsPOCancelled, 0) = 0
                    GROUP BY MONTH(PurchaseDate), DATENAME(MONTH, PurchaseDate);
                ";

                var purMonthly = objDB.Database.SqlQuery<GSTMonthlyRaw>(sqlPur, parSDate2, parEDate2).ToList();

                int startYear = SDate.Year;
                if (SDate.Month < 4) startYear = SDate.Year - 1;

                int[] fyMonths = { 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3 };
                string[] monthNames = { "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar" };

                for (int i = 0; i < fyMonths.Length; i++)
                {
                    int m = fyMonths[i];
                    int yr = (m >= 4) ? startYear : startYear + 1;
                    string mName = $"{monthNames[i]} {yr}";

                    var s = saleMonthly.FirstOrDefault(x => x.MonthNo == m);
                    var p = purMonthly.FirstOrDefault(x => x.MonthNo == m);

                    decimal outputTax = s != null ? s.TotalGST : 0;
                    decimal inputTax = p != null ? p.TotalGST : 0;
                    decimal netPayable = outputTax - inputTax;

                    string status;
                    string statusClass;
                    decimal gstPaid = 0;
                    decimal balancePayable = 0;

                    if (netPayable < 0)
                    {
                        status = "ITC Excess";
                        statusClass = "badge-soft-info";
                    }
                    else if (netPayable == 0)
                    {
                        status = "Filed";
                        statusClass = "badge-soft-success";
                    }
                    else
                    {
                        DateTime monthEnd = new DateTime(yr, m, DateTime.DaysInMonth(yr, m));
                        if (DateTime.Today >= monthEnd)
                        {
                            status = "Filed";
                            statusClass = "badge-soft-success";
                            gstPaid = netPayable;
                            balancePayable = 0;
                        }
                        else
                        {
                            status = "Pending";
                            statusClass = "badge-soft-danger";
                            gstPaid = 0;
                            balancePayable = netPayable;
                        }
                    }

                    list.Add(new GSTMonthlySummaryRow
                    {
                        MonthNo = m,
                        MonthName = mName,
                        OutputTax = outputTax,
                        InputTax = inputTax,
                        NetGSTPayable = netPayable,
                        GSTPaid = gstPaid,
                        BalancePayable = balancePayable,
                        Status = status,
                        StatusClass = statusClass
                    });
                }
            }
            catch
            {
            }
            return list;
        }

        public List<TopProjectSummaryRow> getTopProjectsSummary(DateTime SDate, DateTime EDate)
        {
            var list = new List<TopProjectSummaryRow>();
            try
            {
                string sql = @"
                    SELECT 
                        p.ProjectID,
                        p.ProjectName,
                        ISNULL(v.VenderName, 'N/A') AS ClientName,
                        ISNULL(p.ProjValue, 0) AS ContractValue,
                        ISNULL(p.ProjStatus, 'In Progress') AS ProjStatus,
                        ISNULL((SELECT SUM(ISNULL(r.NetAmtReceived, 0) + ISNULL(r.TDSDeductionAmt, 0) + ISNULL(r.GstDeductionAmt, 0) + ISNULL(r.SecurityDepositAmt, 0) + ISNULL(r.OtherDeductionAmt, 0)) 
                                FROM utblProjPaymentReceivables r WHERE r.ProjectID = p.ProjectID), 0) AS Income,
                        ISNULL((SELECT SUM(ISNULL(pk.ExcludingTaxAmt, 0)) 
                                FROM utblPurchaseInvoiceKeys pk WHERE pk.ProjectID = p.ProjectID AND ISNULL(pk.IsPOCancelled, 0) = 0), 0)
                        +
                        ISNULL((SELECT SUM(ISNULL(dp.PaymentAmt, 0)) 
                                FROM utblDirectPayments dp WHERE dp.ProjectID = p.ProjectID AND ISNULL(dp.IsDeclined, 0) = 0), 0) AS Expense
                    FROM utblMstProjects p
                    LEFT JOIN utblMstVendorDetails v ON p.VendorID = v.VenderID
                    ORDER BY p.ProjValue DESC;
                ";

                var rawList = objDB.Database.SqlQuery<ProjectSummaryRaw>(sql).Take(5).ToList();

                foreach (var item in rawList)
                {
                    decimal margin = item.ContractValue - item.Expense;
                    int marginPct = item.ContractValue > 0 ? (int)Math.Round((margin / item.ContractValue) * 100) : 0;
                    double expensePct = item.ContractValue > 0 ? (double)(item.Expense / item.ContractValue) * 100 : 0;

                    string expenseIndicatorClass;
                    if (expensePct >= 80)
                        expenseIndicatorClass = "text-danger";
                    else if (expensePct >= 60)
                        expenseIndicatorClass = "text-warning";
                    else
                        expenseIndicatorClass = "text-primary";

                    string status = "In Progress";
                    string statusBadgeClass = "badge-soft-primary";

                    if (!string.IsNullOrEmpty(item.ProjStatus) && (item.ProjStatus.Equals("Closed", StringComparison.OrdinalIgnoreCase) || item.ProjStatus.Equals("Completed", StringComparison.OrdinalIgnoreCase) || item.ProjStatus == "1"))
                    {
                        status = "Completed";
                        statusBadgeClass = "badge-soft-success";
                    }
                    else if (!string.IsNullOrEmpty(item.ProjStatus) && (item.ProjStatus.Equals("On Hold", StringComparison.OrdinalIgnoreCase) || item.ProjStatus == "2"))
                    {
                        status = "On Hold";
                        statusBadgeClass = "badge-soft-warning";
                    }

                    list.Add(new TopProjectSummaryRow
                    {
                        ProjectID = item.ProjectID,
                        ProjectName = item.ProjectName,
                        ClientName = item.ClientName,
                        ContractValue = item.ContractValue,
                        Income = item.Income,
                        Expense = item.Expense,
                        Margin = margin,
                        MarginPercentage = marginPct,
                        ExpensePercentage = expensePct,
                        ExpenseIndicatorClass = expenseIndicatorClass,
                        Status = status,
                        StatusBadgeClass = statusBadgeClass
                    });
                }
            }
            catch
            {
            }
            return list;
        }

        public CashFlowOverviewModel getCashFlowOverview(DateTime SDate, DateTime EDate)
        {
            try
            {
                var parSDate = new SqlParameter("@SDate", SDate.Date);
                var parEDate = new SqlParameter("@EDate", EDate.Date.AddDays(1));

                string sql = @"
                    SELECT 
                        ISNULL(SUM(ISNULL(CreditAmt, 0)), 0) AS TotalCashCredit, 
                        ISNULL(SUM(ISNULL(DebitAmt, 0)), 0) AS TotalCashDebit,
                        ISNULL(SUM(ISNULL(CreditAmt, 0) - ISNULL(DebitAmt, 0)), 0) AS CashBalance
                    FROM utblPettyCashs 
                    WHERE TransDate >= @SDate AND TransDate < @EDate;
                ";

                var res = objDB.Database.SqlQuery<CashFlowRaw>(sql, parSDate, parEDate).FirstOrDefault() ?? new CashFlowRaw();

                return new CashFlowOverviewModel
                {
                    CashInflow = res.TotalCashCredit,
                    CashOutflow = res.TotalCashDebit,
                    NetCashFlow = res.CashBalance,
                    ClosingBalance = res.CashBalance
                };
            }
            catch
            {
                return new CashFlowOverviewModel();
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

    public class GSTSummaryRaw
    {
        public decimal TotalIGST { get; set; }
        public decimal TotalCGST { get; set; }
        public decimal TotalSGST { get; set; }
        public decimal CGSTTaxable { get; set; }
        public decimal IGSTTaxable { get; set; }
        public decimal TotalTaxable { get; set; }
        public decimal TotalTax { get; set; }
    }

    public class GSTMonthlyRaw
    {
        public int MonthNo { get; set; }
        public string MonthName { get; set; }
        public decimal TotalIGST { get; set; }
        public decimal TotalCGST { get; set; }
        public decimal TotalSGST { get; set; }
        public decimal TotalGST { get; set; }
    }

    public class ProjectSummaryRaw
    {
        public long ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string ClientName { get; set; }
        public decimal ContractValue { get; set; }
        public string ProjStatus { get; set; }
        public decimal Income { get; set; }
        public decimal Expense { get; set; }
    }

    public class CashFlowRaw
    {
        public decimal TotalCashCredit { get; set; }
        public decimal TotalCashDebit { get; set; }
        public decimal CashBalance { get; set; }
    }
}

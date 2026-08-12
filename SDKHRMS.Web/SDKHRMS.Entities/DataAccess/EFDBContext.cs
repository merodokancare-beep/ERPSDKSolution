using Microsoft.EntityFrameworkCore;
using SDKHRMS.Entities.Models;

namespace SDKHRMS.Entities.DataAccess
{
    public class EFDBContext : DbContext
    {
        public EFDBContext()
        {
        }

        public EFDBContext(DbContextOptions<EFDBContext> options)
            : base(options)
        {
        }

        public DbSet<utblMstVendorDetail> utblMstVendorDetails { get; set; }
        public DbSet<utblEmpPersonalInfoKey> utblEmpPersonalInfoKeys { get; set; }
        public DbSet<utblMstExpenseType> utblMstExpenseTypes { get; set; }
        public DbSet<utblMstClient> utblMstClients { get; set; }
        public DbSet<utblMstHoliday> utblMstHolidays { get; set; }
        public DbSet<utblPurchaseSale> utblPurchaseSales { get; set; }
        public DbSet<utblPaymentDetail> utblPaymentDetails { get; set; }
        public DbSet<utblReferenceDetail> utblReferenceDetails { get; set; }
        public DbSet<utblMstItem> utblMstItems { get; set; }
        public DbSet<utblSaleInvoiceKey> utblSaleInvoiceKeys { get; set; }
        public DbSet<utblMstReferenceNumber> utblMstReferenceNumbers { get; set; }
        public DbSet<UtblMstFinancialYear> UtblMstFinancialYears { get; set; }
        public DbSet<utblPurchaseInvoiceKey> utblPurchaseInvoiceKeys { get; set; }
        public DbSet<utblMstProject> utblMstProjects { get; set; }
        public DbSet<utblMstBank> utblMstBanks { get; set; }
        public DbSet<utblMstUnit> utblMstUnits { get; set; }
        public DbSet<utblPettyCash> utblPettyCashs { get; set; }
        public DbSet<utblPaymentReceivable> utblPaymentReceivables { get; set; }
        public DbSet<utblProjPaymentReceivable> utblProjPaymentReceivables { get; set; }
        public DbSet<utblDirectPayment> utblDirectPayments { get; set; }
        public DbSet<utblChallanKey> utblChallanKeys { get; set; }
        public DbSet<utblChallanItem> utblChallanItems { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}

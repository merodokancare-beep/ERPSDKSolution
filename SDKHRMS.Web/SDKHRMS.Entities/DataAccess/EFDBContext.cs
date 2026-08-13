using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using SDKHRMS.Entities.Models;
using System;
using System.IO;

namespace SDKHRMS.Entities.DataAccess
{
    public class EFDBContext : DbContext
    {
        public static string ConnectionString { get; set; }

        public EFDBContext()
        {
        }

        public EFDBContext(DbContextOptions<EFDBContext> options)
            : base(options)
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                string connStr = ConnectionString;

                if (string.IsNullOrEmpty(connStr))
                {
                    try
                    {
                        var config = new ConfigurationBuilder()
                            .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                            .AddJsonFile("appsettings.json", optional: true)
                            .AddEnvironmentVariables()
                            .Build();

                        connStr = config.GetConnectionString("EFDBContext") 
                            ?? config.GetConnectionString("DefaultConnection");
                    }
                    catch { }
                }

                if (string.IsNullOrEmpty(connStr))
                {
                    try
                    {
                        var config = new ConfigurationBuilder()
                            .SetBasePath(Directory.GetCurrentDirectory())
                            .AddJsonFile("appsettings.json", optional: true)
                            .AddEnvironmentVariables()
                            .Build();

                        connStr = config.GetConnectionString("EFDBContext") 
                            ?? config.GetConnectionString("DefaultConnection");
                    }
                    catch { }
                }

                if (string.IsNullOrEmpty(connStr))
                {
                    connStr = "Server=db63574.databaseasp.net;Database=db63574;User Id=db63574;Password=B#e3fG5!4r%A;Encrypt=False;MultipleActiveResultSets=True;TrustServerCertificate=True;";
                }

                optionsBuilder.UseSqlServer(connStr);
            }
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

using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System.IO;

namespace SDKHRMS.Web.Models
{
    public class ApplicationUser : IdentityUser
    {
        public string Role { get; set; }
        public string EmployeeID { get; set; }
        public bool IsActive { get; set; }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public ApplicationDbContext()
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                IConfigurationRoot configuration = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json", optional: true)
                    .Build();
                string connectionString = configuration.GetConnectionString("EFDBContext") 
                    ?? configuration.GetConnectionString("DefaultConnection") 
                    ?? "Data Source=.;Initial Catalog=WBSDKERPDB;Integrated Security=True;TrustServerCertificate=True;";
                optionsBuilder.UseSqlServer(connectionString);
            }
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            builder.Entity<ApplicationUser>(entity =>
            {
                entity.ToTable("AspNetUsers");

                // Map ASP.NET Core Identity 8 properties to legacy column names
                entity.Property(u => u.NormalizedUserName).HasColumnName("UserName");
                entity.Property(u => u.NormalizedEmail).HasColumnName("Email");
                
                // Ignore columns not present in legacy ASP.NET Identity 2.x database schema
                entity.Ignore(u => u.ConcurrencyStamp);
                entity.Ignore(u => u.LockoutEnd);
            });

            builder.Entity<IdentityRole>(entity =>
            {
                entity.ToTable("AspNetRoles");

                entity.Property(r => r.NormalizedName).HasColumnName("Name");
                entity.Ignore(r => r.ConcurrencyStamp);
            });

            builder.Entity<IdentityUserRole<string>>(entity =>
            {
                entity.ToTable("AspNetUserRoles");
            });

            builder.Entity<IdentityUserClaim<string>>(entity =>
            {
                entity.ToTable("AspNetUserClaims");
            });

            builder.Entity<IdentityUserLogin<string>>(entity =>
            {
                entity.ToTable("AspNetUserLogins");
            });

            builder.Entity<IdentityRoleClaim<string>>(entity =>
            {
                entity.ToTable("AspNetRoleClaims");
            });

            builder.Entity<IdentityUserToken<string>>(entity =>
            {
                entity.ToTable("AspNetUserTokens");
            });
        }
    }
}
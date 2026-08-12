using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

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

                // Ignore columns not present in legacy ASP.NET Identity 2.x database schema
                entity.Ignore(u => u.NormalizedUserName);
                entity.Ignore(u => u.NormalizedEmail);
                entity.Ignore(u => u.ConcurrencyStamp);
                entity.Ignore(u => u.LockoutEnd);
            });

            builder.Entity<IdentityRole>(entity =>
            {
                entity.ToTable("AspNetRoles");

                entity.Ignore(r => r.NormalizedName);
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

    public class ApplicationUserStore : UserStore<ApplicationUser, IdentityRole, ApplicationDbContext>
    {
        public ApplicationUserStore(ApplicationDbContext context, IdentityErrorDescriber describer = null)
            : base(context, describer)
        {
        }

        public override Task<ApplicationUser> FindByNameAsync(string normalizedUserName, CancellationToken cancellationToken = default)
        {
            cancellationToken.ThrowIfCancellationRequested();
            ThrowIfDisposed();
            if (string.IsNullOrEmpty(normalizedUserName)) return Task.FromResult<ApplicationUser>(null);

            return Users.FirstOrDefaultAsync(u => u.UserName == normalizedUserName || u.UserName.ToLower() == normalizedUserName.ToLower(), cancellationToken);
        }

        public override Task<ApplicationUser> FindByEmailAsync(string normalizedEmail, CancellationToken cancellationToken = default)
        {
            cancellationToken.ThrowIfCancellationRequested();
            ThrowIfDisposed();
            if (string.IsNullOrEmpty(normalizedEmail)) return Task.FromResult<ApplicationUser>(null);

            return Users.FirstOrDefaultAsync(u => u.Email == normalizedEmail || u.Email.ToLower() == normalizedEmail.ToLower(), cancellationToken);
        }

        public override Task SetNormalizedUserNameAsync(ApplicationUser user, string normalizedName, CancellationToken cancellationToken = default)
        {
            return Task.CompletedTask;
        }

        public override Task SetNormalizedEmailAsync(ApplicationUser user, string normalizedEmail, CancellationToken cancellationToken = default)
        {
            return Task.CompletedTask;
        }
    }

    public class ApplicationRoleStore : RoleStore<IdentityRole, ApplicationDbContext>
    {
        public ApplicationRoleStore(ApplicationDbContext context, IdentityErrorDescriber describer = null)
            : base(context, describer)
        {
        }

        public override Task<IdentityRole> FindByNameAsync(string normalizedRoleName, CancellationToken cancellationToken = default)
        {
            cancellationToken.ThrowIfCancellationRequested();
            ThrowIfDisposed();
            if (string.IsNullOrEmpty(normalizedRoleName)) return Task.FromResult<IdentityRole>(null);

            return Roles.FirstOrDefaultAsync(r => r.Name == normalizedRoleName || r.Name.ToLower() == normalizedRoleName.ToLower(), cancellationToken);
        }

        public override Task SetNormalizedRoleNameAsync(IdentityRole role, string normalizedName, CancellationToken cancellationToken = default)
        {
            return Task.CompletedTask;
        }
    }
}
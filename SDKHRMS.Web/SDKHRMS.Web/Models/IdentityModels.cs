using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Claims;
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
                    .AddEnvironmentVariables()
                    .Build();
                string connectionString = configuration.GetConnectionString("EFDBContext") 
                    ?? configuration.GetConnectionString("DefaultConnection") 
                    ?? "Server=db63574.databaseasp.net;Database=db63574;User Id=db63574;Password=B#e3fG5!4r%A;Encrypt=False;MultipleActiveResultSets=True;TrustServerCertificate=True;";
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

            // Ignore AspNetRoleClaims and AspNetUserTokens for legacy database schema compatibility
            builder.Ignore<IdentityRoleClaim<string>>();
            builder.Ignore<IdentityUserToken<string>>();
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

        protected override Task<IdentityUserToken<string>> FindTokenAsync(ApplicationUser user, string loginProvider, string name, CancellationToken cancellationToken)
        {
            return Task.FromResult<IdentityUserToken<string>>(null);
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

        public override Task<IList<Claim>> GetClaimsAsync(IdentityRole role, CancellationToken cancellationToken = default)
        {
            cancellationToken.ThrowIfCancellationRequested();
            ThrowIfDisposed();
            if (role == null) throw new ArgumentNullException(nameof(role));

            IList<Claim> emptyClaims = new List<Claim>();
            return Task.FromResult(emptyClaims);
        }
    }

    public class ApplicationUserClaimsPrincipalFactory : UserClaimsPrincipalFactory<ApplicationUser, IdentityRole>
    {
        public ApplicationUserClaimsPrincipalFactory(
            UserManager<ApplicationUser> userManager,
            RoleManager<IdentityRole> roleManager,
            IOptions<IdentityOptions> optionsAccessor)
            : base(userManager, roleManager, optionsAccessor)
        {
        }

        protected override async Task<ClaimsIdentity> GenerateClaimsAsync(ApplicationUser user)
        {
            var identity = await base.GenerateClaimsAsync(user);

            if (!string.IsNullOrEmpty(user.Role))
            {
                identity.AddClaim(new Claim(ClaimTypes.Role, user.Role));
            }
            if (!string.IsNullOrEmpty(user.EmployeeID))
            {
                identity.AddClaim(new Claim("EmployeeID", user.EmployeeID));
            }

            return identity;
        }
    }
}
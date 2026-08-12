using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Security.Claims;
using System.Threading.Tasks;

namespace SDKHRMS.Web.Models
{
    // You can add profile data for the user by adding more properties to your ApplicationUser class, please visit http://go.microsoft.com/fwlink/?LinkID=317594 to learn more.
    public class ApplicationUser : IdentityUser
    {
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            if (string.IsNullOrEmpty(this.SecurityStamp))
            {
                this.SecurityStamp = System.Guid.NewGuid().ToString();
            }
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            if (!string.IsNullOrEmpty(this.EmployeeID))
            {
                userIdentity.AddClaim(new Claim("EmployeeID", this.EmployeeID));
            }
            if (!string.IsNullOrEmpty(this.Role))
            {
                userIdentity.AddClaim(new Claim("Role", this.Role));
            }
            return userIdentity;
        }
        public string Role { get; set; }
        public string EmployeeID { get; set; }
        public bool IsActive { get; set; }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("EFDBContext")
        {
        }
        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }
    }
}
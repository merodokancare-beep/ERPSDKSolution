using System.Security.Claims;
using System.Security.Principal;

namespace Microsoft.AspNet.Identity
{
    public static class IdentityExtensions
    {
        public static string GetUserId(this IIdentity identity)
        {
            if (identity is ClaimsIdentity claimsIdentity)
            {
                return claimsIdentity.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            }
            return null;
        }

        public static string GetUserName(this IIdentity identity)
        {
            return identity?.Name;
        }
    }
}

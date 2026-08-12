using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Linq;

namespace SDKHRMS.Web.HtmlHelpers
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = true, Inherited = true)]
    public class UserAuthorizeAttribute : AuthorizeAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var user = context.HttpContext.User;
            if (user == null || user.Identity == null || !user.Identity.IsAuthenticated)
            {
                context.Result = new RedirectToActionResult("Login", "Account", null);
                return;
            }

            if (!string.IsNullOrEmpty(Roles))
            {
                var allowedRoles = Roles.Split(',').Select(r => r.Trim());
                if (!allowedRoles.Any(r => user.IsInRole(r)))
                {
                    context.Result = new ViewResult
                    {
                        ViewName = "~/Views/Home/Unauthorized.cshtml"
                    };
                }
            }
        }
    }
}
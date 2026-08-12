using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SDKHRMS.Entities.Utility;
using SDKHRMS.Web.Models;
using System;
using System.Threading.Tasks;

namespace SDKHRMS.Web.Controllers
{
    [Authorize]
    public class AccountController : BaseController
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;

        public AccountController(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager)
        {
            _userManager = userManager;
            _signInManager = signInManager;
        }

        public UserManager<ApplicationUser> UserManager => _userManager;
        public SignInManager<ApplicationUser> SignInManager => _signInManager;

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            string key = "8080808080808080";
            string iv = "8080808080808080";
            if (model.Password != null)
            {
                try
                {
                    model.Password = AES.Decrypt(model.Password, key, iv);
                }
                catch
                {
                    // Plaintext fallback if decryption is not required
                }
            }
            if (ModelState.IsValid)
            {
                var user = await _userManager.FindByNameAsync(model.UserName);
                if (user == null && !string.IsNullOrEmpty(model.UserName) && model.UserName.Contains("@"))
                {
                    user = await _userManager.FindByEmailAsync(model.UserName);
                }

                if (user != null && await _userManager.CheckPasswordAsync(user, model.Password))
                {
                    if (user.IsActive == false && user.Role != "Super Admin")
                    {
                        ModelState.AddModelError("errormsg", "Account has been disabled. Please contact admin for more details.");
                        ModelState.Clear();
                        ViewBag.ErrMsg = "Account has been disabled. Please contact admin for more details...";
                    }
                    else
                    {
                        Session["username"] = user.UserName;
                        await _signInManager.SignInAsync(user, isPersistent: true);
                        if (!string.IsNullOrEmpty(returnUrl) && !returnUrl.Contains("Error", StringComparison.OrdinalIgnoreCase) && !returnUrl.Contains("Login", StringComparison.OrdinalIgnoreCase))
                        {
                            return RedirectToLocal(returnUrl);
                        }
                        else
                        {
                            return RedirectToAction("NewDashboard", "Home");
                        }
                    }
                }
                else
                {
                    Session["username"] = null;
                    ModelState.AddModelError("errormsg", "Invalid username or password.");
                    ModelState.Clear();
                    ViewBag.ErrMsg = "Invalid username or password...";
                }
            }
            return View(model);
        }

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = new ApplicationUser() { UserName = model.UserName, IsActive = true };
                var result = await _userManager.CreateAsync(user, model.Password);
                if (result.Succeeded)
                {
                    await _signInManager.SignInAsync(user, isPersistent: false);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    AddErrors(result);
                }
            }
            return View(model);
        }

        //
        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> LogOff()
        {
            await _signInManager.SignOutAsync();
            ClearAll();
            return RedirectToAction("Login", "Account");
        }

        public void ClearAll()
        {
            _signInManager.SignOutAsync().Wait();
            Session["username"] = null;
            Session["UserVar"] = null;
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error.Description);
            }
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (!string.IsNullOrEmpty(returnUrl) && 
                !returnUrl.Contains("Error", StringComparison.OrdinalIgnoreCase) && 
                !returnUrl.Contains("Login", StringComparison.OrdinalIgnoreCase) && 
                Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("NewDashboard", "Home");
            }
        }
    }
}
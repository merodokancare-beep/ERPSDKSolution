using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNet.Identity;
using Microsoft.AspNetCore.Mvc;
using SDKHRMS.Entities.Utility;
using SDKHRMS.Web.HtmlHelpers;
using SDKHRMS.Web.Models;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin,Employee")]
    public class ManageController : BaseController
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;

        public ManageController(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager)
        {
            _userManager = userManager;
            _signInManager = signInManager;
        }

        public UserManager<ApplicationUser> UserManager => _userManager;
        public SignInManager<ApplicationUser> SignInManager => _signInManager;

        // GET: /Manage/Index
        public async Task<ActionResult> Index(ManageMessageId? message)
        {
            ViewBag.StatusMessage =
                message == ManageMessageId.ChangePasswordSuccess ? "Your password has been changed."
                : message == ManageMessageId.SetPasswordSuccess ? "Your password has been set."
                : message == ManageMessageId.RemoveLoginSuccess ? "The external login was removed."
                : message == ManageMessageId.Error ? "An error has occurred."
                : "";

            var userId = User.Identity.GetUserId();
            var model = new IndexViewModel
            {
                HasPassword = HasPassword(),
                PhoneNumber = await _userManager.GetPhoneNumberAsync(await _userManager.GetUserAsync(User)),
                TwoFactor = await _userManager.GetTwoFactorEnabledAsync(await _userManager.GetUserAsync(User)),
                Logins = await _userManager.GetLoginsAsync(await _userManager.GetUserAsync(User)),
                BrowserRemembered = await _signInManager.IsTwoFactorClientRememberedAsync(await _userManager.GetUserAsync(User))
            };
            return View(model);
        }

        // GET: /Manage/ChangePassword
        public ActionResult ChangePassword()
        {
            return View();
        }

        // POST: /Manage/ChangePassword
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ChangePassword(ChangePasswordViewModel model)
        {
            string userName = User.Identity.Name;
            string key = "8080808080808080";
            string iv = "8080808080808080";
            if (model.OldPassword != null && model.NewPassword != null && model.ConfirmPassword != null)
            {
                try
                {
                    model.ConfirmPassword = AES.Decrypt(model.ConfirmPassword, key, iv);
                    model.NewPassword = AES.Decrypt(model.NewPassword, key, iv);
                    model.OldPassword = AES.Decrypt(model.OldPassword, key, iv);
                }
                catch
                {
                    // Plaintext fallback
                }
            }
            if (ModelState.IsValid)
            {
                if (model.OldPassword != null && model.NewPassword != null && model.ConfirmPassword != null)
                {
                    var user = await _userManager.GetUserAsync(User);
                    if (user != null)
                    {
                        var result = await _userManager.ChangePasswordAsync(user, model.OldPassword, model.NewPassword);
                        if (result.Succeeded)
                        {
                            TempData["ErrMsg"] = "Success:Password successfully changed. Please Login again to continue.";
                            await _signInManager.SignOutAsync();
                            Session["username"] = null;
                            Session["UserVar"] = null;
                            return RedirectToAction("Login", "Account");
                        }
                        else
                        {
                            TempData["ErrMsg"] = "Error:Operation failed. Please Try Again. ";
                            AddErrors(result);
                        }
                    }
                }
                else
                {
                    TempData["ErrMsg"] = "Error:Operation failed. Please Try Again. ";
                    return View(model);
                }
            }
            TempData["ErrMsg"] = "Error:Operation failed. Please Try Again. ";
            return View(model);
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error.Description);
            }
        }

        private bool HasPassword()
        {
            var user = _userManager.GetUserAsync(User).Result;
            return user != null && user.PasswordHash != null;
        }

        public enum ManageMessageId
        {
            ChangePasswordSuccess,
            SetPasswordSuccess,
            RemoveLoginSuccess,
            Error
        }
    }
}
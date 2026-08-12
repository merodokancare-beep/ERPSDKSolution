using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using SDKHRMS.Web.HtmlHelpers;

namespace SDKHRMS.Web.Controllers
{
   [UserAuthorize(Roles = "Admin,Super Admin")]
    public class EmpManageController : Controller
    {
        //private ApplicationSignInManager _signInManager;
        //private ApplicationUserManager _userManager;
         private ApplicationDbContext objDB = new ApplicationDbContext();
        dalConfiguration objDalConfig = new dalConfiguration();
        dalEmpManage objDalEmp = new dalEmpManage();
        // GET: EmpManage
        #region Identity Initialization Code
        public EmpManageController()
            : this(new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext())))
        {
        }

        public EmpManageController(UserManager<ApplicationUser> userManager)
        {
            UserManager = userManager;
        }

        public UserManager<ApplicationUser> UserManager { get; private set; }



        #endregion

        public ActionResult EmpList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/EmpManage/EmpList";
            //if (Session["username"] == null)
            //{
            //    return RedirectToAction("login", "account", new { Area = "" });
            //}
            EmpManageVM objVM = new EmpManageVM();
            ViewBag.SearchTerm = SearchTerm;
            objVM = objDalEmp.empList(PageNo, PageSize, SearchTerm);
            objVM.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objVM.TotalRecords };
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvEmpList", objVM);
            }

            return View(objVM);
        }

        public ActionResult AddEmpPersonalDetails()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> AddEmpPersonalDetails(EmpManageViewModel ItemData)
        {
            ViewBag.ActiveURL = "/EmpManage/EmpList";
            DateTime dob = Convert.ToDateTime(ItemData.utblEmpPersonalInfoKey.DateOfBirth);
            DateTime PresentYear = DateTime.Now;
            TimeSpan ts = PresentYear - dob;
            DateTime Age = DateTime.MinValue.AddDays(ts.Days);
            ItemData.utblEmpPersonalInfoKey.UserID = User.Identity.GetUserId();
            int MinAge = Age.Year - 1;
            if (MinAge < 18)
            {
                TempData["ErrMsg"] = "Date of Birth Cannot Be Less than 18 Years!";
                return View(ItemData);
            }
                //string IpAddress = IPAddressGetter.GetIPAddress();
             if (ModelState.IsValid)
                {
                    int users = objDalConfig.EmailExist(ItemData.utblEmpPersonalInfoKey.Email);
                    if (users == 1)
                    {
                        TempData["ErrMsg"] = "Email ID Already Exists";
                        return View(ItemData);
                    }
                    string NewEmpID = "";
                    ItemData.utblEmpPersonalInfoKey.UserID =User.Identity.Name;

                    string result = objDalEmp.SaveEmpDetails(ItemData.utblEmpPersonalInfoKey, out NewEmpID);
                    TempData["ErrMsg"] = result;
                    if (!result.Contains("Error"))
                    {
                        string r = await Register(ItemData.utblEmpPersonalInfoKey.Email, "Employee", NewEmpID);
                        if (!(r.Contains("success")))
                        {
                            //delete User
                            DeleteUser(NewEmpID);
                            return RedirectToAction("EmpList", "EmpManage", new { Area = "" });
                        }
                        else
                        {
                            return RedirectToAction("EmpList", "EmpManage", new { Area = "" });
                        }
                    }
                }
            return View(ItemData);
        }

        public ActionResult EmpEdit(string EmployeeID)
        {
            ViewBag.ActiveURL = "/EmpManage/EmpList";
            EmpManageViewModel objVM = new EmpManageViewModel();
            objVM.utblEmpPersonalInfoKey = objDalEmp.empEdit(EmployeeID);
            return View(objVM);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EmpEdit(EmpManageViewModel obj)
        {
            ViewBag.ActiveURL = "/EmpManage/EmpList";
            DateTime dob = Convert.ToDateTime(obj.utblEmpPersonalInfoKey.DateOfBirth);
            DateTime PresentYear = DateTime.Now;
            TimeSpan ts = PresentYear - dob;
            DateTime Age = DateTime.MinValue.AddDays(ts.Days);
            obj.utblEmpPersonalInfoKey.UserID = "";
            int MinAge = Age.Year - 1;
            if (MinAge < 18)
            {
                TempData["ErrMsg"] = "Date of Birth Cannot Be Less than 18 Years!";
                return View(obj);
            }
            //string IpAddress = IPAddressGetter.GetIPAddress();
            if (ModelState.IsValid)
            {
               
                string result = objDalEmp.editEmpDetails(obj.utblEmpPersonalInfoKey);
                TempData["ErrMsg"] = result;
                if (!result.Contains("Error"))
                {
                        return RedirectToAction("EmpList", "EmpManage", new { Area = "" });
                    
                }
            }
            return View(obj);
        }

        public async Task<string> Register(string Email, string Role, string NewEmpID)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var user = new ApplicationUser() { UserName = Email, Email = Email, Role = Role, EmployeeID = NewEmpID, EmailConfirmed = true, IsActive = true };
                    var result = await UserManager.CreateAsync(user, "Pass@1234#");
                    //var result = await UserManager.CreateAsync(user, "Pass@1234#");
                    if (result.Succeeded)
                    {
                        //string IpAddress = IPAddressGetter.GetIPAddress();
                        string userName = User.Identity.Name;
                        await UserManager.AddToRoleAsync(user.Id, Role);
                        return "success";
                    }
                    else
                    {
                        return "Error";
                    }

                }
                else
                {
                    return "Error";
                }
            }
            catch (Exception)
            {
                
                throw;
            }
           
        }

        public ActionResult EmpDelete(string EmployeeID)
        {
            string result = "";
            result = objDalEmp.deleteEmpDtl(EmployeeID);
            TempData["ErrMsg"] = result;
            return RedirectToAction("EmpList", "EmpManage", new { Area = "" });
        }

        public void DeleteUser(string EmpID)
        {
            objDalEmp.DeleteEmpDetails(EmpID);
        }
        #region Disable User
        //
        // POST: /UserAdmin/Delete
        [HttpPost]
        [ValidateAntiForgeryToken]
        //[UserAuthorize(Roles = "Super Admin")]
        public async Task<ActionResult> DisableUser(string id, int PgNo, int PgSize, int ListCount, string SearchTerm = "")
        {
            if (ModelState.IsValid)
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }

                var user = await UserManager.FindByIdAsync(id);
                if (user == null)
                {
                    return HttpNotFound();
                }
                user.IsActive = !user.IsActive;
                var result = await UserManager.UpdateAsync(user);
                if (!result.Succeeded)
                {
                    TempData["ErrMsg"] = "Error: User record could not be updated, please contact Administrator.";
                    return View();
                }
                else
                {
                    if (user.IsActive)
                    {
                        TempData["ErrMsg"] = "Success: User Enabled Succesfully.";
                    }
                    else
                    {
                        TempData["ErrMsg"] = "Success: User Disabled Succesfully.";
                    }

                }
            }
            return RedirectToAction("EmpList", "EmpManage", new { PageNo = PgNo, PageSize = PgSize, SearchTerm = SearchTerm });
        }
        #endregion
    }
}
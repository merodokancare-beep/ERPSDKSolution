using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.HtmlHelpers;
using SDKHRMS.Web.Models;
using System;
using System.Threading.Tasks;

namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin")]
    public class EmpManageController : BaseController
    {
        private readonly UserManager<ApplicationUser> _userManager;
        dalConfiguration objDalConfig = new dalConfiguration();
        dalEmpManage objDalEmp = new dalEmpManage();

        public EmpManageController(UserManager<ApplicationUser> userManager)
        {
            _userManager = userManager;
        }

        public UserManager<ApplicationUser> UserManager => _userManager;

        public ActionResult EmpList(int PageNo = 1, int PageSize = 20, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/EmpManage/EmpList";
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

        public ActionResult AddEmp()
        {
            ViewBag.ActiveURL = "/EmpManage/AddEmp";
            EmpAdd obj = new EmpAdd();
            obj.StateDDList = objDalConfig.GetStateDDList();
            obj.DesignationDDList = objDalEmp.GetDesignationList();
            obj.RolesDDList = objDalEmp.GetRoleList();
            return View(obj);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> AddEmp(EmpAdd obj)
        {
            ViewBag.ActiveURL = "/EmpManage/AddEmp";
            string result = "";
            obj.StateDDList = objDalConfig.GetStateDDList();
            obj.DesignationDDList = objDalEmp.GetDesignationList();
            obj.RolesDDList = objDalEmp.GetRoleList();
            if (ModelState.IsValid)
            {
                result = objDalEmp.SaveUpdateEmp(obj.EmpAddDetails);
                if (result != null && result.Contains("1#"))
                {
                    string NewEmpID = result.Split('#')[1];
                    string registerResult = await Register(obj.EmpAddDetails.Email, obj.Role ?? "Employee", NewEmpID);
                    if (registerResult == "success")
                    {
                        TempData["ErrMsg"] = "0";
                        return RedirectToAction("AddEmp");
                    }
                    else
                    {
                        DeleteUser(NewEmpID);
                        TempData["ErrMsg"] = "1";
                    }
                }
                else
                {
                    TempData["ErrMsg"] = result;
                }
            }
            return View(obj);
        }

        public ActionResult EditEmp(string id)
        {
            ViewBag.ActiveURL = "/EmpManage/EmpList";
            EmpAdd obj = new EmpAdd();
            obj.EmpAddDetails = objDalEmp.GetEmpDetailsByID(id);
            obj.StateDDList = objDalConfig.GetStateDDList();
            obj.DesignationDDList = objDalEmp.GetDesignationList();
            obj.RolesDDList = objDalEmp.GetRoleList();
            return View(obj);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditEmp(EmpAdd obj)
        {
            ViewBag.ActiveURL = "/EmpManage/EmpList";
            string result = "";
            obj.StateDDList = objDalConfig.GetStateDDList();
            obj.DesignationDDList = objDalEmp.GetDesignationList();
            obj.RolesDDList = objDalEmp.GetRoleList();
            if (ModelState.IsValid)
            {
                result = objDalEmp.SaveUpdateEmp(obj.EmpAddDetails);
                if (result == "0")
                {
                    TempData["ErrMsg"] = "0";
                    return RedirectToAction("EmpList");
                }
                else
                {
                    TempData["ErrMsg"] = result;
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
                    var result = await _userManager.CreateAsync(user, "Pass@1234#");
                    if (result.Succeeded)
                    {
                        await _userManager.AddToRoleAsync(user, Role);
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
            return RedirectToAction("EmpList", "EmpManage");
        }

        public void DeleteUser(string EmpID)
        {
            objDalEmp.DeleteEmpDetails(EmpID);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DisableUser(string id, int PgNo, int PgSize, int ListCount, string SearchTerm = "")
        {
            if (ModelState.IsValid)
            {
                if (id == null)
                {
                    return BadRequest();
                }

                var user = await _userManager.FindByIdAsync(id);
                if (user == null)
                {
                    return NotFound();
                }
                user.IsActive = !user.IsActive;
                var result = await _userManager.UpdateAsync(user);
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
                if (ListCount == 1)
                {
                    PgNo = PgNo - 1;
                }
            }
            return RedirectToAction("EmpList", "EmpManage", new { PageNo = PgNo, PageSize = PgSize, SearchTerm = SearchTerm });
        }
    }
}
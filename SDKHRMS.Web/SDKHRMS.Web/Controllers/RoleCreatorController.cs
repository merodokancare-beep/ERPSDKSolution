using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SDKHRMS.Web.HtmlHelpers;
using SDKHRMS.Web.Models;
using System;
using System.Linq;

namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin")]
    public class RoleCreatorController : BaseController
    {
        private readonly ApplicationDbContext _context;

        public RoleCreatorController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: RoleCreator
        public ActionResult Index()
        {
            return RedirectToAction("RoleList");
        }

        public ActionResult RoleList()
        {
            var roles = _context.Roles.ToList();

            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvRoleList", roles);
            }
            return View(roles);
        }

        public ActionResult AddRole()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddRole(IdentityRole role)
        {
            if (ModelState.IsValid)
            {
                _context.Roles.Add(role);
                _context.SaveChanges();
                TempData["ErrMsg"] = "0";
                return RedirectToAction("RoleList");
            }
            return View();
        }

        [HttpPost]
        public ActionResult DeleteRole(string id)
        {
            try
            {
                var roleToDelete = _context.Roles.Find(id);
                if (roleToDelete != null)
                {
                    _context.Roles.Remove(roleToDelete);
                    _context.SaveChanges();
                }
                TempData["ErrMsg"] = "0";
                return RedirectToAction("RoleList", "RoleCreator");
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
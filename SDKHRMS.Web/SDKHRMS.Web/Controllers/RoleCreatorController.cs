using SDKHRMS.Web.Models;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SDKHRMS.Web.HtmlHelpers;

namespace SDKHRMS.Web.Controllers
{
   [UserAuthorize(Roles = "Admin,Super Admin")]
    public class RoleCreatorController : Controller
    {
        // GET: RoleCreator
        public ActionResult RoleList()
        {

            ApplicationDbContext context = new ApplicationDbContext();
            var Roles = context.Roles.ToList();

            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvRoleList", Roles);
            }
            return View(Roles);
        }
        public ActionResult AddRole()
        {

            return View();
        }

        [HttpPost]
        public ActionResult AddRole(IdentityRole Role)
        {


            //if (Session["username"] == null)
            //{
            //    return RedirectToAction("login", "account", new { Area = "" });
            //}
            ApplicationDbContext context = new ApplicationDbContext();
            if (ModelState.IsValid)
            {
                context.Roles.Add(Role);
                context.SaveChanges();
                TempData["ErrMsg"] = "0";
                return RedirectToAction("RoleList");
            }
            return View();
        }

        [HttpPost]
        public ActionResult DeleteRole(string ID)
        {
            //if (Session["username"] == null)
            //{
            //    return RedirectToAction("login", "account", new { Area = "" });
            //}
            ApplicationDbContext context = new ApplicationDbContext();
            IdentityRole RoleToDelete = new IdentityRole();
            try
            {
                RoleToDelete = context.Roles.Find(ID);
                context.Roles.Remove(RoleToDelete);
                context.SaveChanges();
                TempData["ErrMsg"] = "0";
                return RedirectToAction("RoleList", "RoleCreator", new { Area = "" });
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
}
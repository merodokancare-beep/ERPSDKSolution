using System.Web;
using System.Web.Optimization;

namespace SDKHRMS.Web
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/admin.js",
                        "~/Scripts/CustomAjax.js",
                        "~/Content/Plugins/Toastr/toastr.min.js",
                        "~/Content/Plugins/Select2/select2.min.js",
                        "~/Content/metisMenu/metisMenu.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/admin.css",
                      "~/Content/ns-pager-style.css",
                      "~/Content/Plugins/Toastr/toastr.min.css",
                      "~/Content/Plugins/Select2/select2.min.css",
                      "~/Content/metisMenu/metisMenu.min.css"));
            bundles.Add(new StyleBundle("~/Content/css-gen").Include(
                   "~/Content/bootstrap.css",
                   "~/Content/site.css"));

            //bundles.Add(new ScriptBundle("~/bundles/jquery-gen").Include(
            //             "~/Scripts/jquery-{version}.js"
            //             ));
            //bundles.Add(new ScriptBundle("~/bundles/js-gen").Include(
            //"~/Scripts/General/wow.min.js",
            //              "~/Scripts/General/main.js"
            //             ));

        }
    }
}

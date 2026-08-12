using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SDKHRMS.Web.Startup))]
namespace SDKHRMS.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

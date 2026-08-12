using System.IO;

namespace SDKHRMS.Web
{
    public static class Server
    {
        public static string MapPath(string path)
        {
            if (string.IsNullOrEmpty(path)) return string.Empty;
            string webRoot = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot");
            string relativePath = path.Replace("~/", "").Replace("~", "").TrimStart('/', '\\');
            return Path.Combine(webRoot, relativePath);
        }
    }
}

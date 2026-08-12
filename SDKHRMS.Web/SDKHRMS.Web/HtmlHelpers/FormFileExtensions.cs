using System.IO;
using Microsoft.AspNetCore.Http;

namespace Microsoft.AspNetCore.Http
{
    public static class FormFileExtensions
    {
        public static long ContentLength(this IFormFile file)
        {
            return file?.Length ?? 0;
        }

        public static void SaveAs(this IFormFile file, string path)
        {
            if (file == null) return;
            string dir = Path.GetDirectoryName(path);
            if (!string.IsNullOrEmpty(dir) && !Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
            }
            using (var stream = new FileStream(path, FileMode.Create))
            {
                file.CopyTo(stream);
            }
        }
    }
}

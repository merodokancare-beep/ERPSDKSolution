using System;
using System.IO;
using System.Reflection;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace Rotativa.Options
{
    public enum Size { A4, Letter, A3, A5, Legal }
    public enum Orientation { Portrait, Landscape }
    public class Margins
    {
        public int Top { get; set; }
        public int Right { get; set; }
        public int Bottom { get; set; }
        public int Left { get; set; }

        public Margins() { }
        public Margins(int top, int right, int bottom, int left)
        {
            Top = top;
            Right = right;
            Bottom = bottom;
            Left = left;
        }
    }
}

namespace Rotativa
{
    internal static class RotativaInitializer
    {
        private static bool _initialized = false;
        private static readonly object _lock = new object();

        public static void EnsureSetup()
        {
            if (_initialized) return;
            lock (_lock)
            {
                if (_initialized) return;
                try
                {
                    var contentRoot = Directory.GetCurrentDirectory();
                    var baseDir = AppContext.BaseDirectory;

                    string rotativaDir = null;
                    string[] candidates = new string[]
                    {
                        Path.Combine(contentRoot, "Rotativa"),
                        Path.Combine(contentRoot, "wwwroot", "Rotativa"),
                        Path.Combine(baseDir, "Rotativa"),
                        Path.Combine(baseDir, "wwwroot", "Rotativa")
                    };

                    foreach (var dir in candidates)
                    {
                        if (Directory.Exists(dir) && (File.Exists(Path.Combine(dir, "wkhtmltopdf.exe")) || File.Exists(Path.Combine(dir, "wkhtmltopdf"))))
                        {
                            rotativaDir = dir;
                            break;
                        }
                    }

                    if (rotativaDir == null)
                    {
                        rotativaDir = candidates[0];
                    }

                    var type = typeof(Rotativa.AspNetCore.RotativaConfiguration);
                    var fields = type.GetFields(BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.Public);
                    foreach (var f in fields)
                    {
                        if (f.FieldType == typeof(string) && (f.Name.IndexOf("path", StringComparison.OrdinalIgnoreCase) >= 0 || f.Name.IndexOf("rotativa", StringComparison.OrdinalIgnoreCase) >= 0))
                        {
                            f.SetValue(null, rotativaDir);
                        }
                    }

                    _initialized = true;
                }
                catch
                {
                }
            }
        }
    }

    public class ViewAsPdf : Rotativa.AspNetCore.ViewAsPdf
    {
        public ViewAsPdf() : base() { RotativaInitializer.EnsureSetup(); }
        public ViewAsPdf(string viewName) : base(viewName) { RotativaInitializer.EnsureSetup(); }
        public ViewAsPdf(object model) : base(model) { RotativaInitializer.EnsureSetup(); }
        public ViewAsPdf(string viewName, object model) : base(viewName, model) { RotativaInitializer.EnsureSetup(); }

        public new Rotativa.Options.Margins PageMargins
        {
            get => base.PageMargins == null ? null : new Rotativa.Options.Margins((int)base.PageMargins.Top, (int)base.PageMargins.Right, (int)base.PageMargins.Bottom, (int)base.PageMargins.Left);
            set => base.PageMargins = value == null ? null : new Rotativa.AspNetCore.Options.Margins(value.Top, value.Right, value.Bottom, value.Left);
        }

        public new Rotativa.Options.Size PageSize
        {
            get => (Rotativa.Options.Size)base.PageSize;
            set => base.PageSize = (Rotativa.AspNetCore.Options.Size)value;
        }

        public new Rotativa.Options.Orientation PageOrientation
        {
            get => (Rotativa.Options.Orientation)base.PageOrientation;
            set => base.PageOrientation = (Rotativa.AspNetCore.Options.Orientation)value;
        }

        public override Task ExecuteResultAsync(ActionContext context)
        {
            RotativaInitializer.EnsureSetup();
            return base.ExecuteResultAsync(context);
        }
    }

    public class PartialViewAsPdf : Rotativa.AspNetCore.ViewAsPdf
    {
        public PartialViewAsPdf() : base() { RotativaInitializer.EnsureSetup(); }
        public PartialViewAsPdf(string viewName) : base(viewName) { RotativaInitializer.EnsureSetup(); }
        public PartialViewAsPdf(object model) : base(model) { RotativaInitializer.EnsureSetup(); }
        public PartialViewAsPdf(string viewName, object model) : base(viewName, model) { RotativaInitializer.EnsureSetup(); }

        public new Rotativa.Options.Margins PageMargins
        {
            get => base.PageMargins == null ? null : new Rotativa.Options.Margins((int)base.PageMargins.Top, (int)base.PageMargins.Right, (int)base.PageMargins.Bottom, (int)base.PageMargins.Left);
            set => base.PageMargins = value == null ? null : new Rotativa.AspNetCore.Options.Margins(value.Top, value.Right, value.Bottom, value.Left);
        }

        public new Rotativa.Options.Size PageSize
        {
            get => (Rotativa.Options.Size)base.PageSize;
            set => base.PageSize = (Rotativa.AspNetCore.Options.Size)value;
        }

        public new Rotativa.Options.Orientation PageOrientation
        {
            get => (Rotativa.Options.Orientation)base.PageOrientation;
            set => base.PageOrientation = (Rotativa.AspNetCore.Options.Orientation)value;
        }

        public override Task ExecuteResultAsync(ActionContext context)
        {
            RotativaInitializer.EnsureSetup();
            return base.ExecuteResultAsync(context);
        }
    }
}

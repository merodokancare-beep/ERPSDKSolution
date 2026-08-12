using Microsoft.AspNetCore.Mvc;

namespace Rotativa.Options
{
    public enum Size { A4, Letter }
    public enum Orientation { Portrait, Landscape }
    public class Margins
    {
        public Margins(int top, int right, int bottom, int left) { }
    }
}

namespace Rotativa
{
    public class ViewAsPdf : Rotativa.AspNetCore.ViewAsPdf
    {
        public ViewAsPdf() : base() { }
        public ViewAsPdf(string viewName, object model) : base(viewName, model) { }
        public Rotativa.Options.Margins PageMargins { get; set; }
        public Rotativa.Options.Size PageSize { get; set; }
        public Rotativa.Options.Orientation PageOrientation { get; set; }
    }

    public class PartialViewAsPdf : Rotativa.AspNetCore.ViewAsPdf
    {
        public PartialViewAsPdf() : base() { }
        public PartialViewAsPdf(string viewName, object model) : base(viewName, model) { }
        public Rotativa.Options.Margins PageMargins { get; set; }
        public Rotativa.Options.Size PageSize { get; set; }
        public Rotativa.Options.Orientation PageOrientation { get; set; }
    }
}

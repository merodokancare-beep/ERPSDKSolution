using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.Rendering;
using SDKHRMS.Entities.ViewModels;
using System;
using System.IO;
using System.Text;
using System.Text.Encodings.Web;

namespace SDKHRMS.Web.HtmlHelpers
{
    public static class PagingHelper
    {
        public static HtmlString PageLinks(this IHtmlHelper html, PagingInfo pagingInfo, Func<int, string> pageUrl, string dropdowncssclass = "", string labelcssclass = "pager-label")
        {
            StringBuilder result = new StringBuilder();
            int prevPageNo, nextPageNo, lastPageNo;
            prevPageNo = pagingInfo.CurrentPage > 1 ? (pagingInfo.CurrentPage - 1) : 1;
            nextPageNo = pagingInfo.CurrentPage < pagingInfo.TotalPages ? (pagingInfo.CurrentPage + 1) : pagingInfo.CurrentPage;
            lastPageNo = pagingInfo.TotalPages;

            result.Append("&nbsp;<label class= page-size-label '" + labelcssclass + "'>Page Size:</label>");
            result.Append("&nbsp;&nbsp;<select class='page-size " + dropdowncssclass + "'>");

            if (pagingInfo.ItemsPerPage == 10)
            {
                result.Append("<option value='10' selected='selected'>10</option>");
                result.Append("<option value='20'>20</option>");
                result.Append("<option value='30'>30</option>");
                result.Append("<option value='50'>50</option>");
            }
            else if (pagingInfo.ItemsPerPage == 20)
            {
                result.Append("<option value='10'>10</option>");
                result.Append("<option value='20' selected='selected'>20</option>");
                result.Append("<option value='30'>30</option>");
                result.Append("<option value='50'>50</option>");
            }
            else if (pagingInfo.ItemsPerPage == 30)
            {
                result.Append("<option value='10'>10</option>");
                result.Append("<option value='20'>20</option>");
                result.Append("<option value='30' selected='selected'>30</option>");
                result.Append("<option value='50'>50</option>");
            }
            else if (pagingInfo.ItemsPerPage == 50)
            {
                result.Append("<option value='10'>10</option>");
                result.Append("<option value='20'>20</option>");
                result.Append("<option value='30'>30</option>");
                result.Append("<option value='50' selected='selected'>50</option>");
            }
            result.Append("</select>&nbsp;&nbsp;&nbsp;");

            TagBuilder tagFirst = new TagBuilder("a");
            if (pagingInfo.CurrentPage == 1)
            {
                tagFirst.AddCssClass("ns-page-link-disabled");
            }
            else
            {
                tagFirst.MergeAttribute("href", pageUrl(1));
                tagFirst.AddCssClass("ns-page-link");
            }
            tagFirst.AddCssClass("fe fe-chevrons-left");
            result.Append(GetString(tagFirst));

            TagBuilder tagPrev = new TagBuilder("a");
            if (pagingInfo.CurrentPage == 1)
            {
                tagPrev.AddCssClass("ns-page-link-disabled");
            }
            else
            {
                tagPrev.MergeAttribute("href", pageUrl(prevPageNo));
                tagPrev.AddCssClass("ns-page-link");
            }
            tagPrev.AddCssClass("fe fe-chevron-left");
            result.Append(GetString(tagPrev));

            result.Append("&nbsp;<label class='" + labelcssclass + "'>Page</label>");
            result.Append("&nbsp;&nbsp;<select class='page-number " + dropdowncssclass + "'>");
            for (int i = 1; i <= pagingInfo.TotalPages; i++)
            {
                if (i == pagingInfo.CurrentPage)
                {
                    result.Append("<option value='" + i + "' selected='selected'>" + i + "</option>");
                }
                else
                {
                    result.Append("<option value='" + i + "' >" + i + "</option>");
                }
            }
            result.Append("</select>");
            result.Append("&nbsp;&nbsp;<label class='" + labelcssclass + "'>of</label>");
            result.Append("&nbsp;&nbsp;<label class='" + labelcssclass + "'>" + pagingInfo.TotalPages + "</label>&nbsp;&nbsp;");

            TagBuilder tagNext = new TagBuilder("a");
            if (pagingInfo.CurrentPage == pagingInfo.TotalPages)
            {
                tagNext.AddCssClass("ns-page-link-disabled");
            }
            else
            {
                tagNext.MergeAttribute("href", pageUrl(nextPageNo));
                tagNext.AddCssClass("ns-page-link");
            }
            tagNext.AddCssClass("fe fe-chevron-right");
            result.Append(GetString(tagNext));

            TagBuilder tagLast = new TagBuilder("a");
            if (pagingInfo.CurrentPage == lastPageNo)
            {
                tagLast.AddCssClass("ns-page-link-disabled");
            }
            else
            {
                tagLast.MergeAttribute("href", pageUrl(lastPageNo));
                tagLast.AddCssClass("ns-page-link");
            }
            tagLast.AddCssClass("fe fe-chevrons-right");
            result.Append(GetString(tagLast));

            return new HtmlString(result.ToString());
        }

        private static string GetString(TagBuilder tagBuilder)
        {
            using var writer = new StringWriter();
            tagBuilder.WriteTo(writer, HtmlEncoder.Default);
            return writer.ToString();
        }
    }
}
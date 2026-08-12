using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDKHRMS.Entities.ViewModels
{
    public class PagingInfo
    {
        public int TotalItems { get; set; }
        public int ItemsPerPage { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages
        {
            get
            {
                return (int)Math.Ceiling((decimal)TotalItems / (ItemsPerPage == 0 ? 1 : ItemsPerPage));
            }
        }
    }
     public class PageParameters
        {
            public int PageNo { get; set; }
            public int PageSize { get; set; }
            public int ListCount { get; set; }
            public string SearchTerm { get; set; }
        }
}

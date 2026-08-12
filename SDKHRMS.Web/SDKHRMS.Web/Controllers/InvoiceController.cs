using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.Models;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.HtmlHelpers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin,Employee,Accountant")]
    public class InvoiceController : Controller
    {
        InvoiceViewModel objInv = new InvoiceViewModel();
        dalConfiguration objDalConfig = new dalConfiguration();
        dalInvoice objDalinv = new dalInvoice();
        dalPayment dalpayment = new dalPayment();
        // GET: /Invoice/
        #region Sale Invoice
        public ActionResult SaleInvoiceList(int PageNo = 1, int PageSize = 20, int YearNo = 0, int MonNo = 0, long Client = 0, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/Invoice/Invoicelist";
            SaleInvoiceVM model = new SaleInvoiceVM();
            ViewBag.SearchTerm = SearchTerm;
            ViewBag.YearNo = YearNo;
            ViewBag.MonNo = MonNo;
            ViewBag.Client = Client;
            model = objDalinv.GetSaleInvoiceList(PageNo, PageSize, SearchTerm, YearNo, MonNo, Client);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            model.SaleYearDD = objDalinv.GetSaleYearDD();
            model.ClientDDList = objDalinv.GetVendorDDList();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvSaleInvoiceList", model);
            }
            return View(model);
        }
        public ActionResult SaleInvoice()
        {
            ViewBag.ActiveURL = "/Invoice/SaleInvoiceList";
            InvoiceAddViewModel model = new InvoiceAddViewModel();
            model.VendorDDList = objDalinv.GetVendorDDList();
            model.ProjectDDList = objDalConfig.GetProjectDDList();
            //objInv.InvoiveNoDetails = objDalinv.GetInvoiceDetails();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaleInvoice(InvoiceAddViewModel item)
        {
            ViewBag.ActiveURL = "/Invoice/SaleInvoiceList";
            if (item.SaleInvoiceKeyModel.AdvanceReceived > item.SaleInvoiceKeyModel.IncludingTaxAmt)
            {
                ModelState.AddModelError("SaleInvoiceKeyModel.AdvanceReceived", "Advance or Deduction Amount is not Greater then Net Amount");
            }
            else
            {
                if ((item.SaleInvoiceKeyModel.AdvanceReceived > 0) && string.IsNullOrEmpty((item.SaleInvoiceKeyModel.ReceivedRemarks)))
                {
                    ModelState.AddModelError("SaleInvoiceKeyModel.ReceivedRemarks", "Deduction Remarks is Require if you enter Deduction Amount");
                }
                else if ((item.SaleInvoiceKeyModel.AdvanceReceived == 0) && !string.IsNullOrEmpty(item.SaleInvoiceKeyModel.ReceivedRemarks))
                {
                    ModelState.AddModelError("SaleInvoiceKeyModel.AdvanceReceived", "Deduction Amount is Require if you enter Deduction Remarks");
                }
                else if (item.SaleInvoiceKeyModel.AdvanceReceived < 0)
                {
                    ModelState.AddModelError("SaleInvoiceKeyModel.AdvanceReceived", "Please enter valid Deduction Amount");
                }
            }
            if (ModelState.IsValid)
            {
                item.SaleInvoiceKeyModel.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalinv.SaveSaleInvoice(item);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("SaleInvoiceList");
                }
            }
            item.VendorDDList = objDalinv.GetVendorDDList();
            item.ProjectDDList = objDalConfig.GetProjectDDList();
            return View(item);
        }
        public ActionResult EditSaleInvoice(string InvID, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/Invoice/SaleInvoiceList";
            InvoiceAddViewModel model = new InvoiceAddViewModel();
            model.VendorDDList = objDalinv.GetVendorDDList();
            model.ProjectDDList = objDalConfig.GetProjectDDList();
            model.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            model.SaleInvoiceKeyModel = objDalinv.GetSaleInvDetailsByID(InvID);
            model.CustomInvoiceItemList = objDalinv.GetSaleInvItemListByID(InvID);
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditSaleInvoice(InvoiceAddViewModel item)
        {
            ViewBag.ActiveURL = "/Invoice/SaleInvoiceList";
            if (item.SaleInvoiceKeyModel.AdvanceReceived > item.SaleInvoiceKeyModel.IncludingTaxAmt)
            {
                ModelState.AddModelError("SaleInvoiceKeyModel.AdvanceReceived", "Advance or Deduction Amount is not Greater then Net Amount");
            }
            else
            {
                if ((item.SaleInvoiceKeyModel.AdvanceReceived > 0) && string.IsNullOrEmpty((item.SaleInvoiceKeyModel.ReceivedRemarks)))
                {
                    ModelState.AddModelError("SaleInvoiceKeyModel.ReceivedRemarks", "Deduction Remarks is Require if you enter Deduction Amount");
                }
                else if ((item.SaleInvoiceKeyModel.AdvanceReceived == 0) && !string.IsNullOrEmpty(item.SaleInvoiceKeyModel.ReceivedRemarks))
                {
                    ModelState.AddModelError("SaleInvoiceKeyModel.AdvanceReceived", "Deduction Amount is Require if you enter Deduction Remarks");
                }
                else if (item.SaleInvoiceKeyModel.AdvanceReceived < 0)
                {
                    ModelState.AddModelError("SaleInvoiceKeyModel.AdvanceReceived", "Please enter valid Deduction Amount");
                }
            }
            if (ModelState.IsValid)
            {
                item.SaleInvoiceKeyModel.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalinv.SaveSaleInvoice(item);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("SaleInvoiceList", new { PageNo = item.PageParameter.PageNo, PageSize = item.PageParameter.PageSize, SearchTerm = item.PageParameter.SearchTerm });
                }
            }
            item.VendorDDList = objDalinv.GetVendorDDList();
            item.ProjectDDList = objDalConfig.GetProjectDDList();
            return View(item);
        }

        public ActionResult InvoiceItemListByID(string InvID)
        {
            List<ItemsView> model = new List<ItemsView>();
            //model.SaleInvoiceKeyModel = objDalinv.GetSaleInvDetailsByID(InvID);
            model = objDalinv.GetItemListByID(InvID, "Sale");
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvSaleInvItemList", model);
            }
            return View(model);
        }
        public ActionResult SaleInvoiceDetails(string ID)
        {
            ViewBag.ActiveURL = "/Invoice/SaleInvoiceList";
            SaleInvoiceKeyView model = new SaleInvoiceKeyView();
            ViewBag.SaleInvID = ID;
            model = objDalinv.GetSaleInvoceDtlsByID(ID);
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CancelledSaleInvoice(string ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalinv.CancelledSaleInvoice(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("SaleInvoiceList", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        #endregion

        #region Purchase Invoice
        public ActionResult PurchaseInvoiceList(int PageNo = 1, int PageSize = 20, int YearNo = 0, int MonNo = 0, long Vendor = 0, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/Invoice/Invoicelist";
            PurchaseInvoiceVM model = new PurchaseInvoiceVM();
            ViewBag.SearchTerm = SearchTerm;
            ViewBag.YearNo = YearNo;
            ViewBag.MonNo = MonNo;
            ViewBag.Vendor = Vendor;
            model = objDalinv.GetPurchaseInvoiceList(PageNo, PageSize, SearchTerm, YearNo, MonNo, Vendor);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            model.PurchaseYearDD = objDalinv.GetPurchaseYearDD();
            model.VendorDDList = objDalinv.GetVendorDDList();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPurchaseInvoiceList", model);
            }
            return View(model);
        }
        public ActionResult PurchaseInvoice()
        {
            ViewBag.ActiveURL = "/Invoice/PurchaseInvoiceList";
            PurchaseAddViewModel model = new PurchaseAddViewModel();
            model.VendorDDList = objDalinv.GetVendorDDList();
            model.ProjectDDList = objDalConfig.GetProjectDDList();
            model.ShipTo = GetDefaultAddress();
            //objInv.InvoiveNoDetails = objDalinv.GetInvoiceDetails();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PurchaseInvoice(PurchaseAddViewModel item, HttpPostedFileBase UploaBill)
        {
            ViewBag.ActiveURL = "/Invoice/PurchaseInvoiceList";
            string FileStatus = "Failure";
            if (UploaBill != null)
            {
                FileStatus = CheckAndUpload(UploaBill, "UploadBill");
                if (!FileStatus.Contains("Failure"))
                {
                    item.PurchaseInvoiceKeyModel.UploadBill = FileStatus;
                }
                else
                {
                    ModelState.AddModelError("BillsError", FileStatus);
                }
            }
            if (item.PurchaseInvoiceKeyModel.POType == "Without Purchase Order" && string.IsNullOrEmpty(item.PurchaseInvoiceKeyModel.BillNo))
                ModelState.AddModelError("PurchaseInvoiceKeyModel.BillNo", "Bill No. is required");

            if (ModelState.IsValid)
            {
                item.PurchaseInvoiceKeyModel.UserID = User.Identity.Name;
                item.PurchaseInvoiceKeyModel.ShipTo = item.ShipTo;
                TempData["ErrMsg"] = objDalinv.SavePurchaseInvoice(item);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("PurchaseInvoiceList");
                }
            }

            item.VendorDDList = objDalinv.GetVendorDDList();
            item.ProjectDDList = objDalConfig.GetProjectDDList();
            return View(item);
        }
        public ActionResult EditPurchaseInvoice(string InvID, int PageNo, int PageSize, string SearchTerm = "")
        {
            ViewBag.ActiveURL = "/Invoice/PurchaseInvoiceList";
            PurchaseAddViewModel model = new PurchaseAddViewModel();
            model.VendorDDList = objDalinv.GetVendorDDList();
            model.ProjectDDList = objDalConfig.GetProjectDDList();
            model.PageParameter = new PageParameters { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm };
            model.PurchaseInvoiceKeyModel = objDalinv.GetPurchaseInvDetailsByID(InvID);
            model.CustomInvoiceItemList = objDalinv.GetPurchaseInvItemListByID(InvID);
            model.ShipTo = model.PurchaseInvoiceKeyModel.ShipTo ?? GetDefaultAddress();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditPurchaseInvoice(PurchaseAddViewModel item, HttpPostedFileBase UploaBill)
        {
            ViewBag.ActiveURL = "/Invoice/PurchaseInvoiceList";
            string FileStatus = "Failure";
            if (UploaBill != null)
            {
                FileStatus = CheckAndUpload(UploaBill, "UploadBill");
                if (!FileStatus.Contains("Failure"))
                {
                    item.PurchaseInvoiceKeyModel.UploadBill = FileStatus;
                }
                else
                {
                    ModelState.AddModelError("BillsError", FileStatus);
                }
            }
            if (item.PurchaseInvoiceKeyModel.POType == "Without Purchase Order" && string.IsNullOrEmpty(item.PurchaseInvoiceKeyModel.BillNo))
                ModelState.AddModelError("PurchaseInvoiceKeyModel.BillNo", "Bill No. is required");
            //if(item.PurchaseInvoiceKeyModel.POType == "With Purchase Order")
            //    item.PurchaseInvoiceKeyModel.BillNo = "";
            if (ModelState.IsValid)
            {
                item.PurchaseInvoiceKeyModel.ShipTo = item.ShipTo;
                item.PurchaseInvoiceKeyModel.UserID = User.Identity.Name;
                TempData["ErrMsg"] = objDalinv.SavePurchaseInvoice(item);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("PurchaseInvoiceList", new { PageNo = item.PageParameter.PageNo, PageSize = item.PageParameter.PageSize, SearchTerm = item.PageParameter.SearchTerm });
                }
            }
            item.VendorDDList = objDalinv.GetVendorDDList();
            item.ProjectDDList = objDalConfig.GetProjectDDList();
            return View(item);
        }
        public ActionResult PurchaseItemListByID(string PurID)
        {
            InvoiceViewModel model = new InvoiceViewModel();
            //model.PurchaseInvoiceKeyModel = objDalinv.GetPurchaseInvDetailsByID(PurID);
            model.ItemsViewList = objDalinv.GetItemListByID(PurID, "Purchase");
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPurchaseInvItemList", model);
            }
            return View(model);
        }
        private string GetDefaultAddress()
        {
            return "Sabir Alam (SDK Solutions)\nSecond Floor Deewan Building,\nDaragoan,Tadong, Gangtok, East Sikkim - 737102\nPhone: +91 9733116414 | Email: info@sdksolution.in";
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CancelledPO(string ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalinv.CancelledPO(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("PurchaseInvoiceList", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult MarkForPayment(string ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalinv.MarkForPayment(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("PurchaseInvoiceList", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }

        public ActionResult ExportPO(string POID)
        {
            POExportVM model = new POExportVM();
            model.PODetails = dalpayment.GetPOPaymentDtlsByID(POID);
            model.POItemsList = objDalinv.GetItemListByID(POID, "Purchase");
            model.VendorDetails = objDalConfig.GetVendorByID(model.PODetails.VenderID);
            decimal RoundOfAmount = Math.Round(model.PODetails.IncludingTaxAmt);// Round of BalanceAmount 
            model.FigureAmount = NumberToWords(Convert.ToInt32(RoundOfAmount));
            ViewBag.RoundOfValue = RoundOfAmount - model.PODetails.IncludingTaxAmt;// Round Of By 
            ViewBag.RoundOfAmount = RoundOfAmount;
            return new Rotativa.PartialViewAsPdf("_pvDownloadPO", model)
            {
                FileName = "PO" + model.PODetails.PORefNo + ".pdf",
                PageMargins = new Rotativa.Options.Margins(5, 5, 10, 5),
                PageSize = Rotativa.Options.Size.A4
            };
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeletePO(string ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = objDalinv.DeletePO(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }
            return RedirectToAction("PurchaseInvoiceList", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }
        #endregion
        #region Received Amount
        public ActionResult ReceivedAmount()
        {
            ViewBag.ActiveURL = "/Invoice/Invoicelist";
            objInv.VendorDDList = objDalinv.GetVendorDDList();
            return View(objInv);
        }
        #endregion
        //#region Auto Complete
        //[HttpGet]
        //public JsonResult ItemNameAutoSearch(string q)
        //{
        //    List<ItemDD> ItemList = new List<ItemDD>();
        //    ItemList = objDalinv.GetItemList(q);
        //    return Json(ItemList, JsonRequestBehavior.AllowGet);
        //}
        //[HttpGet]
        //public JsonResult GetItemDtlsByID(long ItemID)
        //{
        //    utblMstItem Item = new utblMstItem();
        //    Item = objDalConfig.GetItemByID(ItemID);
        //    return Json(new { success = true, Item = Item }, JsonRequestBehavior.AllowGet);
        //}
        //#endregion
        #region Export Invoice
        public ActionResult ExportSaleInvoice(string InvID)
        {
            objInv.SaleInvoiceKeyModel = objDalinv.GetSaleInvDetailsByID(InvID);
            objInv.ItemsViewList = objDalinv.GetItemListByID(InvID, "Sale");
            objInv.VendorDetails = objDalConfig.GetVendorByID(objInv.SaleInvoiceKeyModel.VenderID);
            objInv.FigureAmount = NumberToWords(Convert.ToInt32(objInv.SaleInvoiceKeyModel.BalanceAmount));
            //model.FigureAmount = NumberToWords(Convert.ToInt32(model.BillingMasterModel.GrandTotalAmt));
            decimal RoundOfAmount = Math.Round(objInv.SaleInvoiceKeyModel.BalanceAmount);// Round of BalanceAmount 
            ViewBag.RoundOfValue = RoundOfAmount - objInv.SaleInvoiceKeyModel.BalanceAmount;// Round Of By 
            ViewBag.RoundOfAmount = RoundOfAmount;
            //return PartialView("_pvDownloadSaleInvoice", objInv);
            return new Rotativa.PartialViewAsPdf("_pvDownloadSaleInvoice", objInv)
            {
                FileName = "Invoice" + objInv.SaleInvoiceKeyModel.ReferenceNo + ".pdf",
                PageMargins = new Rotativa.Options.Margins(5, 5, 10, 5),
                PageSize = Rotativa.Options.Size.A4
            };
        }

        #endregion
        #region Reference No.
        [HttpGet]
        public JsonResult GetRefNumber(DateTime? Datevalue)
        {
            DateTime NewDate = Datevalue ?? DateTime.Now;
            //DateTime NewDate = Convert.ToDateTime(Datevalue);
            objInv.InvoiveNoDetails = objDalinv.GetInvoiceDetails(NewDate);
            return Json(objInv.InvoiveNoDetails, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult GetProjectClientDetails(long id = 0)
        {
            InvoiceAddViewModel model = new InvoiceAddViewModel();
            model.ProjectClientDtlsView = objDalinv.GetProjClienByID(id);
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvVendorDetails", model);
            }
            return View(model);
        }
        public JsonResult WorkingOrderDTNo(long ProjID)
        {
            InvoiceAddViewModel model = new InvoiceAddViewModel();
            model.ProjectClientDtlsView = objDalinv.GetProjClienByID(ProjID);
            return Json(model.ProjectClientDtlsView, JsonRequestBehavior.AllowGet);
        }
        #endregion
        # region NumbersToWords
        public static string NumberToWords(int number)
        {
            if (number == 0)
                return "zero";

            if (number < 0)
                return "minus " + NumberToWords(Math.Abs(number));

            string words = "";

            if ((number / 10000000) > 0)
            {
                words += NumberToWords(number / 10000000) + " Crore ";
                number %= 10000000;
            }
            if ((number / 100000) > 0)
            {
                words += NumberToWords(number / 100000) + " Lakh ";
                number %= 100000;
            }

            if ((number / 1000) > 0)
            {
                words += NumberToWords(number / 1000) + " Thousand ";
                number %= 1000;
            }

            if ((number / 100) > 0)
            {
                words += NumberToWords(number / 100) + " Hundred ";
                number %= 100;
            }

            if (number > 0)
            {
                if (words != "")
                    words += "and ";

                var unitsMap = new[] { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
                var tensMap = new[] { "Zero", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };

                if (number < 20)
                    words += unitsMap[number];
                else
                {
                    words += tensMap[number / 10];
                    if ((number % 10) > 0)
                        words += " " + unitsMap[number % 10];
                }
            }

            return words;
        }
        #endregion
        #region File
        private string CheckAndUpload(HttpPostedFileBase httpPostedFileBase, string filetype)
        {
            var status = "Failure";
            if (httpPostedFileBase.ContentLength == 0)
            {
                status = "Failure, Please Upload a file";
            }
            else if (httpPostedFileBase.ContentLength > 0)
            {
                string fileName = httpPostedFileBase.FileName; // getting File Name
                string fileContentType = httpPostedFileBase.ContentType; // getting ContentType
                byte[] tempFileBytes = new byte[httpPostedFileBase.ContentLength]; // getting filebytes
                var data = httpPostedFileBase.InputStream.Read(tempFileBytes, 0, Convert.ToInt32(httpPostedFileBase.ContentLength));
                var types = FileUploadCheck.FileType.Image;  // Setting Image type
                var result = FileUploadCheck.isValidFile(tempFileBytes, types, fileContentType); // Validate Header
                if (result == false)
                {
                    types = FileUploadCheck.FileType.PDF;  // Setting Pdf type
                    result = FileUploadCheck.isValidFile(tempFileBytes, types, fileContentType); // Validate Header
                }
                if (result == true)
                {
                    int FileLength = 1024 * 1024 * 2; //FileLength 2 MB 
                    if (httpPostedFileBase.ContentLength > FileLength)
                    {
                        status = "Failure, Maximum allowed size is: " + FileLength + " MB";
                    }
                    else
                    {
                        string file_result = SaveFile(httpPostedFileBase, filetype);
                        if (!file_result.Contains("Error"))
                        {
                            status = file_result;
                        }
                        else
                        {
                            status = "Failure, Could not save the uploaded File. Please try Again";
                        }
                    }
                }
                else
                {
                    status = "Failure, Invalid File. Only .pdf,.jpg|jpeg,.png files allowed";
                }
            }
            else
            {
                status = "Failure, Content Length Error";
            }
            return status;
        }
        private string SaveFile(HttpPostedFileBase file, string foldername)
        {
            try
            {
                Guid key = Guid.NewGuid();
                string name = key.ToString();
                string FileExtension = Path.GetExtension(file.FileName);
                string filename = name + FileExtension;
                //Check if directory exist
                if (!System.IO.Directory.Exists(Server.MapPath("~/UploadFile/" + foldername)))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("~/UploadFile/" + foldername)); //Create directory if it doesn't exist
                }
                var path = Path.Combine(Server.MapPath("~/UploadFile/" + foldername), filename);
                file.SaveAs(path);
                return filename;
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        public class FileUploadCheck
        {
            private enum ImageFileExtension
            {
                none = 0,
                jpg = 1,
                jpeg = 2,
                bmp = 3,
                gif = 4,
                png = 5
            }
            private enum PDFFileExtension
            {
                none = 0,
                PDF = 1
            }
            public enum FileType
            {
                Image = 1,
                Video = 2,
                PDF = 3,
                Text = 4,
                DOC = 5,
                DOCX = 6,
                PPT = 7,
            }
            public static bool isValidFile(byte[] bytFile, FileType flType, String FileContentType)
            {
                bool isvalid = false;
                if (flType == FileType.Image)
                {
                    isvalid = isValidImageFile(bytFile, FileContentType);//we are going call this method
                }
                else if (flType == FileType.PDF)
                {
                    isvalid = isValidPDFFile(bytFile, FileContentType);
                }
                return isvalid;
            }
            public static bool isValidPDFFile(byte[] bytFile, String FileContentType)
            {
                byte[] chkBytepdf = { 37, 80, 68, 70 };
                bool isvalid = false;

                PDFFileExtension pdffileExtn = PDFFileExtension.none;
                if (FileContentType.Contains("pdf"))
                {
                    pdffileExtn = PDFFileExtension.PDF;
                }

                if (pdffileExtn == PDFFileExtension.PDF)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 3; i++)
                        {
                            if (bytFile[i] == chkBytepdf[i])
                            {
                                j = j + 1;
                                if (j == 3)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }

                return isvalid;
            }
            public static bool isValidImageFile(byte[] bytFile, String FileContentType)
            {
                bool isvalid = false;

                byte[] chkBytejpg = { 255, 216, 255, 224 };
                byte[] chkBytebmp = { 66, 77 };
                byte[] chkBytegif = { 71, 73, 70, 56 };
                byte[] chkBytepng = { 137, 80, 78, 71 };


                ImageFileExtension imgfileExtn = ImageFileExtension.none;

                if (FileContentType.Contains("jpg") | FileContentType.Contains("jpeg"))
                {
                    imgfileExtn = ImageFileExtension.jpg;
                }
                else if (FileContentType.Contains("png"))
                {
                    imgfileExtn = ImageFileExtension.png;
                }
                else if (FileContentType.Contains("bmp"))
                {
                    imgfileExtn = ImageFileExtension.bmp;
                }
                else if (FileContentType.Contains("gif"))
                {
                    imgfileExtn = ImageFileExtension.gif;
                }

                if (imgfileExtn == ImageFileExtension.jpg || imgfileExtn == ImageFileExtension.jpeg)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 3; i++)
                        {
                            if (bytFile[i] == chkBytejpg[i])
                            {
                                j = j + 1;
                                if (j == 3)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }


                if (imgfileExtn == ImageFileExtension.png)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 3; i++)
                        {
                            if (bytFile[i] == chkBytepng[i])
                            {
                                j = j + 1;
                                if (j == 3)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }


                if (imgfileExtn == ImageFileExtension.bmp)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 1; i++)
                        {
                            if (bytFile[i] == chkBytebmp[i])
                            {
                                j = j + 1;
                                if (j == 2)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }

                if (imgfileExtn == ImageFileExtension.gif)
                {
                    if (bytFile.Length >= 4)
                    {
                        int j = 0;
                        for (Int32 i = 0; i <= 1; i++)
                        {
                            if (bytFile[i] == chkBytegif[i])
                            {
                                j = j + 1;
                                if (j == 3)
                                {
                                    isvalid = true;
                                }
                            }
                        }
                    }
                }

                return isvalid;
            }
        }

        #endregion
    }
}
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
    [UserAuthorize(Roles = "Admin,Super Admin,Accountant")]
    public class POPaymentController : Controller
    {

        // GET: POPayment
        dalConfiguration objDalConfig = new dalConfiguration();
        dalInvoice objDalinv = new dalInvoice();
        dalPayment dalpayment = new dalPayment();
        public ActionResult Index(int PageNo = 1, int PageSize = 20, long Vendor = 0, string SearchTerm = "", string Status = "")
        {
            ViewBag.ActiveURL = "/POPayment/Index";
            POPaymentVM model = new POPaymentVM();
            Status = (string.IsNullOrEmpty(Status) ? "Active" : Status);
            ViewBag.SearchTerm = SearchTerm;
            ViewBag.Vendor = Vendor;
            ViewBag.Status = Status;
            model = dalpayment.GetPOPaymentList(PageNo, PageSize, SearchTerm, Vendor, Status);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            model.VendorDD = objDalinv.GetVendorDDList();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPOPaymentList", model);
            }
            return View(model);
        }
        public ActionResult POSettlement(string id)
        {
            ViewBag.ActiveURL = "/POPayment/Index";
            POPaymentSettleVM model = new POPaymentSettleVM();
            model.POPaymentDtls = dalpayment.GetPOPaymentDtlsByID(id);
            model.POID = id;
            if (!model.POPaymentDtls.HasMarkForPayment)
            {
                TempData["ErrMsg"] = "Error: Procurement record has not been marked for payment.";
                return RedirectToAction("index", "POPayment", new { Area = "" });
            }
            model.BankDD = objDalConfig.GetBankDD();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult POSettlement(POPaymentSettleVM model, decimal BalanceAmt)
        {
            ViewBag.ActiveURL = "/POPayment/Index";
            string uploadStatus = "Failure";
            if (model.PaymentReleased.PaymentAmt <= 0)
            {
                ModelState.AddModelError("PaymentReleased.PaymentAmt", "Payment figure must be greater than 0");
            }
            else
            {
                if (model.PaymentReleased.PaymentAmt > Math.Round(BalanceAmt + 1) && model.PaymentReleased.PaymentAmt > BalanceAmt + 1)
                {
                    ModelState.AddModelError("PaymentReleased.PaymentAmt", "Payment amount cannot be greater than balance amount");
                }
            }
            if (model.PaymentReleased.PaymentMode != "Cash")
            {
                if (!model.PaymentReleased.BankID.HasValue)
                    ModelState.AddModelError("PaymentReleased.BankID", "Select Bank");

                if (string.IsNullOrEmpty(model.PaymentReleased.PaymentTransNo))
                    ModelState.AddModelError("PaymentReleased.PaymentTransNo", "Enter Cheque/Transaction No.");
            }
            if (model.UploadFile != null)
            {
                uploadStatus = CheckAndUpload(model.UploadFile, "Payments");
                if (!uploadStatus.Contains("Failure"))
                    model.PaymentReleased.UploadedFile = uploadStatus;
                else
                    ModelState.AddModelError("UploadFile", uploadStatus);
            }
            if (ModelState.IsValid)
            {
                model.PaymentReleased.PurchaseInvoiceID = model.POID;
                model.PaymentReleased.AddedBy = User.Identity.Name;
                string Result = dalpayment.SavePaymentRelease(model.PaymentReleased, 0);
                if ((Result.Contains("Success")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("Index", "POPayment", new { Area = "" });
                }
                else
                {
                    TempData["ErrMsg"] = Result;
                    if (!(uploadStatus.Contains("Failure")))
                    {
                        var fullPath = string.Concat(Server.MapPath(uploadStatus));
                        if (System.IO.File.Exists(fullPath))
                        {
                            System.IO.File.Delete(fullPath);
                        }
                    }
                }
            }

            model.POPaymentDtls = dalpayment.GetPOPaymentDtlsByID(model.POID);
            model.BankDD = objDalConfig.GetBankDD();
            return View(model);
        }
        public ActionResult GetPaymentTransByProjID(string ID)
        {
            List<PaymentReleaseView> model = new List<PaymentReleaseView>();
            model = dalpayment.GetPaymentTransByPOID(ID);
            return PartialView("_pvPaymentTransList", model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeletePOPaymentTrans(long PaymentID, string UploadedFile, string POID)
        {
            TempData["ErrMsg"] = dalpayment.DeletePOPaymentTrans(PaymentID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                if (!string.IsNullOrEmpty(UploadedFile))
                {
                    var fullPath = string.Concat(Server.MapPath("~/UploadFile/Payments/" + UploadedFile));
                    if (System.IO.File.Exists(fullPath))
                    {
                        System.IO.File.Delete(fullPath);
                    }
                }
            }
            return RedirectToAction("POSettlement", "POPayment", new { Area = "", id = POID });
        }

        public ActionResult PODetails(string ID)
        {
            ViewBag.ActiveURL = "/POPayment/Index";
            POPaymentView model = new POPaymentView();
            ViewBag.POID = ID;
            model = dalpayment.GetPOPaymentDtlsByID(ID);
            return View(model);
        }

        public ActionResult GetPOItemsByID(string ID)
        {
            List<ItemsView> model = new List<ItemsView>();
            model = objDalinv.GetItemListByID(ID, "Purchase");
            return PartialView("_pvPOItemList", model);

        }
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
                        status = "Failure, Maximum allowed size is: 2 MB";
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
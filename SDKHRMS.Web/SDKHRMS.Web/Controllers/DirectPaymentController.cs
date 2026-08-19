using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.HtmlHelpers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;

namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin,Accountant")]
    public class DirectPaymentController : Controller
    {
        // GET: DirectPayment
        dalConfiguration dalConfig = new dalConfiguration();
        dalPayment dalpayment = new dalPayment();
        // GET: PaymentReceivable
        public ActionResult Index(int PageNo = 1, int PageSize = 10, int YearNo = 0, int MonNo = 0, long ExpHeadID = 0, string Status = "")
        {
            ViewBag.ActiveURL = "/DirectPayment/Index";
            DirectPaymentVM model = new DirectPaymentVM();
            ViewBag.YearNo = YearNo;
            ViewBag.MonNo = MonNo;
            ViewBag.ExpHeadID = ExpHeadID;
            ViewBag.Status = Status;
            model = dalpayment.GetDirectPayment(PageNo, PageSize, YearNo, MonNo, ExpHeadID, Status);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            model.DirectPaymentYearDD = dalpayment.GetDirectPaymentYearDD();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvDirectPaymentList", model);
            }
            return View(model);
        }
        public ActionResult Add()
        {
            ViewBag.ActiveURL = "/DirectPayment/Index";
            DirectPaymentdAdd model = new DirectPaymentdAdd();
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            model.ProjectDD = dalConfig.GetProjectDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Add(DirectPaymentdAdd model)
        {
            if (ModelState.IsValid)
            {
                model.DirectPayment.AddedBy = User.Identity.Name;
                string Result = dalpayment.SaveDirectPayment(model.DirectPayment);
                if (!(Result.Contains("Error")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("index", "DirectPayment", new { Area = "" });
                }
                else
                {
                    TempData["ErrMsg"] = Result;
                }

            }
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            model.ProjectDD = dalConfig.GetProjectDDList();
            return View(model);
        }
        public ActionResult Edit(long id)
        {
            ViewBag.ActiveURL = "/DirectPayment/Index";
            DirectPaymentdAdd model = new DirectPaymentdAdd();
            model.DirectPayment = dalpayment.GetDirectPaymentByID(id);
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            model.ProjectDD = dalConfig.GetProjectDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(DirectPaymentdAdd model)
        {
            if (ModelState.IsValid)
            {
                model.DirectPayment.AddedBy = User.Identity.Name;
                string Result = dalpayment.SaveDirectPayment(model.DirectPayment);
                if (!(Result.Contains("Error")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("index", "DirectPayment", new { Area = "" });
                }
                else
                {
                    TempData["ErrMsg"] = Result;
                }

            }
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            model.ProjectDD = dalConfig.GetProjectDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(long id)
        {
            string Result = dalpayment.DeleteDirectPaymentByID(id);
            TempData["ErrMsg"] = Result;
            return RedirectToAction("index", "DirectPayment", new { Area = "" });
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ApprovedPayment(long ID)
        {
            string Result = dalpayment.ApprovedPayment(ID);
            TempData["ErrMsg"] = Result;
            return RedirectToAction("index", "DirectPayment", new { Area = "" });
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeclinedPayment(long ID)
        {
            string Result = dalpayment.DeclinedPayment(ID);
            TempData["ErrMsg"] = Result;
            return RedirectToAction("index", "DirectPayment", new { Area = "" });
        }
        public ActionResult Settlement(long id)
        {
            ViewBag.ActiveURL = "/DirectPayment/Index";
            DirectPaymentSettleVM model = new DirectPaymentSettleVM();
            model.DirectPayment = dalpayment.GetDirectPaymentDtlsByID(id);
            model.DirectPaymentID = id;
            if (model.DirectPayment.Status == "Pending" || model.DirectPayment.Status == "Declined")
            {
                TempData["ErrMsg"] = "Error: Direct Payment has not been marked as approved.";
                return RedirectToAction("index", "POPayment", new { Area = "" });
            }
            model.BankDD = dalConfig.GetBankDD();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Settlement(DirectPaymentSettleVM model, decimal BalanceAmt, long ExpType)
        {
            ViewBag.ActiveURL = "/DirectPayment/Index";
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
                model.PaymentReleased.DirectPaymentID = model.DirectPaymentID;
                model.PaymentReleased.AddedBy = User.Identity.Name;
                string Result = dalpayment.SavePaymentRelease(model.PaymentReleased, ExpType);
                if ((Result.Contains("Success")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("Index", "DirectPayment", new { Area = "" });
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
            model.DirectPayment = dalpayment.GetDirectPaymentDtlsByID(model.DirectPaymentID);
            model.BankDD = dalConfig.GetBankDD();
            return View(model);
        }

        public ActionResult GetPaymentTransByID(long ID)
        {
            List<PaymentReleaseView> model = new List<PaymentReleaseView>();
            model = dalpayment.GetPaymentTransByID(ID);
            return PartialView("_pvDirectPaymentTransList", model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteDirectPaymentTrans(long PaymentID, string UploadedFile, long ID)
        {
            TempData["ErrMsg"] = dalpayment.DeleteDirectPaymentByID(PaymentID);
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
            return RedirectToAction("Settlement", "DirectPayment", new { Area = "", id = ID });
        }

        public ActionResult PrintVoucher(long ID = 0)
        {
            DirectPaymentSettleVM model = new DirectPaymentSettleVM();
            model.DirectPayment = dalpayment.GetDirectPaymentDtlsByID(ID);
            decimal RoundOfAmount = Math.Round(model.DirectPayment.PaymentAmt);// Round of BalanceAmount 
            ViewBag.FigureAmount = NumberToWords(Convert.ToInt32(RoundOfAmount));
            return new Rotativa.PartialViewAsPdf("_pvPrintVoucher", model)
            {
                ViewData = ViewData,
                FileName = "Voucher No._" + model.DirectPayment.DirectPaymentID + "_" + model.DirectPayment.PaymentDate.ToString("dd MMM yyyy") + ".pdf",
                PageMargins = new Rotativa.Options.Margins(10, 5, 10, 5),
                PageSize = Rotativa.Options.Size.A4
            };

        }
        #region NumbersToWords
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
        private string CheckAndUpload(IFormFile httpPostedFileBase, string filetype)
        {
            var status = "Failure";
            if (httpPostedFileBase == null || httpPostedFileBase.Length == 0)
            {
                status = "Failure, Please Upload a file";
            }
            else if (httpPostedFileBase.Length > 0)
            {
                string fileName = httpPostedFileBase.FileName;
                string fileContentType = httpPostedFileBase.ContentType;
                byte[] tempFileBytes = new byte[httpPostedFileBase.Length];
                using (var stream = httpPostedFileBase.OpenReadStream())
                {
                    stream.Read(tempFileBytes, 0, Convert.ToInt32(httpPostedFileBase.Length));
                }
                var types = FileUploadCheck.FileType.Image;
                var result = FileUploadCheck.isValidFile(tempFileBytes, types, fileContentType);
                if (result == false)
                {
                    types = FileUploadCheck.FileType.PDF;
                    result = FileUploadCheck.isValidFile(tempFileBytes, types, fileContentType);
                }
                if (result == true)
                {
                    int FileLength = 1024 * 1024 * 2;
                    if (httpPostedFileBase.Length > FileLength)
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
        private string SaveFile(IFormFile file, string foldername)
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
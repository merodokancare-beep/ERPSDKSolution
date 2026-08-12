using SDKHRMS.Entities.DataAccess;
using SDKHRMS.Entities.ViewModels;
using SDKHRMS.Web.HtmlHelpers;
using System;
using System.IO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;

namespace SDKHRMS.Web.Controllers
{
    [UserAuthorize(Roles = "Admin,Super Admin,Accountant")]
    public class PaymentController : Controller
    {
        PaymentViewModel objModel = new PaymentViewModel();
        dalPayment dalpayment = new dalPayment();
        dalConfiguration dalconf = new dalConfiguration();
        // GET: /Expense/
        #region Expenses Details
        //Payment Received
        public ActionResult PaymentList(int PageNo = 1, int PageSize = 20, string SearchTerm = "", string PayType = "Received")
        {
            ViewBag.ActiveURL = "/Payment/PaymentList";
            objModel = dalpayment.GetPaymentList(PageNo, PageSize, SearchTerm, PayType);
            objModel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objModel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            ViewBag.Type = PayType;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPaymentList", objModel);
            }
            return View(objModel);
        }
        //Payment Released
        public ActionResult PaymentReleasedList(int PageNo = 1, int PageSize = 20, string SearchTerm = "", string PayType = "Released")
        {
            ViewBag.ActiveURL = "/Payment/PaymentReleasedList";
            objModel = dalpayment.GetPaymentList(PageNo, PageSize, SearchTerm, PayType);
            objModel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objModel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            ViewBag.Type = PayType;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPaymentList", objModel);
            }
            return View(objModel);
        }
        [HttpGet]
        public ActionResult AddPayment(string PayType = "Received")
        {
            PaymentAdd model = new PaymentAdd();
            ViewBag.ActiveURL = "/Payment/PaymentList";
            ViewBag.Type = PayType;
            model.VendorDDList = dalconf.GetVendorDDList();
            model.BankDDList = dalconf.GetBankDD();
            model.ExpenseTypeDDList = dalconf.GetExpenseTypeDD();
            model.ProjectDDList = dalconf.GetProjectDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddPayment(PaymentAdd model, string PayType = "")
        {
            ViewBag.ActiveURL = "/Payment/PaymentList";
            ViewBag.Type = PayType;
            if (model.PaymentDetail.PaymentMode != "Cash")
            {
                if (!model.PaymentDetail.BankID.HasValue)
                    ModelState.AddModelError("PaymentDetail.BankID", "Select Bank");

                if (string.IsNullOrEmpty(model.PaymentDetail.ChequeTransNo))
                    ModelState.AddModelError("PaymentDetail.ChequeTransNo", "Enter Cheque/Transaction No.");
            }
            string uploadStatus = "Failure";
            if (model.UploadFile != null)
            {
                uploadStatus = CheckAndUpload(model.UploadFile, "Payments");
                if (!uploadStatus.Contains("Failure"))
                {
                    model.PaymentDetail.PaymentFile = uploadStatus;
                }
                else
                {
                    ModelState.AddModelError("UploadFile", uploadStatus);
                }
            }
            model.PaymentDetail.PaymentType = PayType;
            model.PaymentDetail.UserID = User.Identity.Name;
            if (ModelState.IsValid)
            {
                string Result = dalpayment.SavePayments(model.PaymentDetail);
                if (!(Result.Contains("Error")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("PaymentList");
                }
            }
            model.VendorDDList = dalconf.GetVendorDDList();
            model.BankDDList = dalconf.GetBankDD();
            model.ExpenseTypeDDList = dalconf.GetExpenseTypeDD();
            model.ProjectDDList = dalconf.GetProjectDDList();
            return View(model);
        }
        [HttpGet]
        public ActionResult EditPayment(string PaymentID = "")
        {
            PaymentAdd model = new PaymentAdd();
            ViewBag.ActiveURL = "/Payment/PaymentList";
            model.PaymentDetail = dalpayment.GetPaymentByID(PaymentID);
            model.VendorDDList = dalconf.GetVendorDDList();
            model.BankDDList = dalconf.GetBankDD();
            model.ExpenseTypeDDList = dalconf.GetExpenseTypeDD();
            model.ProjectDDList = dalconf.GetProjectDDList();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditPayment(PaymentAdd model)
        {
            ViewBag.ActiveURL = "/Payment/PaymentList";
            if (model.PaymentDetail.PaymentMode != "Cash")
            {
                if (!model.PaymentDetail.BankID.HasValue)
                    ModelState.AddModelError("PaymentDetail.BankID", "Select Bank");

                if (string.IsNullOrEmpty(model.PaymentDetail.ChequeTransNo))
                    ModelState.AddModelError("PaymentDetail.ChequeTransNo", "Enter Cheque/Transaction No.");
            }
            string uploadStatus = "Failure";
            if (model.UploadFile != null)
            {
                uploadStatus = CheckAndUpload(model.UploadFile, "Payments");
                if (!uploadStatus.Contains("Failure"))
                {
                    model.PaymentDetail.PaymentFile = uploadStatus;
                }
                else
                {
                    ModelState.AddModelError("UploadFile", uploadStatus);
                }
            }

            model.PaymentDetail.UserID = User.Identity.Name;
            if (ModelState.IsValid)
            {
                string Result = dalpayment.SavePayments(model.PaymentDetail);
                if (!(Result.Contains("Error")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("PaymentList");
                }
            }
            model.VendorDDList = dalconf.GetVendorDDList();
            model.BankDDList = dalconf.GetBankDD();
            model.ExpenseTypeDDList = dalconf.GetExpenseTypeDD();
            model.ProjectDDList = dalconf.GetProjectDDList();
            return View(model);
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
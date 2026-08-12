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
    public class PaymentReceivableController : Controller
    {
        dalConfiguration dalConfig = new dalConfiguration();
        dalPayment dalpayment = new dalPayment();
        // GET: PaymentReceivable
        #region Direct Payment Receive
        public ActionResult Index(int PageNo = 1, int PageSize = 10, int YearNo = 0, int MonNo = 0, long ExpHeadID = 0)
        {
            ViewBag.ActiveURL = "/PaymentReceivable/Index";
            PaymentReceivedVM model = new PaymentReceivedVM();
            ViewBag.YearNo = YearNo;
            ViewBag.MonNo = MonNo;
            ViewBag.ExpHeadID = ExpHeadID;
            model = dalpayment.GetReceiveDirectPayment(PageNo, PageSize, YearNo, MonNo, ExpHeadID);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            model.ReceivePaymentYearDD = dalpayment.GetReceivePaymentYearDD();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvReceiveDirectPayment", model);
            }
            return View(model);
        }
        public ActionResult Add()
        {
            ViewBag.ActiveURL = "/PaymentReceivable/Index";
            PaymentReceivedAdd model = new PaymentReceivedAdd();
            model.BankDD = dalConfig.GetBankDD();
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Add(PaymentReceivedAdd model)
        {
            ViewBag.ActiveURL = "/PaymentReceivable/Index";
            string uploadStatus = "Failure";
            if (model.PaymentReceived.ReceivedMode != "Cash")
            {
                if (!model.PaymentReceived.BankID.HasValue)
                    ModelState.AddModelError("PaymentReceived.BankID", "Select Bank");
                if (string.IsNullOrEmpty(model.PaymentReceived.TransactionNo))
                    ModelState.AddModelError("PaymentReceived.TransactionNo", "Enter Cheque/Transaction No.");
            }
            if (model.UploadFile != null)
            {
                uploadStatus = CheckAndUpload(model.UploadFile, "Payments");
                if (!uploadStatus.Contains("Failure"))
                    model.PaymentReceived.UploadedFile = uploadStatus;
                else
                    ModelState.AddModelError("UploadFile", uploadStatus);
            }
            if (ModelState.IsValid)
            {
                model.PaymentReceived.AddedBy = User.Identity.Name;
                string Result = dalpayment.SavePaymentReceivable(model.PaymentReceived);
                if (!(Result.Contains("Error")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("index", "PaymentReceivable", new { Area = "" });
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
            model.BankDD = dalConfig.GetBankDD();
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            return View(model);
        }
        public ActionResult Edit(long id)
        {
            ViewBag.ActiveURL = "/PaymentReceivable/Index";
            PaymentReceivedAdd model = new PaymentReceivedAdd();
            model.PaymentReceived = dalpayment.GetReceiveDirectPaymentByID(id);
            model.BankDD = dalConfig.GetBankDD();
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(PaymentReceivedAdd model)
        {
            ViewBag.ActiveURL = "/PaymentReceivable/Index";
            string uploadStatus = "Failure";
            string PrevFile = model.PaymentReceived.UploadedFile;
            if (model.PaymentReceived.ReceivedMode != "Cash")
            {
                if (!model.PaymentReceived.BankID.HasValue)
                    ModelState.AddModelError("PaymentReceived.BankID", "Select Bank");
                if (string.IsNullOrEmpty(model.PaymentReceived.TransactionNo))
                    ModelState.AddModelError("PaymentReceived.TransactionNo", "Enter Cheque/Transaction No.");
            }
            if (model.UploadFile != null)
            {
                uploadStatus = CheckAndUpload(model.UploadFile, "Payments");
                if (!uploadStatus.Contains("Failure"))
                    model.PaymentReceived.UploadedFile = uploadStatus;
                else
                    ModelState.AddModelError("UploadFile", uploadStatus);
            }
            if (model.PaymentReceived.ReceivedMode != "Cash" && model.UploadFile == null)
            {

            }
            if (ModelState.IsValid)
            {
                model.PaymentReceived.AddedBy = User.Identity.Name;
                string Result = dalpayment.SavePaymentReceivable(model.PaymentReceived);
                if (!(Result.Contains("Error")))
                {
                    TempData["ErrMsg"] = Result;
                    if (model.PaymentReceived.ReceivedMode == "Cash" && !string.IsNullOrEmpty(PrevFile))
                    {
                        var fullPath = string.Concat(Server.MapPath(PrevFile));
                        if (System.IO.File.Exists(fullPath))
                        {
                            System.IO.File.Delete(fullPath);
                        }
                    }
                    return RedirectToAction("index", "PaymentReceivable", new { Area = "" });
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
            model.BankDD = dalConfig.GetBankDD();
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(long id)
        {
            utblPaymentReceivable model = dalpayment.GetReceiveDirectPaymentByID(id);
            string PrevFile = model.UploadedFile;
            string Result = dalpayment.Delete(id);
            if (!string.IsNullOrEmpty(PrevFile))
            {
                var fullPath = string.Concat(Server.MapPath(PrevFile));
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                }
            }
            TempData["ErrMsg"] = Result;
            return RedirectToAction("index", "PaymentReceivable", new { Area = "" });
        }
        #endregion

        #region Project's Payment Receive
        public ActionResult ProjPaymentReceiveList(int PageNo = 1, int PageSize = 10, int YearNo = 0, int MonNo = 0, long Project = 0)
        {
            ViewBag.ActiveURL = "/PaymentReceivable/ProjPaymentReceiveList";
            ProjPaymentReceivedVM model = new ProjPaymentReceivedVM();
            ViewBag.YearNo = YearNo;
            ViewBag.MonNo = MonNo;
            ViewBag.Project = Project;
            model = dalpayment.GetProjPaymentReceived(PageNo, PageSize, YearNo, MonNo, Project);
            model.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = model.TotalRecords };
            model.ProjectDD = dalConfig.GetProjectDDList();
            model.ProjPaymentReceiveYearDD = dalpayment.GetProjPaymentReceiveYearDD();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvProjPaymentReceiveList", model);
            }
            return View(model);
        }

        public ActionResult ProjPaymentReceive(long id = 0)
        {
            ViewBag.ActiveURL = "/PaymentReceivable/ProjPaymentReceiveList";
            ProjPaymentReceivedAdd model = new ProjPaymentReceivedAdd();
            ViewBag.ID = id;
            model.ProjectDD = dalConfig.GetProjectDDList();
            model.BankDD = dalConfig.GetBankDD();
            if (id != 0)
            {
                model.ProjPaymentReceived = dalpayment.GetProjPaymentReceiveByID(id);
                ViewBag.SalInv = model.ProjPaymentReceived.SaleInvoiceID;
            }
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ProjPaymentReceive(ProjPaymentReceivedAdd model)
        {
            ViewBag.ActiveURL = "/PaymentReceivable/ProjPaymentReceiveList";
            string uploadStatus = "Failure";
            if (model.ProjPaymentReceived.NetAmtReceived == 0)
            {
                ModelState.AddModelError("ProjPaymentReceived.AmountReceived", "Net Amount is greater than 0");
            }
            if (model.ProjPaymentReceived.ReceivedMode != "Cash" && model.ProjPaymentReceived.BankID == null)
            {
                ModelState.AddModelError("ProjPaymentReceived.BankID", "Please Select Bank Name");
            }
            if (model.UploadFile != null)
            {
                //uploadStatus = CheckAndUpload(model.UploadFile, model.ProjPaymentReceived.ReceivedDate.ToString("dd/MM/yyyy") + "_Proj_Payment_Received_" + model.ProjPaymentReceived.ProjectID.ToString("0") + "_");
                uploadStatus = CheckAndUpload(model.UploadFile, "PaymentReceived");
                if (!uploadStatus.Contains("Failure"))
                    model.ProjPaymentReceived.UploadedFile = uploadStatus;
                else
                    ModelState.AddModelError("UploadFile", uploadStatus);
            }
            if (model.ProjPaymentReceived.IsAdvance && string.IsNullOrEmpty(model.ProjPaymentReceived.SaleInvoiceID))
            {
                ModelState.AddModelError("ProjPaymentReceived.SaleInvoiceID", "Select Sale Invoice Ref No.");
            }
            if (ModelState.IsValid)
            {
                string Result = dalpayment.SaveProjPaymentReceive(model.ProjPaymentReceived);
                if ((Result.Contains("Success")))
                {
                    TempData["ErrMsg"] = Result;
                    return RedirectToAction("ProjPaymentReceiveList", "PaymentReceivable", new { Area = "" });
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
            ViewBag.ID = model.ProjPaymentReceived.ProjPaymentReceiveID;
            model.ProjectDD = dalConfig.GetProjectDDList();
            model.BankDD = dalConfig.GetBankDD();
            ViewBag.SalInv = model.ProjPaymentReceived.SaleInvoiceID;
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteProjPaymentReceive(long id)
        {
            utblProjPaymentReceivable model = dalpayment.GetProjPaymentReceiveByID(id);
            string PrevFile = model.UploadedFile;
            string Result = dalpayment.DeleteProjPaymentReceive(id);
            if (!string.IsNullOrEmpty(PrevFile))
            {
                var fullPath = string.Concat(Server.MapPath(PrevFile));
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                }
            }
            TempData["ErrMsg"] = Result;
            return RedirectToAction("ProjPaymentReceiveList", "PaymentReceivable", new { Area = "" });
        }
        #endregion
        public JsonResult GetSalInvListByProj(long ProjID)
        {
            List<SalInvDD> model = new List<SalInvDD>();
            model = dalConfig.GetSalInvListByProj(ProjID);//Get Inv List by Proj ID
            return Json(new SelectList(model, "SaleInvoiceID", "InvRefNo"), JsonRequestBehavior.AllowGet);
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
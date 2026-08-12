using SDKHRMS.Entities.DataAccess;
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
    public class PettyCashController : Controller
    {
        dalConfiguration dalConfig = new dalConfiguration();
        dalPettyCash dalPettyCash = new dalPettyCash();
        // GET: PettyCash
        public ActionResult PettyCashBook(int? MonthNo, int? YearNo)
        {
            ViewBag.ActiveURL = "/PettyCash/PettyCashBook";
            int Mon = MonthNo ?? DateTime.Now.Month;
            int Yr = YearNo ?? DateTime.Now.Year;
            ViewBag.YearNo = Yr;
            ViewBag.MonthNo = Mon;
            PettyCashVM model = new PettyCashVM();
            System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();
            model.MonthName = mfi.GetMonthName(Mon).ToString();
            model.YearDD = dalPettyCash.GetPettyCashYearDD();//Get Year DD List
            model.TotalTrans = dalPettyCash.GetPettyCashTotalTrans(Mon, Yr);
            model.AvailableBalance = dalPettyCash.PettyCashBalance();
            model.PrettyCashBook = dalPettyCash.GetPettyCashBook(Mon, Yr);
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvPettyCashBook", model);
            }
            return View(model);
        }
        public ActionResult AddPettyCash(long id = 0)
        {
            ViewBag.ActiveURL = "/PettyCash/PettyCashBook";
            PettyCashAdd model = new PettyCashAdd();
            if (id != 0)
            {
                model.PettyCash = dalPettyCash.GetPettyCashByID(id);
                if (!string.IsNullOrEmpty(model.PettyCash.FilePath))
                    model.PrevUploadedFile = model.PettyCash.FilePath;
            }
            model.AvailableBalance = dalPettyCash.PettyCashBalance();
            //model.TotalTrans = dalPettyCash.GetPettyCashTotalTrans(0,0);
            model.BankDD = dalConfig.GetBankDD();
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            ExpenseTypeDD exp = model.ExpenseTypeDD.Where(x => x.ExpenseType == "Bank").FirstOrDefault();
            model.BankExpID = exp.ExpenseTypeID;

            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddPettyCash(PettyCashAdd model)
        {
            ViewBag.ActiveURL = "/PettyCash/PettyCashBook";
            model.PettyCash.ExpenseTypeID = model.BankExpID;
            string uploadStatus = "Failure";
            if (model.UploadFile != null)
            {
                uploadStatus = CheckAndUpload(model.UploadFile, "Payments");
                if (!uploadStatus.Contains("Failure"))
                    model.PettyCash.FilePath = uploadStatus;
                else
                    ModelState.AddModelError("UploadFile", uploadStatus);
            }
            else
            {
                model.PettyCash.FilePath = model.PrevUploadedFile;
            }
            if (model.PettyCash.BankID == null || model.PettyCash.BankID == 0)
                ModelState.AddModelError("PettyCash.BankID", "Select Bank Name");
            if (ModelState.IsValid)
            {
                string Result = dalPettyCash.SavePettyCash(model.PettyCash);
                TempData["ErrMsg"] = Result;
                if ((Result.Contains("Success")))
                {

                    if (!(uploadStatus.Contains("Failure")))
                    {
                        if (!string.IsNullOrEmpty(model.PrevUploadedFile))
                        {
                            var prevFilePath = string.Concat(Server.MapPath("~/UploadFile/Payments/" + model.PrevUploadedFile));
                            if (System.IO.File.Exists(prevFilePath))
                            {
                                System.IO.File.Delete(prevFilePath);
                            }
                        }
                        var fullPath = string.Concat(Server.MapPath(uploadStatus));
                        if (System.IO.File.Exists(fullPath))
                        {
                            System.IO.File.Delete(fullPath);
                        }
                    }
                    return RedirectToAction("PettyCashBook");
                }
            }
            model.AvailableBalance = dalPettyCash.PettyCashBalance();
            model.BankDD = dalConfig.GetBankDD();
            model.ExpenseTypeDD = dalConfig.GetExpenseTypeDD();
            return View(model);
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
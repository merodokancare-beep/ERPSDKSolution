using Newtonsoft.Json;
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
    public class ReferenceNumberController : Controller
    {
        ReferenceNumberViewModel objmodel = new ReferenceNumberViewModel();
        dalConfiguration dalconf = new dalConfiguration();
        dalRefNumber dalrefno = new dalRefNumber();
        // GET: /ReferenceNumber/
        [HttpGet]
        public ActionResult ReferenceNumberList(int PageNo = 1, int PageSize = 20, string SearchTerm = "", string FYR = "", string RefType = "")
        {
            ViewBag.ActiveURL = "/ReferenceNumber/ReferenceNumberList";
            if (string.IsNullOrEmpty(FYR))
            {
                if (DateTime.Now.Month >= 4 && DateTime.Now.Month >= 3)
                {
                    FYR = (DateTime.Now.Year.ToString() + "-" + (DateTime.Now.Year + 1).ToString().Substring(2));
                }
                else
                {
                    FYR = ((DateTime.Now.Year - 1).ToString() + "-" + DateTime.Now.Year.ToString().Substring(2));
                }
            }
            ViewBag.FiscalYear = FYR;
            ViewBag.Type = RefType;
            objmodel = dalrefno.GetRefNumberList(PageNo, PageSize, SearchTerm, FYR, RefType);
            objmodel.PagingInfo = new PagingInfo { CurrentPage = PageNo, ItemsPerPage = PageSize, TotalItems = objmodel.TotalRecords };
            ViewBag.SearchTerm = SearchTerm;
            objmodel.FiscalYearDDList = dalrefno.FiscalYearList();
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvReferenceNoList", objmodel);
            }
            return View(objmodel);
        }
        [HttpGet]
        public ActionResult AddReferenceNumber(long ID = 0)
        {
            ViewBag.ID = ID;
            ViewBag.ActiveURL = "/ReferenceNumber/ReferenceNumberList";
            objmodel.VendorDDList = dalconf.GetVendorDDList();
            if (ID != 0)
            {
                objmodel.ReferenceDetails = dalrefno.GetReferenceDetailByID(ID);
            }
            return View(objmodel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddReferenceNumber(ReferenceNumberViewModel ItemData)
        {
            ViewBag.ActiveURL = "/ReferenceNumber/ReferenceNumberList";
            objmodel.VendorDDList = dalconf.GetVendorDDList();
            if (ModelState.IsValid)
            {
                ItemData.ReferenceDetails.UserID = User.Identity.Name;
                TempData["ErrMsg"] = dalrefno.SaveRefNumber(ItemData.ReferenceDetails);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("ReferenceNumberList");
                }
            }
            return View(objmodel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CancelledRefNo(long ID, int PageNo, int PageSize, int ListCount, string SearchTerm = "")
        {
            TempData["ErrMsg"] = dalrefno.CancelledRefNo(ID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                ListCount--;
            }
            if (ListCount == 0)
            {
                PageNo = (PageNo - 1) <= 0 ? 1 : (PageNo - 1);
            }

            return RedirectToAction("ReferenceNumberList", new { PageNo = PageNo, PageSize = PageSize, SearchTerm = SearchTerm });
        }

        #region Offical Corresponding Letter
        public ActionResult OfficalDocsListByID(long ID)
        {
            objmodel.OfficalLetterDocList = dalrefno.GetDocsListByID(ID);
            if (Request.IsAjaxRequest())
            {
                return PartialView("_pvOfficalDocsList", objmodel);
            }
            return View(objmodel);
        }

        public ActionResult UploadOfficalDocs(long ID)
        {
            OfficalLetterVM objmodel = new OfficalLetterVM();
            objmodel.ReferenceDetails = dalrefno.GetReferenceDetailByID(ID);
            objmodel.RefNoID = ID;
            return View(objmodel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UploadOfficalDocs(OfficalLetterVM model)
        {
            ViewBag.ActiveURL = "/ReferenceNumber/ReferenceNumberList";
            string filestate = "Failure";
            if (model.UploadFile != null)
            {
                filestate = CheckAndUpload(model.UploadFile, "OfficalLetterDocs");
                if (!filestate.Contains("Failure"))
                {
                    model.OfficalLetterAdd.DocPath = filestate;
                }
                else
                {
                    ModelState.AddModelError("UploadFile", filestate);
                }
            }
            else
            {
                ModelState.AddModelError("UploadFile", "File was not Uploaded");
            }
            if (ModelState.IsValid)
            {
                model.OfficalLetterAdd.ReferenceID = model.RefNoID;
                TempData["ErrMsg"] = dalrefno.SaveDocuments(model.OfficalLetterAdd);
                if (!(TempData["ErrMsg"].ToString().Contains("Error")))
                {
                    return RedirectToAction("ReferenceNumberList");
                }
                else
                {
                    ModelState.AddModelError("UploadFile", "Could not upload Offical Letter Docs!");
                }
            }
            model.ReferenceDetails = dalrefno.GetReferenceDetailByID(model.RefNoID);
            return PartialView(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteOfficalDoc(long DocID, long RefID, string FileName)
        {
            TempData["ErrMsg"] = dalrefno.DeleteOfficalDoc(DocID);
            if ((TempData["ErrMsg"].ToString()).Contains("Success"))
            {
                if (!string.IsNullOrEmpty(FileName))
                {
                    var fullPath = string.Concat(Server.MapPath("~/UploadFile/OfficalLetterDocs/" + FileName));
                    if (System.IO.File.Exists(fullPath))
                    {
                        System.IO.File.Delete(fullPath);
                    }
                }
            }
            return RedirectToAction("OfficalDocsListByID", "ReferenceNumber", new { ID = RefID });
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
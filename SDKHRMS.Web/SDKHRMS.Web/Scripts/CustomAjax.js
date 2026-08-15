$(function () {
    //**************** JS to show loading progress during ajax call *********************//
    $(document).ajaxStart(function () {
        $("#ajaxLoading").css("display", "block");
        $("#ajaxLoading").css("top", $(window).height() / 1.8);
        $("#ajaxLoading").css("left", $(window).width() / 2);
        $("#ajaxLoading").css("position", "fixed");
    });
    $(document).ajaxComplete(function () {
        $("#ajaxLoading").css("display", "none");
    });
    //************************************************************************************//

    //*************************  Highlight Active Menu  ***********************************//
    jQuery(function () {
        var url = window.location.pathname,
            urlRegExp = new RegExp(url.replace(/\/$/, '') + "$");
        var IsActivated = false;

        $("#sidebar ul li").each(function () {
            $(this).removeClass("active");
            try {
                if ($(this).children().attr("href").toLowerCase() == url.toLowerCase()) {
                    $(this).addClass("active");
                    $(this).children().addClass("active");
                    $(this).closest('.nav-second-level').addClass("in");
                    $(this).closest('.submenu').addClass("active");
                    IsActivated = true;
                    return false;
                }
            } catch (e) {

            }
        })
        if (IsActivated == false) {
            $("#sidebar ul li").each(function () {
                $(this).removeClass("active");
                try {

                    if ($(this).children().attr("href").toLowerCase() == $("#ActiveURL").data("value").toLowerCase()) {
                        $(this).addClass("active");
                        $(this).children().addClass("active");
                        $(this).closest('.submenu').addClass("active");
                        $(this).closest('.nav-second-level').addClass("in");
                        IsActivated = true;
                        return false;
                    }
                } catch (e) {

                }

            })
        }
    });
    //************************************************************************************//

    //******************** Show message box when operation is complete *******************//
    ShowMessageBox();
    //************************************************************************************//

    //******************************** JS for Grid paging*********************************//
    var getPage = function () {
        var $a = $(this);

        if ($a.attr("href").trim() == undefined || $a.attr("href").trim() == "") {
            return;
        }
        var $form = $('form[data-search="true"]');
        var options = {
            url: $a.attr("href")
            , data: $form.serialize()
            , type: "get"
        }

        $.ajax(options).done(function (data) {
            var $target = $($a.parents("div.ns-grid-pager").attr("data-otf-target"));
            $target.replaceWith(data);
        }).fail(function (xhr, msg, err) {
            toastr.error(msg, "Error");
        });
        return false;
    };
    $(".app-content").on("click", "a.ns-page-link", getPage);

    var getPageForDDL = function () {
        var TargetURL = $(this).parent().attr("data-otf-actionlink");
        TargetURL = TargetURL + "?PageSize=" + $('.page-size').val() + "&PageNo=" + $(this).val()
        var $form = $('form[data-search="true"]');
        var options = {
            url: TargetURL
            , data: $form.serialize()
            , type: "get"
        }
        var target = $(this).parent().attr("data-otf-target");
        $.ajax(options).done(function (data) {
            $(target).replaceWith(data);
        }).fail(function (xhr, msg, err) {
            toastr.error(msg, "Error");
        });
    };
    $(".app-content").on("change", ".page-number", getPageForDDL);

    var getPageSizeForDDL = function () {
        var TargetURL = $(this).parent().attr("data-otf-actionlink");
        TargetURL = TargetURL + "?PageSize=" + $(this).val()
        var $form = $('form[data-search="true"]');
        var options = {
            url: TargetURL
            , data: $form.serialize()
            , type: "get"
        }
        var target = $(this).parent().attr("data-otf-target");
        $.ajax(options).done(function (data) {
            $(target).replaceWith(data);
        }).fail(function (xhr, msg, err) {
            toastr.error(msg, "Error");
        });
    };
    $(".app-content").on("change", ".page-size", getPageSizeForDDL);

    //************************************************************************************//


    $(".app-content").on("click", ".delete", ShowWarningMessageBox);
    $(".app-content").on("click", ".disable", ShowDisableMessageBox);
    $(".app-content").on("click", ".RefCancel", ShowRefCancelMessageBox);
    $(".app-content").on("click", ".approval", ShowApprovalMessageBox);
    $(".app-content").on("click", ".declined", ShowDeclinedMessageBox);
    var ajaxFormSubmit = function () {
        var $form = $(this);
        var options = {
            url: $form.attr("action")
            , type: $form.attr("method")
            , data: $form.serialize()
        }

        var target = $($form.attr("data-otf-target"));
        $.ajax(options).done(function (data) {
            $(target).replaceWith(data);
        }).fail(function (xhr, msg, err) {
            toastr.error(msg, "Error");
        });
        return false;
    };
    $("form[data-otf-ajax='true']").submit(ajaxFormSubmit);
});


// Function to call custom Ajax form submit
function CustomAjaxFormSubmit(sender, url) {
    if (url == "#") { return false; }

    var $form = $('a[href="' + decodeURI(url) + '"]').closest('form')
    //alert(url)
    if ($form.attr("data-otf-ajax") == 'true') {

        var options = {
            url: decodeURI(url)
            , type: $form.attr("method")
            , data: $form.serialize()
        }
        var target = $($form.attr("data-otf-target"));
        $.ajax(options).done(function (data) {
            $(target).replaceWith(data);
            ShowMessageBox();
        }).fail(function (xhr, msg, err) {
            toastr.error(msg, "Error");
        });
        return false;
    }
    else {
        return true;
    }
};


// ************************* This is to show success/error message ********************************//
function ShowMessageBox() {
    var Msg = $('#ErrMsgHiddenField').val();
    if (Msg.length > 1) {
        if (Msg != null && Msg.toString().trim() != "") {
            if (Msg.toString().toLowerCase().indexOf('error') != -1) {
                toastr.options = {
                    "closeButton": true,
                    "newestOnTop": false,
                    "positionClass": "toast-top-center",
                    "preventDuplicates": true,
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut",
                    "showDuration": 0,
                    "hideDuration": 0,
                    "timeOut": 0,
                    "extendedTimeOut": 0
                }
                toastr.error(Msg, "Operation Failed !!!");
            }
            else if (Msg.toString().toLowerCase().indexOf('success') != -1) {
                toastr.options = {
                    "closeButton": true,
                    "newestOnTop": false,
                    "positionClass": "toast-top-center",
                    "preventDuplicates": false,
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                }
                toastr.success(Msg, 'Success !!!');
            } else {
                toastr.options = {
                    "closeButton": true,
                    "newestOnTop": false,
                    "positionClass": "toast-top-center",
                    "preventDuplicates": false,
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                }
                toastr.info(Msg, 'Information !!!');
            }
        }
    }
}

//// This is to show warning message before delete operation
var ShowWarningMessageBox = function (e) {

    if ($(this).text() != "Cancel") {
        var record = $(this).attr('data-record');
        // Set the sender infromation in hidden field and its closest form
        $("#eventSender").val(($(this).attr('href')) + '|' + $($(this).closest('form')));

        $('#myErroModalLabel').text('Confirmation');
        //$('#myErroMsgModalNoButton').val("Cancel");
        $('#Msg').html('Are you sure you want to delete this record : <b>' + record + '</b> ?');

        $('#myErroMsgModalYesButton').removeClass('hidden');
        $('#myErroMsgModal').show();
        e.preventDefault();
    }
}

//// This is to show  message before disabling user
var ShowDisableMessageBox = function (e) {
    if ($(this).text() != "Cancel") {
        var record = $(this).attr('data-record');
        // Set the sender infromation in hidden field and its closest form
        $("#eventSender").val(($(this).attr('href')) + '|' + $($(this).closest('form')));

        $('#myErroModalLabel').text('Confirmation');
        //$('#myErroMsgModalNoButton').val("Cancel");
        $('#Msg').html('Are you sure you want to enable/disable this record : <b>' + record + '</b> ?');

        $('#myErroMsgModalYesButton').removeClass('hidden');
        $('#myErroMsgModal').show();
        e.preventDefault();
    }
}
//// This is to show  message before Cancel or Actice Refrence No.
var ShowRefCancelMessageBox = function (e) {
    if ($(this).text() != "Cancel") {
        var record = $(this).attr('data-record');
        // Set the sender infromation in hidden field and its closest form
        $("#eventSender").val(($(this).attr('href')) + '|' + $($(this).closest('form')));

        $('#myErroModalLabel').text('Confirmation');
        //$('#myErroMsgModalNoButton').val("Cancel");
        $('#Msg').html('Are you sure you want to Cancel/Active this record : <b>' + record + '</b> ?');

        $('#myErroMsgModalYesButton').removeClass('hidden');
        $('#myErroMsgModal').show();
        e.preventDefault();
    }
}
//// This is to show  message before Approval.
var ShowApprovalMessageBox = function (e) {
    if ($(this).text() != "Cancel") {
        var record = $(this).attr('data-record');
        // Set the sender infromation in hidden field and its closest form
        $("#eventSender").val(($(this).attr('href')) + '|' + $($(this).closest('form')));

        $('#myErroModalLabel').text('Confirmation');
        //$('#myErroMsgModalNoButton').val("Cancel");
        $('#Msg').html('Are you sure you want to authorize the accountant to release the payment for the selected record :' + record + '</b> ?');

        $('#myErroMsgModalYesButton').removeClass('hidden');
        $('#myErroMsgModal').show();
        e.preventDefault();
    }
}
//// This is to show  message before Declined .
var ShowDeclinedMessageBox = function (e) {
    if ($(this).text() != "Cancel") {
        var record = $(this).attr('data-record');
        // Set the sender infromation in hidden field and its closest form
        $("#eventSender").val(($(this).attr('href')) + '|' + $($(this).closest('form')));

        $('#myErroModalLabel').text('Confirmation');
        //$('#myErroMsgModalNoButton').val("Cancel");
        $('#Msg').html('Are you sure you want to prevent the accountant from releasing the payment for the selected record : <b>' + record + '</b> ?');

        $('#myErroMsgModalYesButton').removeClass('hidden');
        $('#myErroMsgModal').show();
        e.preventDefault();
    }
}
// Close message box
function CloseMyModal() {
    $('#myErroMsgModalYesButton').addClass('hidden');
    $("#myErroMsgModal").hide();
}
// close message box and procceed for intended action.
function OkMyModal() {
    $("#myErroMsgModal").hide();
    // Retrieve the sender infromation from hidden field and pass it to the function
    CustomAjaxFormSubmit($("#eventSender").val().split('|')[1], $("#eventSender").val().split('|')[0]);
}

//Notification Alert for layout
var AlertNotification = function () {
    var loaderImg = typeof resolveUrl === 'function' ? resolveUrl('/Content/Images/loading.gif') : '/Content/Images/loading.gif';
    var targetUrl = typeof resolveUrl === 'function' ? resolveUrl('/Home/GetNotificationAlert') : '/Home/GetNotificationAlert';
    $('#Notification').empty().append('<div class="panel-body text-center margin-top-15"><img src="' + loaderImg + '" /><h2>Please wait....</h2></div>');
    $.ajax({
        type: 'GET',
        url: targetUrl,
        success: function (data) {
            $('#Notification').empty().append(data);
        },
        error: function () {
            $('#Notification').empty().append('<div class="panel-body margin-top-15"><b>Could not load data. Click on Reload...</b><button id="btnAlert">Reload</button></div>');
            //$('#gstinv').empty().append('<div class="margin-top-15"><b>Could not load data. Please click here to reload...</b><button id="btngstinv">Reload</button></div>');
        }
    });
}
$(document).on('click', "#btnAlert", AlertNotification);
AlertNotification();


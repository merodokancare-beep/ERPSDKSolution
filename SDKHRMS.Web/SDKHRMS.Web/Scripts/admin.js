$(function() {

    $('#side-menu').metisMenu();

});

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function() {
    $(window).bind("load resize", function() {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-scroll').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-scroll').removeClass('collapse');
        }

        //height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        //height = height - topOffset;
        //if (height < 1) height = 1;
        //if (height > topOffset) {
        //    $(".app-container").css("min-height", (height) + "px");
        //}
    });

    var url = window.location;
    var element = $('ul.nav a').filter(function() {
        return this.href == url || url.href.indexOf(this.href) == 0;
    }).addClass('active').parent().parent().addClass('in').parent();
    if (element.is('li')) {
        element.addClass('active');
    }

    $("#mobile-menu-btn").on("click", function () {
        if ($('#mobile-menu-icon').hasClass('glyphicon-menu-hamburger'))
        {
            $('#mobile-menu-icon').removeClass("glyphicon-menu-hamburger").addClass("glyphicon-remove");
        }
        else
        {
            $('#mobile-menu-icon').removeClass("glyphicon-remove").addClass("glyphicon-menu-hamburger");
        }
        $('#mobile-menu-icon').addClass('bounceIn animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
            $(this).removeClass('bounceIn').removeClass('animated');
        });
    });

    $("#search-btn").click(function () {
        if ($("input[name='searchTerm']").val().toString().trim() != "")
        {
            $("#clearSearchBtn").removeClass("hidden");
            $(this).parent("form").submit();
        }
    });

    $(".ddl-select2").select2({
        width: '100%'
    });
    $("select").on("change", function () {
        var dropdownname = $(this).attr("name");
        if($(this).val()!="")
        {
            if($(this).hasClass("input-validation-error"))
            {
                $(this).removeClass("input-validation-error").addClass("valid");
                $('span[data-valmsg-for="' + dropdownname + '"]').removeClass('field-validation-error').addClass('field-validation-valid');
                $('span[data-valmsg-for="' + dropdownname + '"]').empty();
            }
            else {
                $(this).addClass("valid");
            }
        }
        else {
            $(this).removeClass("valid");
        }

    })
});


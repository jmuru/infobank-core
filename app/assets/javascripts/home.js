// accordion for file display
$('.ui.accordion').accordion();
// accordion for file display end

// actions sidebar
$(".sidebar-nav").sidebar().sidebar('attach events', '.menu-toggle');
// actions sidebar end
$(".editBtn").data('status', 'not_clicked');

var flag = 0;
$(".editBtn").click(function() {
    if (flag == 0) {
        $(".editBox").css({
            right: "0"
        });
        $(this).css({
            right: "24.7%"
        });
        $(this).text(">");
        flag++;
    } else {
        $(".editBox").css({
            right: "-25%"
        });
        $(this).css({
            right: "-1%"
        });
        $(this).text("<");
        flag = 0;
    }
})
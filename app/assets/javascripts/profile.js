$(document).ready(function () {
    bindProfileDetails();
});

function bindProfileDetails(){
    $(".personal-info").on("click", function(event){
        event.preventDefault();
        $(".personal-info").parent().addClass("active");
        $(".tracking-code, .snapshots").parent().removeClass("active");
        $('.profile').show();
        $('.tracking-details, .snapshot-detail').hide();
    });

    $(".tracking-code").on('click', function(event){
        event.preventDefault();
        $(".personal-info, .snapshots").parent().removeClass("active");
        $(".tracking-code").parent().addClass("active");
        $('.profile, .snapshot-detail').hide();
        $('.tracking-details').show();
    });
    $(".snapshots").on('click', function(event){
        event.preventDefault();
        $(".personal-info, .tracking-code").parent().removeClass("active");
        var $snapshots = $(".snapshot-detail");
        $(".snapshots").parent().addClass("active");
        $('.profile, .tracking-details').hide();
        $snapshots.show();
    });
}
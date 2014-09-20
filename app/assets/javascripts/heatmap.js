function getImageSource(url) {
    $.getJSON(url, function (data) {
        $("#snapshotImage").attr("src", "http://localhost:9004/" + data.source);
    });
}
$(document).ready(function () {
    $("#snapshots").change(function (event) {
        var selectedResolution = $("#resolutions").find(":selected").text();
        if (selectedResolution === "Select Resolution") {
            selectedResolution = "1440";
        }
        var url = "/heatmap/imagesource?key=" + encodeURIComponent("stayzilla_" + this.value + "_" + selectedResolution);
        getImageSource(url);
    });
    $("#resolutions").change(function (event) {
        var selectedSnapshot = $("#snapshots").find(":selected").val();
        var url = "/heatmap/imagesource?key=" + encodeURIComponent("stayzilla_" + selectedSnapshot + "_" + this.value);
        getImageSource(url);
    });

});
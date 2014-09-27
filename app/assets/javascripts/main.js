function setImage(url) {
    $.getJSON(url, function (data) {
        $("#snapshotImage").attr("src", "http://localhost:9004/" + data.source);
        $("#snapshotImage").on("load", function(){
            $(".heatmap-container").css("height", $("#sourceWebsite").height());
            getHeatMapPoints();
        });
    });
}
function getSelectedResolution() {
    var selectedResolution = $("#resolutions").find(":selected").text();
    if (selectedResolution === "Select Resolution") {
        selectedResolution = "1440";
    }
    return selectedResolution;
}
$(document).ready(function () {
    $("#snapshots").change(function (event) {
        var selectedResolution = getSelectedResolution();
        var url = "/heatmap/imagesource?key=" + encodeURIComponent("stayzilla_" + this.value + "_" + selectedResolution);
        setImage(url);
    });
    $("#resolutions").change(function (event) {
        var selectedSnapshot = $("#snapshots").find(":selected").val();
        var url = "/heatmap/imagesource?key=" + encodeURIComponent("stayzilla_" + selectedSnapshot + "_" + this.value);
        setImage(url);
    });

});

function getHeatMapPoints() {
    var selectedSnapshot = $("#snapshots").find(":selected").val();
    var selectedResolution = getSelectedResolution();
    var url = "/heatmap/points?user_action=click&location_url=" + encodeURIComponent(selectedSnapshot)+"&resolution="+selectedResolution;
    var points = "";
    $.getJSON(url, function (data) {
        points = data.points;
        generateHeatMap(points);
    });
}
function generateHeatMap(allPoints) {
    var heatMapPoints = [];
    var pointArray = allPoints.split(",");
    var offset = $("#resolutions").offset();
    $(".heatmap-canvas").remove()
    $.each(pointArray, function (index, element) {
        if (index != 0 && index % 2 == 0) {
            var point = {x: pointArray[index - 2] * 1 - offset.left, y: pointArray[index - 1] * 1 - offset.top, value: 1};
            heatMapPoints.push(point);
        }
    });
    var heatmap = h337.create({
        container: document.getElementById('heatmapContainer'),
        maxOpacity: 0.9,
        radius: 30
    });
    heatmap.addData(heatMapPoints);
}
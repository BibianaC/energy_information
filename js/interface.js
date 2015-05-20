var jsonURL = "https://rawgit.com/BibianaC/json_file/00b2814f44095f50f0054b7a906e6a5535057f17/report.json";
$(function() {
  var dateMenu = document.getElementById("selectDate");
  $.getJSON(jsonURL, function(nestedHash) {
    $.each(nestedHash, function(sp_date, sp_hash) {
      var option = document.createElement("option");
      option.textContent = sp_date;
      //option.textValue = sp_date;
      dateMenu.appendChild(option);
    });
  });
});

function updateSPMenu() {
  var selectedDate = $('#selectDate :selected').text();
  var times = new Array();
  $.getJSON(jsonURL, function(nestedHash) {
    var SPHash = nestedHash[selectedDate];
    $.each(SPHash, function(sp_time, foo) {
      times.push(sp_time);
    });
    times.sort();
    var SPMenu = document.getElementById("selectSP");
    for (var i=0; i<times.length; i++) {
      var sp = times[i];
      var option = document.createElement("option");
      option.textContent = sp; //SPHash[sp]['recorded date'];
      option.textValue = SPHash[sp]['recorded date'];
      SPMenu.appendChild(option);
    }
  });
}

function report() {
  var selectedDate = $('#selectDate :selected').text();
  var selectedSP = $('#selectSP :selected').val();
  var reportPara = document.getElementById("report");
  $.getJSON(jsonURL, function(nestedHash) {
    var fuelTypeHash = nestedHash[selectedDate][selectedSP];
    $.each(fuelTypeHash, function(fuelType, fuelHash) {
      var li = document.createElement('li');
      li.textContent = fuelType + ": " + fuelHash;
      reportPara.appendChild(li);
    });
  });
}
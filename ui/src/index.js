function getData(callback) {
//  let url = "http://0.0.0.0:8000/hello";
   let url = "https://api-test-v1.yarjul.com:8000/hello";
  let xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function () {
    if (xhr.readyState == 4 && xhr.status == 200) callback(xhr.responseText);
  };
  xhr.open("GET", url, true);
  xhr.withCredentials = true;
  xhr.send(null);
  return xhr.responseText;
}

function setMessage(data) {
  let json_data = JSON.parse(data);
  document.getElementById("wrapper").innerHTML = json_data.message;
}

function button() {
  getData(setMessage);
}

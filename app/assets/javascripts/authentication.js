$(document).ready(function () {
   $("#newEmail").on("blur",function(data){
       $.getJSON("/users/get?email="+$("#newEmail").val(), function (data) {
           if(data.valid){
               $("#newEmail").parent().addClass("error");
               $("#newEmail").next().text("Email id already registered");
           }
       });

   });
});
$(document).ready(function () {
   $("#email").on("blur",function(data){
       $.getJSON("/users/get?email="+$("#email").val(), function (data) {
           if(data.valid){
               $("#email").parent().addClass("error");
               $("#email").next().text("Email id already registered");
           }
       });

   });
});
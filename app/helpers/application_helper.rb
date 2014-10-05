module ApplicationHelper
  def markdown(text)
    CodeRay.scan(text, :javascript).div
  end

  def common_tracker(apiToken)
    text = ' <script type="text/javascript">(function(){function r(e,t){var n=new XMLHttpRequest;n.open("POST",t,true);n.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");n.send("points="+e+"&docUrl="+document.URL+"&apiToken='+apiToken+'"+"&width="+document.body.clientWidth+"&height="+window.innerHeight)}function i(e,t,n,i){var s=Rx.Observable.fromEvent(document,e).throttle(i);s.subscribe(function(e){n.push(e.pageX,e.pageY);if(n.length>5){var i=window.location.pathname.indexOf("/")>=0?"/"+window.location.pathname.split("/")[1]:window.location.pathname;i=i==="/"?"/"+location.hash.replace("#",""):i;i=i.indexOf("?")>0?i.split("?")[0]:i;r(n.join(),t+i);n=[]}})}function s(){i("click","http://localhost:3000/click/points",t,100);i("mousemove","http://localhost:3000/mouseMove/points",n,500)}function o(){html2canvas(document.body,{onrendered:function(e){console.log(e.toDataURL("image/png"));document.body.appendChild(e)}})}function u(e,t){var n=document.createElement("script");n.type="text/javascript";n.src=e;var r=document.getElementsByTagName("script");if(r){var i=r[document.getElementsByTagName("script").length-1];i.parentNode.insertBefore(n,i)}else{document.body.appendChild(n)}if(t){n.onreadystatechange=t;n.onload=t}}var t=[];var n=[];u("//cdnjs.cloudflare.com/ajax/libs/rxjs/2.3.0/rx.lite.min.js",s)})();</script> '
    text
  end
end

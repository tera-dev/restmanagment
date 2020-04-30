//menu behaviour -------------------
(function (){ 
    var subIndex = getCookieByName('subIndex');
    var subInnerIndex = getCookieByName('subInnerIndex');
    $(".sub").click(function(){
            
            var $this = $(this);
            $this.find("div.sub-container a").eq(subInnerIndex).addClass("activeLink");
//            alert($(this).index('.sub'));
            document.cookie = "subIndex=" + $(this).index('.sub');
            document.cookie = "subInnerIndex=";
            $("#nav-menu a").removeClass("activeLink");
            $this.next(".sub-container").slideToggle(250)
                .siblings(".sub-container:visible").slideUp(250);
            $this.toggleClass("active");
            $this.find(".nav-menu-img").toggleClass("active");
            $this.siblings(".sub").removeClass("active");
            $this.siblings(".sub").find(".nav-menu-img").removeClass("active");
        }).eq(subIndex).addClass("active")
                .next().show().
                    find("a").eq(subInnerIndex).addClass('activeLink');
})();

$(window).on('load',() => {
    $('input:text.fast-search-index').focus();
});

//$(function(){
//            var toDisplay = 1;
//            $("article h2").click(function(){
//                var $this = $(this);
//                $this
//                    .next("p")
//                        .slideToggle("slow")
//                    .siblings("p:visible")
//                        .slideUp("slow");
//                $this.toggleClass("active");
//                $this.siblings("h2").removeClass("active");
//            })
//                .eq(toDisplay).addClass("active")
//                .next().show();
//        });

(function (){  
    
//    alert(subInnerIndex);
    $("div.sub-container a").click(function(){
            $("#nav-menu a").removeClass("activeLink");
            document.cookie = "subInnerIndex=" + $(this).index();
            
//            $(this).addClass("activeLink");
        });
    
    
})();

function getCookieByName(name) {
  var matches = document.cookie.match(new RegExp(
    "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
  ));
  return matches ? decodeURIComponent(matches[1]) : undefined;
}
//menu behaviour -------------------

//up-page loader-------------------- 
$(document).ready(function (){
       NProgress.start();
    });
    
$(window).on('load', function() {
//    setTimeout(function (){
//       
//       $('.out').removeClass('out');
//   },1);
   NProgress.done();
});
//up-page loader--------------------



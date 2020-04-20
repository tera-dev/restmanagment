/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var prods = new Object();
var recipe = {items:[]};
$(window).on('load',function (){
        $.ajax({
        url: 'index.php?r=product/get-products',
        data:{},
        type: 'GET',
        success: function (data) {
                prods = JSON.parse(data);
                window.console.log(prods);
            }
        });
});
$(window).on('load',function (){
//    alert();
    
    $('.add-ingt').on('click',function (){
//        alert();
        $('div.ingridients').append(`
            <div class="row ingr">
                
                <div class="ingridient-id col-xs-8">
                </div>
                <div class="ingridient-weight col-xs-4">
                    <input type="number" class="form-control weight-ingrid" placeholder="Вес"/>
                </div>
                <i class="fa fa-times-circle remove-ingr"></i>
            </div>`);
    
    
        $('div.ingridient-id').last().append(`<select class="id-ingrid"></select>`);
        var selectBox = $('.ingridients select').last();
        if( selectBox!== undefined){
            for(var key in prods){
                for(var innerKey in prods[key]){
                    selectBox.get(0).options.add( new Option(prods[key][innerKey]  + ", " + innerKey,  key));
                } 
            }
        }
        selectBox.last().addClass('selectpicker').attr({
                            'data-live-search':'true',
                            'data-size':'5',
                            'data-width':'100%',
                            'title':'Выберите ингридиент'
                        }).selectpicker('refresh').
                        on('change',function (){
                            window.console.log($(this).val());
                        });
    });
});

//to show ingridient menu for half-stuff
$(window).on('load',function (){
     $('input:radio').on('change',function (){
        if ($(this).hasClass('half-stuff-radio')) {
            $('.to-show-if-half-stuff').slideDown(150).addClass('visible');
        }
        else{
            $('.to-show-if-half-stuff').slideUp(150).removeClass('visible');
        }
     });
});

$(window).on('load',function (){
    var id,weight;
    $('.send-product').click(function (event){
        event.preventDefault();
        if ($('.to-show-if-half-stuff').hasClass('visible')) {
            if ($('div.ingr').length < 1) {
                alert('Нужно ввести хотя бы один ингридиент для полуфабриката.');
            }
            else{
                if (validateIngridientList()) {
                    recipe = {items:[]};
                    $('.ingr').each(function (){
                    recipe.items.push( {
                        id:$(this).find('select').val(),
                        weight:$(this).find('.weight-ingrid').val()
                        });
                    });
                    $('#product-half_stuff_recipe').attr('value',JSON.stringify(recipe));
                    $('form').submit();
                }
            }
            
            
        }
        else{
//            $(this).click();
            $('form').submit();
        }
        
    });
});

$(window).on('load',function (){
    $('div.ingridients').on('click','.remove-ingr',function (){
        $(this).parent().remove();
    });
});

$(window).on('load',function (){
    $('div.ingridients').on('change','select',function (){
        $(this).parent().css({'box-shadow':'0px 0px 0px 0px rgba(255,0,0,1)','border-radius':''});
        $(this).parents('div.ingr').find('.weight-ingrid').focus(); 
    });
});
 //0px 0px 5px 1px rgba(255,0,0,1);
function validateIngridientList(){
    let isValidated = true;
    $('.ingr').each(function (){
//        window.console.log("-" + $(this).find('.id-ingrid').attr('class') + "-");
//        window.console.log("-" + $(this).find('.weight-ingrid').val() + "-");
        if (!$(this).find('select').val()) {
            $(this).find("div.id-ingrid").css({'box-shadow':'0px 0px 5px 1px rgba(255,0,0,1)','border-radius':'5px'});
            isValidated = false;
        }
        else{
            $(this).find("div.id-ingrid").css({'box-shadow':'0px 0px 0px 0px rgba(255,0,0,1)','border-radius':''});
        }
        if (!$(this).find('.weight-ingrid').val()) {
            $(this).find('.weight-ingrid').
                css({'box-shadow':'0px 0px 5px 1px rgba(255,0,0,1)'});
            isValidated = false;
        }
        else{
            $(this).find(".weight-ingrid").css({'box-shadow':'0px 0px 0px 0px rgba(255,0,0,1)'});
        }
    });
    return isValidated;
}

$(window).on('load',function (){
    $('div.ingridients').on('focusout','.weight-ingrid',function (){
        console.log('focus weight out');
        if (!$(this).val()) {
            $(this).css({'box-shadow':'0px 0px 5px 1px rgba(255,0,0,1)'});
        }
        else $(this).css({'box-shadow':'0px 0px 0px 0px rgba(255,0,0,1)'});
    });
});


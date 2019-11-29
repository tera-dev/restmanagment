<div class="row product-search">
        <div class="col-xs-5">
            <label>Поиск</label>
            <input class="form-control" id="myInput" type="text" placeholder="Быстрый поиск..">
            
        </div>
</div>

<?php
$js = <<<JS
        $(document).ready(function(){
            $('tbody').attr('id','myTable');
            $("#myInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#myTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
JS;
?>
<?php $this->registerJs($js)?>

<?php $css = <<<CSS
        
        div.product-search{
            margin-bottom:30px;
        }
        
CSS;
?>

<?php $this->registerCss($css)?>
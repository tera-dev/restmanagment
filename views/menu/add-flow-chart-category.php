<?php use yii\helpers\Html?>
<?php use yii\widgets\ActiveForm?>

<div class="content-area-header"> 
    <!--<h3>Новая категория</h3>-->
    <div class="header">
        <?= Html::a('<i class="fa fa-angle-left arrow-back"></i>',['menu/flow-chart-categories'],['class' => 'url-back'])?>
        <span>Новая категория</span>
    </div>
    
</div>
<div class="content-area-body ">
        <?php $form = ActiveForm::begin([
            'method' => 'post',
            'action' => ['menu/add-flow-chart-category']
            ])?>
            <div class="row">
                <div class="col-xs-3">
                    <span>Название категории</span>
                </div>
                <div class="col-xs-7">
                    <?=$form->field($f_ch_cat_model, 'name',[
                        'inputOptions' => 
                            ['placeholder' => 'Название категории...',
                             'class' => 'form-control']
                    ])->textInput()->label(false)?>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-3">
                    <span>Категория</span>
                </div>
                <div class="col-xs-7">
                    <?= $form->field($f_ch_cat_model, 'parentID')->dropDownList($options,
                    [
                        'prompt' => 'Главный экран',
                        'encodeSpaces' => true
                    ])->label(false)?>
                </div>
            </div>
            <hr/>
            <div class="row">
                <div class="col-xs-3"></div>
                <div class="col-xs-7">
                    <input type="submit" class="btn btn-success btn-lg send" value="Сохранить"/>
                </div>
            </div>
        <?php $form = ActiveForm::end()?>
</div>



</script>





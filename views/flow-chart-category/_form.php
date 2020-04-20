<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use app\widgets\ContentHeader;
use brussens\bootstrap\select\Widget as Select;

/* @var $this yii\web\View */
/* @var $model app\models\FlowChartCategory */
/* @var $form yii\widgets\ActiveForm */
?>

<?= ContentHeader::widget([
    'urlBack' => 'flow-chart-category/index'
])?>

<div class="flow-chart-category-form content-area-body">

<?php $form = ActiveForm::begin()?>
            <div class="row">
                <div class="col-xs-3">
                    <span>Название категории</span>
                </div>
                <div class="col-xs-7">
                    <?=$form->field($model, 'name',[
                        'inputOptions' => 
                            ['placeholder' => 'Название категории...',
                             'class' => 'form-control']
                    ])->textInput()->label(false)?>
                </div>
            </div>
    
            
            <?php if ($model->parentID !== 0):?>
                <div class="row">
                    <div class="col-xs-3">
                        <span>Категория</span>
                    </div>
                    <div class="col-xs-7">
                        <?= $form->field($model, 'parentID')->dropDownList($options,
                        [
                            'prompt' => 'Выберите категорию',
                            'encodeSpaces' => true
                        ])->label(false)?>
                    </div>
                </div>
            <?php endif;?>

            
            <hr/>
            <div class="row">
                <div class="col-xs-3"></div>
                <div class="col-xs-7">
                    <input type="submit" class="btn btn-success btn-lg send" value="Сохранить"/>
                </div>
            </div>
        <?php $form = ActiveForm::end()?>

</div>

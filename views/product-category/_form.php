<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use app\widgets\ContentHeader;

/* @var $this yii\web\View */
/* @var $model app\models\ProductCategory */
/* @var $form yii\widgets\ActiveForm */
?>

<?= ContentHeader::widget([
    'urlBack' => 'product-category/index'
])?>
<div class="product-category-form content-area-body">

    <?php $form = ActiveForm::begin(); ?>
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
            <hr/>
            <div class="row">
                <div class="col-xs-3"></div>
                <div class="col-xs-7">
                    <?= Html::submitButton('Сохранить', ['class' => 'btn btn-success btn-lg send']) ?>
                </div>
            </div>

    <?php ActiveForm::end(); ?>

</div>

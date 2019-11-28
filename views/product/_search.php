<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ProductSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="product-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
        'options' => [
            'data-pjax' => 1
        ],
    ]); ?>

    <?= $form->field($model, 'productID') ?>

    <?= $form->field($model, 'name') ?>

    <?= $form->field($model, 'unitID') ?>

    <?= $form->field($model, 'expiry_count') ?>

    <?= $form->field($model, 'product_typeID') ?>

    <?php // echo $form->field($model, 'categoryID') ?>

    <?php // echo $form->field($model, 'half_stuff_recipe') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

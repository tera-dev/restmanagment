<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\FlowChartCategory */

$this->title = 'Новая категория';
?>

    <div class="flow-chart-category-create">


        <?= $this->render('_form', [
            'model' => $model,
            'options' => $options
        ]) ?>

    </div>

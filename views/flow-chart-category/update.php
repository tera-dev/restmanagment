<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\FlowChartCategory */

$this->title = 'Обновление категории: ' . $model->name;
//$this->params['breadcrumbs'][] = ['label' => 'Flow Chart Categories', 'url' => ['index']];
//$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['view', 'id' => $model->flow_chart_categoryID]];
//$this->params['breadcrumbs'][] = 'Update';
?>
<div class="flow-chart-category-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

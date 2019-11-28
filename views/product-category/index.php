<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use app\widgets\ContentHeader;
use app\widgets\FastSearch;
/* @var $this yii\web\View */
/* @var $searchModel app\models\ProductCategorySearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Категории ингридиентов';
//$this->params['breadcrumbs'][] = $this->title;
?>

<?= ContentHeader::widget([
    'btnRightText' => 'Добавить категорию',
    'btnRightUrl' => 'product-category/create'
])?>
<div class="product-category-index content-area-body col-xs-10">

    <?= FastSearch::widget()?>
    <?php Pjax::begin(); ?>
    <?php //echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
//        'filterModel' => $searchModel,
        'summary' => '',
        'rowOptions' => function ($model, $key, $index, $grid) {
            return ['class' => 'table-row'];
            },
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            'name',
            ['class' => 'yii\grid\ActionColumn',
             'contentOptions' => ['style' => 'width:200px; min-width:50px;'],
             'header' => 'Действия',
             'template' => '{view}&nbsp;&nbsp;{update}&nbsp;&nbsp;{delete}',
            ],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

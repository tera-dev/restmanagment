<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use app\widgets\ContentHeader;
use app\widgets\FastSearch;
/* @var $this yii\web\View */
/* @var $searchModel app\models\FlowChartCategorySearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Категории товаров и тех. карт';
//$this->params['breadcrumbs'][] = $this->title;
?>

<?= ContentHeader::widget([
    'btnRightText' => 'Добавить категорию',
    'btnRightUrl' => 'flow-chart-category/create'
])?>


<div class="flow-chart-category-index content-area-body col-xs-10">
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
//             'buttons' => [
//                'view' => function ($url, $model) {
//                return Html::a('<span>Редактировать&nbsp;|&nbsp;</span>', $url, [
//                            'title' => Yii::t('app', 'lead-view'),
//                    ]);
//                },
//                 'update' => function ($url, $model) {
//                return Html::a('<span>Обновить&nbsp;|&nbsp;</span>', $url, [
//                            'title' => Yii::t('app', 'lead-update'),
//                    ]);
//                },
//                'delete' => function ($url, $model) {
//                return Html::a('<span>&nbsp;Удалить</span>', $url, [
//                            'title' => Yii::t('app', 'lead-delete'),
//                    ]);
//                }   
//                ]
                
            ],
            
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use app\widgets\ContentHeader;
use app\models\Product;
use app\widgets\FastSearch;
/* @var $this yii\web\View */
/* @var $searchModel app\models\ProductSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Ингридиенты и полуфабрикаты';
?>
<?= ContentHeader::widget([
    'btnRightText' => 'Добавить ингридиент',
    'btnRightUrl' => 'product/create'
])?>
<div class="product-index content-area-body col-xs-10">
    
    <?= FastSearch::widget();?>

    <?php Pjax::begin(); ?>
    
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
//        'filterModel' => $searchModel,
        'summary' => '',
        'rowOptions' => function () {
            return ['class' => 'table-row'];
            },
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            'name',
            [
                'attribute' => 'unitID',
                'value' => 'unit.name'
            ],
            [
                'attribute' => 'categoryID',
                'value' => 'productCategory.name'
            ],
            [
                'attribute' => 'expiry_count',
                'value' => function($data){
                        return $data->expiry_count. " дней";
                    }
                ],
            [
                'attribute' => 'product_typeID',
                'value' => function($data){
                        if ($data->product_typeID === Product::PRODUCT_TYPE) {
                            return 'Ингридиент';
                        }
                        return 'Полуфабрикат';
                    }
            ],
            //'half_stuff_recipe',

            ['class' => 'yii\grid\ActionColumn',
             'contentOptions' => ['style' => 'width:200px; min-width:50px;'],
             'header' => 'Действия',
             'template' => '{view}&nbsp;&nbsp;{update}&nbsp;&nbsp;{delete}',
            ],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>


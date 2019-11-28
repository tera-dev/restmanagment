<?php

use yii\helpers\Html;
use yii\widgets\DetailView;
use app\widgets\ContentHeader;
use app\models\Product;
/* @var $this yii\web\View */
/* @var $model app\models\Product */

$this->title = $model->name;

\yii\web\YiiAsset::register($this);
?>
<?= ContentHeader::widget([
    'urlBack' => 'product/index'
])?>
<div class="product-view content-area-body col-xs-10">


    <p>
        <?= Html::a('Обновить', ['update', 'id' => $model->productID], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Удалить', ['delete', 'id' => $model->productID], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>
    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'name',
            [
                'attribute' => 'categoryID',
                'value' => $model->productCategory->name
            ],
            [
                'attribute' => 'unitID',
                'value' => $model->unit->name
            ],
            [
                'attribute' => 'expiry_count',
                'value' => function ($model){
                    return $model->expiry_count. " дней";
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
            
//            'half_stuff_recipe',
        ],
    ]) ?>

</div>

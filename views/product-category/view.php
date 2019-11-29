<?php

use yii\helpers\Html;
use yii\widgets\DetailView;
use app\widgets\ContentHeader;

/* @var $this yii\web\View */
/* @var $model app\models\ProductCategory */

$this->title = $model->name;

\yii\web\YiiAsset::register($this);
?>

<?= ContentHeader::widget([
    'urlBack' => 'product-category/index'
])?>
<div class="product-category-view content-area-body col-xs-10">


    <p>
        <?= Html::a('Обновить', ['update', 'id' => $model->product_categoryID], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Удалить', ['delete', 'id' => $model->product_categoryID], [
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
        ],
    ]) ?>

</div>

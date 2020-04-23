<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use app\models\Unit;
use yii\helpers\ArrayHelper;
use app\models\ProductCategory;
use app\widgets\ContentHeader;
/* @var $this yii\web\View */
/* @var $model app\models\Product */
/* @var $form yii\widgets\ActiveForm */
?>
<?= ContentHeader::widget([
    'urlBack' => 'product/index'
])?>
<div class="product-form content-area-body">

    <?php $form = ActiveForm::begin(); ?>

        <div class="row">
            <div class="col-xs-3">
                <span>Название ингридиента</span>
            </div>
            <div class="col-xs-7">
                <?=$form->field($model, 'name')->textInput(['maxlength' => true])->label(false)?>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-3">
                <span>Единица измерения</span>
            </div>
            <div class="col-xs-4">
                <?= $form->field($model, 'unitID')->dropDownList(
                        ArrayHelper::map(Unit::find()->all(),'unitID','name'),
                        [
                            'prompt' => 'Выберите единицу измерения'
                        ]
                    )->label(false)
                ?>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-3">
                <span>Срок пригодности</span>
            </div>
            <div class="col-xs-4">
                 <?= $form->field($model, 'expiry_count')->input('number')->label(false) ?>
            </div>
        </div>
    
        <div class="row">
            <div class="col-xs-3">
                <span>Категория</span>
            </div>
            <div class="col-xs-7">
                <?= $form->field($model, 'categoryID')->dropDownList(
                    ArrayHelper::map(ProductCategory::find()->all(),'product_categoryID','name'),
                         [
                             'prompt' => 'Выберите категорию'
                         ]
                )->label(false) ?>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-3">
                <span>Тип</span>
            </div>
            <div class="col-xs-7">
                <?= $form->field($model, 'product_typeID')->radioList(
                    [\app\models\Product::PRODUCT_TYPE => 'Ингридиент',
                     \app\models\Product::HALF_STUFF_TYPE => 'Полуфабрикат' 
                    ]
                )->label(false) ?>
            </div>
        </div>
        <div class="row to-show-if-half-stuff">
            <div class="col-xs-3"></div>
            <div class="col-xs-7">
                 <div class="ingridients">
                    <h4>Ингридиенты</h3>
                    
                </div>
                <div class="btn btn-primary add-ingt">Добавить</div>
            </div>
        </div>
        <hr/>

        
    <?= $form->field($model, 'half_stuff_recipe')->hiddenInput(['maxlength' => true],[
        'class' => 'hidden-for-json'
    ])->label(false) ?>
    
        <div class="row">
            <div class="col-xs-3"></div>
            <div class="col-xs-7">
                 <div class="form-group">
                    <?= Html::submitButton('Сохранить', ['class' => 'btn btn-success btn-lg send-product']) ?>
                </div>
            </div>
        </div>
    <?php ActiveForm::end(); ?>

</div>

<?php $this->registerJsFile('@web/js/bootstrap-select.min.js', [
    'depends' => [
        'yii\web\JqueryAsset',
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapPluginAsset'
    ]
])?>

<?php $this->registerJsFile('@web/js/my/new-product-script.js', [
    'depends' => [
        'yii\web\JqueryAsset',
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapPluginAsset'
    ]
])?>

<?php $this->registerCssFile('@web/css/bootstrap-select.min.css', [
    'depends' => [
        'yii\web\JqueryAsset',
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapPluginAsset'
    ]
])?>

<?php $css =
<<<CSS
       .add-ingt{
            margin-top: 15px;
        }
        .ingridients{
            padding-right: 15px;
            padding-left: 15px;
        }
        label{
            margin-right:50px;
        }
        .to-show-if-half-stuff{
            display:none;
        }
        div.ingr i{
            width:15px;
            height:15px;
            border-radius:10px;
            position: absolute;
            top:-10px;
            right:-9px;
            font-size:20px;
            color:#002259;
            background-color:white;
        }
        div.ingr i:hover{cursor:pointer;}
CSS;
?>

<?php $this->registerCss($css)?>
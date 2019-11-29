<?php use yii\helpers\Html;?>
<div class="content-area-header">
    <?php if (isset($btnRightText) && isset($btnRightUrl)) {
         echo Html::a($btnRightText, [$btnRightUrl],['class' => 'btn btn-success add-btn']);
     }?>

    <div class="header"> 
        <?php if (isset($urlBack)) {
            echo Html::a('<i class="fa fa-arrow-left"></i>',[$urlBack],['class' => 'url-back']);
        }?>
        <span><?= Html::encode($this->title) ?></span>
    </div>
</div>
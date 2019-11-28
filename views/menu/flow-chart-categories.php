<?php use yii\helpers\Html;
use yii\grid\GridView;
?>


<div class="content-area-header"> 
    <!--<h1>Добавление категории</h1>-->
    <?= Html::a("Добавить категорию", ['menu/add-flow-chart-category'],['class' => 'btn btn-success add-btn'])?>
</div>
<div class="content-area-body">
    <h1>list of flow</h1>
        <?php 
//        print_r($dataProvider)
         
        echo GridView::widget([
            'dataProvider' => $dataProvider,
            'filterModel' => $searchModel,
            'columns' => [
                ['class' => 'yii\grid\SerialColumn'],
                'name',
                [
                    'class' => 'yii\grid\ActionColumn',
                    'template' => '{view}{update}'
                    
                ]
                
            ]
        ])
        
        
        ?>

</div>



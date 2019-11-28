<?php

namespace app\controllers;

use Yii;
use app\models\FlowChartCategory;
use app\models\FlowChartCategorySearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * FlowChartCategoryController implements the CRUD actions for FlowChartCategory model.
 */
class FlowChartCategoryController extends Controller
{
    
    public $treeLevel = 0;
    public $newItems = array();
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['POST'],
                ],
            ],
        ];
    }

    /**
     * Lists all FlowChartCategory models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new FlowChartCategorySearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single FlowChartCategory model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        $model = $this->findModel($id);
        return $this->render('view', [
            'model' => $model,
            'parentName' => $this->getParentName($model->parentID)
        ]);
    }

    /**
     * Creates a new FlowChartCategory model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new FlowChartCategory();
        if ($model->load(Yii::$app->request->post())) {
            echo "<pre>";
            print_r(Yii::$app->request->post());
            echo "</pre>";
            die();
            if ($model->validate()) {
                if ($model->parentID === '') {
                    $model->parentID = 0;
                    $model->save();
                }
                else{
                    $model->save();
                }
                return $this->refresh();
            }
            
        }
        
        $options = $this->categories_to_string($this->getTree());
        return $this->render('create', [
            'model' => $model,
            'options' => $options
        ]);
    }
    
    public function loadFlowChartCategoryData(){
        return FlowChartCategory::find()->indexBy('flow_chart_categoryID')->asArray()->all();
    }
    
        public function getTree(){
        $data = $this->loadFlowChartCategoryData();
        $tree = [];
        foreach ($data as $id => &$node) {
            if (!$node['parentID']) {
                $tree [$id] = &$node;
            }
            else{
                $data[$node['parentID']]['children'][$node['flow_chart_categoryID']] = &$node;
            }
        }
        return $tree;
    }
    
    private function categories_to_string($inData){
        foreach ($inData as $item) {
            $this->categories_to_template($item);
        }
        return $this->newItems;
    }
    
    private function categories_to_template($category){
        if(isset($category['children'])){
            $this->newItems [$category['flow_chart_categoryID']] = 
                    $this->makeSpaces($this->treeLevel).$category['name'];
            $this->treeLevel++;

            $this->categories_to_string($category['children']);
            $this->treeLevel--;
        }
    
        else{
            $this->newItems [$category['flow_chart_categoryID']] = 
                    $this->makeSpaces($this->treeLevel).$category['name'];
        }
    

    }
    
    private function makeSpaces($number){
        $str = "";
        for($i = 0; $i < $number; $i++){
            $str .= '     ';
        }
        return $str;
    }
    
    public function getParentName($parentId){
        return FlowChartCategory::findOne(['flow_chart_categoryID' => $parentId])->name;
    }
    

    /**
     * Updates an existing FlowChartCategory model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->flow_chart_categoryID]);
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing FlowChartCategory model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the FlowChartCategory model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return FlowChartCategory the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = FlowChartCategory::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}

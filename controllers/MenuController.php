<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\controllers;

use yii\web\Controller;
//use app\controllers\CategoryItem;

//use app\models\menu\FlowChartCategorySearch;
use yii\helpers\ArrayHelper;
use yii\widgets\ActiveForm;
use yii\data\ActiveDataProvider;
//use yii\web\Request;
use Yii;

/**
 * Description of MyController
 *
 * @author Admin
 */
class MenuController extends Controller{
    //put your code here

    public function actionIndex(){
        return $this->render('index');
    }
    

}

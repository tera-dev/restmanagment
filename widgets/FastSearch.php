<?php 
namespace app\widgets;

use yii\base\Widget;

class FastSearch extends Widget
{
    public $name;
    public function init() {
        parent::init();
    }

    public function run()
    {
        return $this->render('fast_search');
    }
}
?>
<?php 
namespace app\widgets;

use yii\base\Widget;

class NavMenu extends Widget
{
    public function run()
    {
        return $this->render('nav_menu');
    }
}
?>
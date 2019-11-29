<?php 
namespace app\widgets;

use yii\base\Widget;

class ContentHeader extends Widget
{
    public $urlBack;
    public $btnRightText;
    public $btnRightUrl;
    
    public function init() {
        parent::init();
    }


    public function run()
    {
        return $this->render('content_header', ['urlBack' => $this->urlBack,
            'btnRightText' => $this->btnRightText,'btnRightUrl' => $this->btnRightUrl]);
    }
}
?>
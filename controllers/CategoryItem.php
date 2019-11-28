<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\controllers;


/**
 * Description of MyController
 *
 * @author Admin
 */
class CategoryItem {
    public $id;
    public $parentId;
    
    public function __construct($inId,$inParentId) {
        $this->id = $inId;
        $this->parentId = $inParentId;
    }


    public function setId($inId){
        $this->id = $inId;
    }
    
    public function setParentId($inParentId){
        $this->parentId = $inParentId;
    }
    
    public function getId(){
        return $this->id;
    }
    
    public function getParentId(){
        return $this->parentId;
    }
        
}
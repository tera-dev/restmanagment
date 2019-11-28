<?php if(isset($category['children'])):?>
    
            
        <?php $newItems += [$category['flow_chart_categoryID'] => 
            $this->makeSpaces($this->treeLevel).$category['name']]?>
        <?php $this->treeLevel++?>
    
        <?=$this->categories_to_string($category['children'])?>
        <?php $this->treeLevel--?>
    
<?php else:?>
    <?php $newItems += [$category['flow_chart_categoryID'] => 
            $this->makeSpaces($this->treeLevel).$category['name']]?>

<?php endif;?>


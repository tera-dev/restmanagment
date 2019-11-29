<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "flow_charts".
 *
 * @property int $flow_chartID
 * @property string $name
 * @property int $price
 * @property int $categoryID
 * @property int $is_good
 *
 * @property FlowChartModifiers[] $flowChartModifiers
 * @property FlowChartRecipes[] $flowChartRecipes
 * @property FlowChartCategories $category
 * @property OrderDetails[] $orderDetails
 */
class FlowChart extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'flow_charts';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'price', 'categoryID', 'is_good'], 'required'],
            [['price', 'categoryID', 'is_good'], 'integer'],
            [['name'], 'string', 'max' => 200],
            [['categoryID'], 'exist', 'skipOnError' => true, 'targetClass' => FlowChartCategories::className(), 'targetAttribute' => ['categoryID' => 'flow_chart_categoryID']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'flow_chartID' => 'Flow Chart I D',
            'name' => 'Name',
            'price' => 'Price',
            'categoryID' => 'Category I D',
            'is_good' => 'Is Good',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFlowChartModifiers()
    {
        return $this->hasMany(FlowChartModifiers::className(), ['flow_chartID' => 'flow_chartID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFlowChartRecipes()
    {
        return $this->hasMany(FlowChartRecipes::className(), ['flow_chartID' => 'flow_chartID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCategory()
    {
        return $this->hasOne(FlowChartCategories::className(), ['flow_chart_categoryID' => 'categoryID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getOrderDetails()
    {
        return $this->hasMany(OrderDetails::className(), ['flow_chartID' => 'flow_chartID']);
    }
}

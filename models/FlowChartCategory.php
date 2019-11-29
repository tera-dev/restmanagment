<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "flow_chart_categories".
 *
 * @property int $flow_chart_categoryID
 * @property string $name
 * @property int $parentID
 *
 * @property FlowCharts[] $flowCharts
 */
class FlowChartCategory extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'flow_chart_categories';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['parentID'], 'safe'],
            [['name'], 'string', 'max' => 100],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'flow_chart_categoryID' => 'Flow Chart Category I D',
            'name' => 'Название',
            'parentID' => 'Parent I D',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFlowCharts()
    {
        return $this->hasMany(FlowCharts::className(), ['caterodyID' => 'flow_chart_categoryID']);
    }
    

}

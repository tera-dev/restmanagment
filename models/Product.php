<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "products".
 *
 * @property int $productID
 * @property string $name
 * @property int $unitID
 * @property int $expiry_count
 * @property int $product_typeID
 * @property int $categoryID
 * @property string $half_stuff_recipe
 *
 * @property FlowChartRecipes[] $flowChartRecipes
 * @property HalfStuffOrderDetails[] $halfStuffOrderDetails
 * @property HalfStuffRecipes[] $halfStuffRecipes
 * @property HalfStuffRecipes[] $halfStuffRecipes0
 * @property ProductStorage[] $productStorages
 * @property ProductCategories $category
 * @property Units $unit
 * @property ProductsInInvoices[] $productsInInvoices
 */
class Product extends \yii\db\ActiveRecord
{
    const PRODUCT_TYPE = 1;
    const HALF_STUFF_TYPE = 0;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'products';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'unitID', 'expiry_count', 'product_typeID', 'categoryID'], 'required'],
            [['unitID', 'expiry_count', 'product_typeID', 'categoryID'], 'integer'],
            [['name'], 'string', 'max' => 200],
            [['half_stuff_recipe'], 'string', 'max' => 2000],
            [['categoryID'], 'exist', 'skipOnError' => true, 'targetClass' => ProductCategory::className(), 'targetAttribute' => ['categoryID' => 'product_categoryID']],
            [['unitID'], 'exist', 'skipOnError' => true, 'targetClass' => Unit::className(), 'targetAttribute' => ['unitID' => 'unitID']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'productID' => 'Product I D',
            'name' => 'Название',
            'unitID' => 'Единица измерения',
            'expiry_count' => 'Срок пригодности',
            'product_typeID' => 'Тип',
            'categoryID' => 'Категория',
            'half_stuff_recipe' => 'Рецепт',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFlowChartRecipes()
    {
        return $this->hasMany(FlowChartRecipes::className(), ['ingridID' => 'productID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getHalfStuffOrderDetails()
    {
        return $this->hasMany(HalfStuffOrderDetails::className(), ['half_stuffID' => 'productID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getHalfStuffRecipes()
    {
        return $this->hasMany(HalfStuffRecipes::className(), ['half_stuffID' => 'productID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getHalfStuffRecipes0()
    {
        return $this->hasMany(HalfStuffRecipes::className(), ['productID' => 'productID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProductStorages()
    {
        return $this->hasMany(ProductStorage::className(), ['productID' => 'productID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProductCategory()
    {
        return $this->hasOne(ProductCategory::className(), ['product_categoryID' => 'categoryID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUnit()
    {
        return $this->hasOne(Unit::className(), ['unitID' => 'unitID']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProductsInInvoices()
    {
        return $this->hasMany(ProductsInInvoices::className(), ['productID' => 'productID']);
    }
}

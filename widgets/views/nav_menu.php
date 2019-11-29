<?php use yii\helpers\Html;?>

<div class="nav-menu-header"><a href="#" class="nav-menu-to-terminal">
    <?=Html::img("@web/images/to-terminal.png")?>
    </a></div>
    <div class="nav-menu-body">
        <p class="sub"><?=Html::img("@web/images/statistics.png",['class' =>'nav-menu-img'])?>Статистика</p>
        <div class="sub-container">
            <a href="#">Товары</a>
            <a href="#">Продажи</a>
            <a href="#">Клиенты</a>
            <a href="#">Официанты</a>
            <a href="#">Цеха</a>
            <a href="#">Категории</a>
            <a href="#">Столы</a>
        </div>
        <p class="sub"><?=Html::img("@web/images/menu.png",['class' =>'nav-menu-img'])?>Меню</p>
        <div class="sub-container">
            <a href="?r=site/index">Товары</a>
            <a href="#">Тех. карты</a>
            <?= Html::a("Ингридиенты и полуфабрикаты", ['product/index'])?>
            <?= Html::a("Категории товаров и тех. карт", ['flow-chart-category/index'])?>
            <?= Html::a("Категории ингридиентов", ['product-category/index'])?>
        </div>
        <p class="sub"><?=Html::img("@web/images/storage.png",['class' =>'nav-menu-img'])?>Склад</p>
        <div class="sub-container">
            <a href="#">Остатки</a>
            <a href="#">Поставки</a>
            <a href="#">Списания со складов</a>
            <a href="#">Перемещения между складами</a>
            <a href="#">Поставщики</a>
            <a href="#">Склады</a>
            <a href="#">Фасовки</a>
        </div>
        <p class="sub"><?=Html::img("@web/images/marketing.png",['class' =>'nav-menu-img'])?>Маркетинг</p>
        <div class="sub-container">
            <a href="#">Клиенты</a>
            <a href="#">Группы клиентов</a>
            <a href="#">Программы лояльности</a>
            <a href="#">Акции</a>
            <a href="#">Исключения</a> 
        </div>    
        <p class="sub"><?=Html::img("@web/images/access.png",['class' =>'nav-menu-img'])?>Доступ</p>
        <div class="sub-container">
            <a href="#">Сотрудники</a>
            <a href="#">Должности</a>
        </div>
        <p class="sub"><?=Html::img("@web/images/settings.png",['class' =>'nav-menu-img'])?>Настройки</p>
        <div class="sub-container">
            <a href="#">Общие</a>
            <a href="#">Оплата</a>
            <a href="#">Столы</a>
        </div>
    </div>
    <div class="nav-menu-footer">Имя пользователя</div>
    
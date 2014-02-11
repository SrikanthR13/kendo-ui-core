﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <h3>Horizontal reordering</h3>
    <div id="sortable-horizontal">
        <div class="tile">1</div>
        <div class="tile">2</div>
        <div class="tile">3</div>
        <div class="tile">4</div>
        <div class="tile">5</div>
        <div class="tile">6</div>
        <div class="tile">7</div>
        <div class="tile">8</div>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-horizontal")
        .Axis(SortableAxis.X)
    %>

    <h3>Container restriction</h3>
    <div class="sortable-wrapper">
        <ul id="sortable-container">
            <li class="item">Item1</li>
            <li class="item">Item2</li>
            <li class="item">Item3</li>
            <li class="item">Item4</li>
            <li class="item">Item5</li>
            <li class="item">Item6</li>
            <li class="item">Item7</li>
            <li class="item">Item8</li>
        </ul>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-container")
        .ContainerSelector(".sortable-wrapper")
    %>

    <style>
        #example {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        #sortable-horizontal {
            overflow: hidden;
            width: 370px;
            margin: 20px auto;
            text-align: center;
        }

        .tile {
            width: 40px;
            line-height: 40px;
            margin: 2px;
            float: left;
            border: 1px solid black;
            background: #FFFF99;
            text-align: center;
        }

        .sortable-wrapper {
            width: 215px;
            margin: 0 auto;
            padding: 5px;
            border: 1px solid red;
        }

        #sortable-container {
            padding: 0;
            margin: 0;
        }

        .item {
            list-style-type: none;
            margin: 5px;
            line-height: 30px;
            min-width: 200px;
            text-align: center;
            border: 1px solid orange;
            background-color: #CCFF33;
        }
    </style>
</asp:Content>
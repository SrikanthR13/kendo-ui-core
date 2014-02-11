﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <h3>One way connection</h3>
    <div class="list-wrapper">
        <ul id="sortable-listA">
            <li class="list-item">Item1</li>
            <li class="list-item">Item2</li>
            <li class="list-item">Item3</li>
        </ul>

        <ul id="sortable-listB">
            <li class="list-item">Item1</li>
            <li class="list-item">Item2</li>
            <li class="list-item">Item3</li>
        </ul>
    </div>

    <h3>Two way connection</h3>
    <div class="list-wrapper">
        <ul id="sortable-listC" style="min-height: 41px;">
            <li class="list-item">Item1</li>
            <li class="list-item">Item2</li>
            <li class="list-item">Item3</li>
        </ul>

        <ul id="sortable-listD" style="min-height: 41px;">
            <li class="list-item">Item1</li>
            <li class="list-item">Item2</li>
            <li class="list-item">Item3</li>
        </ul>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-listA")
        .ConnectWith("#sortable-listB")
    %>

    <%:Html.Kendo().Sortable()
        .For("#sortable-listB")
    %>

    <%:Html.Kendo().Sortable()
        .For("#sortable-listC")
        .ConnectWith("#sortable-listD")
        .PlaceholderHandler("placeholder")
    %>

    <%:Html.Kendo().Sortable()
        .For("#sortable-listD")
        .ConnectWith("#sortable-listC")
        .PlaceholderHandler("placeholder")
    %>

    <script>
        function placeholder(element) {
            return $("<li class='list-item' id='placeholder'>Drop Here!</li>");
        }
    </script>

    <style>
        #example {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        .list-wrapper {
            overflow: hidden;
        }

        #sortable-listA, #sortable-listB, #sortable-listC, #sortable-listD {
            width: 210px;
            margin: 0;
            padding: 0;
            border: 1px solid black;
        }

        #sortable-listA, #sortable-listC {
            float: left;
        }

        #sortable-listB, #sortable-listD {
            float: right;
        }

        .list-item {
            list-style-type: none;
            margin: 5px;
            line-height: 30px;
            width: 200px;
            text-align: center;
            border: 1px solid black;
            color: white;
            background-color: #606162;
        }

        #sortable-listA .list-item {
            background-color: #0033FF;
        }

        #sortable-listB .list-item {
            background-color: #CC0033;
        }

        #sortable-listC .list-item {
            background-color: #66CC66;
        }

        #sortable-listD .list-item {
            background-color: #FFCC33;
        }

        #placeholder.list-item {
            background-color: yellow;
            border-color: orange;
            color: #000000;
        }
    </style>
</asp:Content>
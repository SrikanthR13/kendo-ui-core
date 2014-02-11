﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <div class="list-wrapper">
        <ul id="sortable-left" style="min-height: 41px;">
            <li class="list-left">Item1</li>
            <li class="list-left">Item2</li>
            <li class="list-left">Item3</li>
        </ul>

        <ul id="sortable-right" style="min-height: 41px;">
            <li class="list-right">Item1</li>
            <li class="list-right">Item2</li>
            <li class="list-right">Item3</li>
        </ul>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-left")
        .ConnectWith("#sortable-right")
        .PlaceholderHandler("placeholder")
        .Events(events => events.Start("onStart").Move("onMove").End("onEnd").Change("onChange").Cancel("onCancel"))
    %>

    <%:Html.Kendo().Sortable()
        .For("#sortable-right")
        .ConnectWith("#sortable-left")
        .PlaceholderHandler("placeholder")
        .Events(events => events.Start("onStart").Move("onMove").End("onEnd").Change("onChange").Cancel("onCancel"))
    %>

    <script>
        function placeholder(element) {
            return element.clone().css("opacity", 0.4);
        }

        function onStart(e) {
            var id = e.sender.element.attr("id");
            kendoConsole.log(id + " start: " + e.item.text());
        }

        function onMove(e) {
            var id = e.sender.element.attr("id"),
                placeholder = e.list.placeholder;

            kendoConsole.log(id + " move to index: " + this.indexOf(placeholder));
        }

        function onEnd(e) {
            var id = e.sender.element.attr("id"),
                text = e.item.text(),
                oldIndex = e.oldIndex,
                newIndex = e.newIndex;

            kendoConsole.log(id + " end: " + text + " oldIndex: " + oldIndex + " newIndex: " + newIndex + " action: " + e.action);
            console.log(e.action);
        }

        function onChange(e) {
            var id = e.sender.element.attr("id"),
                text = e.item.text(),
                newIndex = e.newIndex,
                oldIndex = e.oldIndex;

            kendoConsole.log(id + " change: " + text + " newIndex: " + newIndex + " oldIndex: " + oldIndex + " action: " + e.action);
            console.log(e.action);
        }

        function onCancel(e) {
            kendoConsole.log("cancel");
        }
    </script>

    <div class="console"></div>

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

        #sortable-left, #sortable-right {
            width: 215px;
            margin-left: 50px;
            padding: 0;
            float: left;
            border: 1px solid black;
        }

        .list-right, .list-left {
            list-style-type: none;
            margin: 5px;
            line-height: 30px;
            width: 200px;
            text-align: center;
            border: 1px solid black;
            color: white;
        }

        .list-left {
            background-color: #0033FF;
        }

        .list-right {
            background-color: #CC0033;
        }
    </style>
</asp:Content>
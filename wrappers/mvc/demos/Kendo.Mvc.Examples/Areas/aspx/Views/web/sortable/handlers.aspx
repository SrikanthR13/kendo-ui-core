﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <div id="sortable-handlers">
        <div class="item">
            <span class="handler">
                <span class="k-icon k-i-insert-m"></span>
            </span>
            <span>Item1</span>
        </div>
        <div class="item">
            <span class="handler">
                <span class="k-icon k-i-insert-m"></span>
            </span>
            <span>Item2</span>
        </div>
        <div class="item">
            <span class="handler">
                <span class="k-icon k-i-insert-m"></span>
            </span>
            <span>Item3</span>
        </div>
        <div class="item">
            <span class="handler">
                <span class="k-icon k-i-insert-m"></span>
            </span>
            <span>Item4</span>
        </div>
        <div class="item">
            <span class="handler">
                <span class="k-icon k-i-insert-m"></span>
            </span>
            <span>Item5</span>
        </div>
        <div class="item">
            <span class="handler">
                <span class="k-icon k-i-insert-m"></span>
            </span>
            <span>Item6</span>
        </div>
        <div class="item">
            <span class="handler">
                <span class="k-icon k-i-insert-m"></span>
            </span>
            <span>Item7</span>
        </div>
        <div class="item">
            <span class="handler">
                <span class="k-icon k-i-insert-m"></span>
            </span>
            <span>Item8</span>
        </div>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-handlers")
        .Handler(".k-icon")
        .Placeholder("<div class='placeholder'></div>")
    %>

    <style scoped>
        #example {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        .item {
            margin: 5px;
            border: 1px solid black;
            background-color: #D8D8D8;
            width: 200px;
            border-radius: 3px;
        }

        .handler {
            display: inline-block;
            padding: 7px;
        }

        .placeholder {
            width: 210px;
            border: 1px solid red;
        }
                
    </style>
</asp:Content>
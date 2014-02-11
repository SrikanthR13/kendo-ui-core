﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <div class="sortable-wrapper">
        <h4>Disable</h4>
        <p>Disabled items cannot be dragged but are valid drop targets.</p>
        <div id="sortable-disable">
            <div class="sortable disabled">Disabled (Item 1)</div>
            <div class="sortable disabled">Disabled (Item 2)</div>
            <div class="sortable">Item 3</div>
            <div class="sortable">Item 4</div>
            <div class="sortable">Item 5</div>
            <div class="sortable">Item 6</div>
            <div class="sortable">Item 7</div>
            <div class="sortable">Item 8</div>
        </div>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-filter")
        .Filter(".sortable")
    %>

    <div class="sortable-wrapper">
        <h4>Filter</h4>
        <p>Filtered items cannot be dragged and are not valid drop targets.</p>
        <div id="sortable-filter">
            <div class="not-sortable">Not sortable (Item 1)</div>
            <div class="not-sortable">Not sortable (Item 2)</div>
            <div class="sortable">Item 3</div>
            <div class="sortable">Item 4</div>
            <div class="sortable">Item 5</div>
            <div class="sortable">Item 6</div>
            <div class="sortable">Item 7</div>
            <div class="sortable">Item 8</div>
        </div>
    </div>

    <%:Html.Kendo().Sortable()
        .For("#sortable-disable")
        .Disabled(".disabled")
    %>

    <style>
        #example {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        .sortable-wrapper {
            width: 50%;
            float: left;
        }

        .sortable-wrapper > div {
            width: 235px;
            margin: 0 auto;
        }

        .sortable, .not-sortable {
            list-style-type: none;
            padding: 5px;
            margin: 3px;
            border: 1px solid black;
            width: 200px;
            text-align: center;
            border-radius: 3px;
            color: #FFFFFF;
        }

        .sortable {
            background-color: #51A0ED;
        }

        .not-sortable {
            background-color: #8E8E8E;
            opacity: 0.5;
        }

        .disabled {
            background-color: #FF0000;
            opacity: 0.5;
        }
    </style>
</asp:Content>
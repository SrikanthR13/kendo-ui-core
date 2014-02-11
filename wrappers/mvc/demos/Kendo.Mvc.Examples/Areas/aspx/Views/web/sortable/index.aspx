﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <ul id="sortable-basic">
        <li class="sortable">Item1</li>
        <li class="sortable">Item2</li>
        <li class="sortable">Item3</li>
        <li class="sortable">Item4</li>
        <li class="sortable">Item5</li>
        <li class="sortable">Item6</li>
        <li class="sortable">Item7</li>
        <li class="sortable">Item8</li>
    </ul>

    <%:Html.Kendo().Sortable()
        .For("#sortable-basic")
        .PlaceholderHandler("placeholder")
    %>

    <script>
        function placeholder(element) {
            return element.clone().addClass("placeholder");
        }
    </script>

    <style>
        #example {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        #sortable-basic {
            padding: 0;
            margin: 0 auto;
            width: 235px;
        }

        li.sortable {
            list-style-type: none;
            padding: 10px;
            margin: 5px;
            border: 1px solid #000000;
            border-radius: 5px;
            background-color: #51A0ED;
            color: #FFFFFF;
            width: 200px;
            text-align: center;
        }

        li.placeholder {
            background-color: #FFFFFF;
            color: #000000;
            border: 1px dashed #606162;
        }
    </style>
</asp:Content>

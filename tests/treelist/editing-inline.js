(function() {
    var dom;
    var instance;
    var TreeListDataSource = kendo.data.TreeListDataSource;

    module("TreeList inline editing", {
        setup: function() {
           dom = $("<div />").appendTo(QUnit.fixture);
        },
        teardown: function() {
            kendo.destroy(QUnit.fixture);

            dom = instance = null;
        }
    });

    function createTreeList(options) {
        dom.kendoTreeList($.extend(true, {}, {
            dataSource: {
                data: [
                    { id: 1, parentId: null },
                    { id: 3, parentId: null },
                    { id: 2, parentId: 1 }
                ]
            },
            columns: [ "id", "parentId" ]
        }, options));

        instance = dom.data("kendoTreeList");
    }

    test("editRow initializes Editable", function() {
        createTreeList();

        instance.editRow(instance.content.find("tr").first());

        ok(instance.editable instanceof kendo.ui.Editable);
        ok(instance.content.find("tr").first().data("kendoEditable"));
    });

    test("editRow initializes Editable from jQuery selector", function() {
        createTreeList();

        instance.editRow("tr:first");

        ok(instance.editable instanceof kendo.ui.Editable);
        ok(instance.content.find("tr").first().data("kendoEditable"));
    });

    test("editRow adds k-grid-edit-row to the row", function() {
        createTreeList();

        instance.editRow(instance.content.find("tr").first());

        ok(instance.content.find("tr").first().hasClass("k-grid-edit-row"));
    });

    test("editRow sets model to Editable", function() {
        createTreeList();

        var row = instance.content.find("tr").first();
        var dataItem = instance.dataItem(row);

        instance.editRow(row);

        strictEqual(instance.editable.options.model, dataItem);
    });

    test("editRow destroys previous Editable", function() {
        createTreeList();

        instance.editRow(instance.content.find("tr").first());
        instance.editRow(instance.content.find("tr").last());

        ok(!instance.content.find("tr").first().data("kendoEditable"), "first Editable is not destroyed");
        ok(instance.content.find("tr").last().data("kendoEditable"), "second Editable is not created");
    });

    test("editing row passes fields to Editable", function() {
        createTreeList();

        instance.editRow(instance.content.find("tr").first());

        var fields = instance.editable.options.fields;

        equal(fields.length, 2);
        equal(fields[0].field, "id");
        equal(fields[1].field, "parentId");
    });

    test("editing row passes column format to Editable", function() {
        createTreeList({
            columns: [
                { field: "id", format: "{0}" },
                "parentId"
            ]
        });

        instance.editRow(instance.content.find("tr").first());

        var fields = instance.editable.options.fields;

        equal(fields[0].format, "{0}");
    });

    test("editing row passes column editor to Editable", function() {
        createTreeList({
            columns: [
                { field: "id", editor: $.noop },
                "parentId"
            ]
        });

        instance.editRow(instance.content.find("tr").first());

        var fields = instance.editable.options.fields;

        ok(fields[0].editor);
    });

    test("do not pass column without field", function() {
        createTreeList({
            columns: [
                { template: "foo" },
                "parentId"
            ]
        });

        instance.editRow(instance.content.find("tr").first());

        var fields = instance.editable.options.fields;

        equal(fields.length, 1);
        equal(fields[0].field, "parentId");
    });

    test("read-only fields are not passed to Editable", function() {
        createTreeList({
            dataSource: {
                schema: {
                    model: {
                        fields: {
                            id: { editable: false },
                            parentId: { defaultValue: null }
                        }
                    }
                }
            }
        });

        instance.editRow(instance.content.find("tr").first());

        var fields = instance.editable.options.fields;

        equal(fields.length, 1);
        equal(fields[0].field, "parentId");
    });

    test("clearContainer is set to false", function() {
        createTreeList();

        instance.editRow(instance.content.find("tr").first());

        strictEqual(instance.editable.options.clearContainer, false);
    });

    test("editable cells are prepared for editors", function() {
        createTreeList();

        var row = instance.content.find("tr").first();
        instance.editRow(row);

        var cells = instance.content.find("tr").first().children();
        equal(cells.eq(0).attr(kendo.attr("container-for")), "id");
        equal(cells.eq(1).attr(kendo.attr("container-for")), "parentId");
    });

    test("editRow trigger edit event", 1, function() {
        createTreeList({
            edit: function() {
                ok(true);
            }
        });

        instance.editRow(instance.content.find("tr").first());
    });

    test("edit event argumetns", 2, function() {
        createTreeList({
            edit: function(e) {
                var row = this.content.find("tr");
                equal(e.container[0], row[0]);
                equal(e.model.id, 1);
            }
        });

        instance.editRow(instance.content.find("tr").first());
    });

    test("cancelRow destroy current editable", function() {
        createTreeList();

        instance.editRow("tr:first");
        instance.cancelRow();

        ok(!instance.editable);
        ok(!instance.content.find("tr:first").data("kendoEditable"));
    });

    test("cancelRow cancel changes for current model", function() {
        createTreeList({
            dataSource: {
                data: [
                    { id: 1, parentId: null, text: "foo" },
                    { id: 2, parentId: null, text: "bar" }
                ]
            }
        });

        var row = instance.content.find("tr").first();
        var model = instance.dataItem(row);

        instance.editRow(row);

        model.set("text", "baz");

        instance.cancelRow();

        equal(model.text, "foo");
        ok(!model.dirty);
    });

    test("cancelRow repaints the row", function() {
        createTreeList();

        var row = instance.content.find("tr").first();
        instance.editRow(row);
        instance.cancelRow();

        row = instance.content.find("tr").first();

        equal(row.find("input").length, 0);
        equal(row.children().eq(0).text(), "1");
    });

    test("edit another row repaints the previous row", function() {
        createTreeList();

        instance.editRow(instance.content.find("tr").first());
        instance.editRow(instance.content.find("tr").last());

        var row = instance.content.find("tr").first();
        equal(row.find("input").length, 0);
        equal(row.children().eq(0).text(), "1");
    });

    test("widget destroy destroyes current editor", function() {
        createTreeList();

        instance.editRow("tr:first");
        instance.destroy();

        ok(!instance.editable);
        ok(!dom.find("tbody>tr:first").data("kendoEditable"));
    });

    test("widget refresh destroys editable", function() {
        createTreeList();

        instance.editRow("tr:first");
        instance.refresh();

        ok(!instance.editable);
        ok(!dom.find("tbody>tr:first").data("kendoEditable"));
        equal(dom.find(".k-grid-edit-row").length, 0);
    });

    test("refresh doesn't destroy ediatble on itemchange", function() {
        createTreeList({
            dataSource: {
                data: [
                    { id: 1, text: "foo", parentId: null },
                    { id: 3, text: "bar", parentId: null },
                ]
            }
        });

        instance.editRow("tr:first");

        var editable = instance.editable;

        instance.dataSource.at(0).set("text", "baz");

        strictEqual(editable, instance.editable);
    });

    test("saveRow calls data source sync method", function() {
        var ds = new TreeListDataSource({
            data: [
                { id: 1, parentId: null },
                { id: 2, parentId: 1 }
            ]
        });

        var syncSpy = spy(ds, "sync");

        createTreeList({
            dataSource: ds
        });

        instance.editRow("tr:first");
        instance.saveRow();

        equal(syncSpy.calls("sync"), 1);
    });

    test("sync is not called if there are validation errors", function() {
        var ds = new TreeListDataSource({
            data: [
                { id: 1, text: "foo", parentId: null },
                { id: 2, text: "bar", parentId: 1 }
            ],
            schema: {
                model: {
                    fields: {
                        text: { validation: { required: true } }
                    }
                }
            }
        });

        var syncSpy = spy(ds, "sync");

        createTreeList({
            dataSource: ds,
            columns: [ "id", "text" ]
        });

        instance.editRow("tr:first");
        instance.content.find("tr:first input").val("");
        instance.saveRow();

        equal(syncSpy.calls("sync"), 0);
    });

    test("saveRow triggers save event", 2, function() {
        var model;

        createTreeList({
            save: function(e) {
                strictEqual(e.model, model);
                ok(e.container);
            }
        });

        instance.editRow("tr:first");
        model = instance.dataItem(instance.content.find("tr:first"));
        instance.saveRow();
    });

    test("save event doesn't trigger if there is no editable row", function() {
        var wasCalled = false;
        createTreeList({
            save: function() {
                wasCaleld = true;
            }
        });

        instance.saveRow();

        ok(!wasCalled);
    });

    test("save event doesn't trigger if validation fails", function() {
        var wasCalled = false;
        var ds = new TreeListDataSource({
            data: [
                { id: 1, text: "foo", parentId: null },
                { id: 2, text: "bar", parentId: 1 }
            ],
            schema: {
                model: {
                    fields: {
                        text: { validation: { required: true } }
                    }
                }
            }
        });

        createTreeList({
            dataSource: ds,
            columns: [ "id", "text" ],
            save: function() {
                wasCalled = true;
            }
        });

        instance.editRow("tr:first");
        instance.content.find("tr:first input").val("");
        instance.saveRow();

        ok(!wasCalled);
    });

    test("sync is not called if save event is prevented", function() {
        var ds = new TreeListDataSource({
            data: [
                { id: 1, text: "foo", parentId: null },
                { id: 2, text: "bar", parentId: 1 }
            ]
        });

        var syncSpy = spy(ds, "sync");

        createTreeList({
            dataSource: ds,
            columns: [ "id", "text" ],
            save: function(e) {
                e.preventDefault();
            }
        });

        instance.editRow("tr:first");
        instance.saveRow();

        equal(syncSpy.calls("sync"), 0);
    });

    test("removeRow hides target row", function() {
        createTreeList();

        var row = instance.content.find("tr:first");
        instance.removeRow(row);

        ok(!row.is(":visible"));
    });

    test("removeRow row model from data source", function() {
        createTreeList();

        var row = instance.content.find("tr:first");
        instance.removeRow(row);

        ok(!instance.dataSource.get(1));
    });

    test("removeRow calls sync method of the data source", function() {
        var ds = new TreeListDataSource({
            data: [
                { id: 1, text: "foo", parentId: null },
                { id: 2, text: "bar", parentId: 1 }
            ]
        });

        var syncSpy = spy(ds, "sync");

        createTreeList({
            dataSource: ds
        });

        var row = instance.content.find("tr:first");
        instance.removeRow(row);

        equal(syncSpy.calls("sync"), 1);
    });

    test("removeRow trigger remove event", 2, function() {
        var ds = new TreeListDataSource({
            data: [
                { id: 1, text: "foo", parentId: null },
                { id: 2, text: "bar", parentId: 1 }
            ]
        });

        createTreeList({
            dataSource: ds,
            remove: function(e) {
                equal(e.model, model);
                equal(e.row[0], row[0]);
            }
        });

        var row = instance.content.find("tr:first");
        var model = instance.dataItem(row);
        instance.removeRow(row);
    });

    test("preventing remove event", function() {
        var ds = new TreeListDataSource({
            data: [
                { id: 1, text: "foo", parentId: null },
                { id: 2, text: "bar", parentId: 1 }
            ]
        });

        var syncSpy = spy(ds, "sync");

        createTreeList({
            dataSource: ds,
            columns: [ "id", "text" ],
            remove: function(e) {
                e.preventDefault();
            }
        });

        var row = instance.content.find("tr:first");
        instance.removeRow(row);

        equal(syncSpy.calls("sync"), 0);
        ok(row.is(":visible"));
        ok(instance.dataSource.get(1));
    });

    test("removeRow cancels edited item", function() {
        createTreeList();

        instance.editRow(instance.content.find("tr:first"));
        instance.removeRow(instance.content.find("tr:last"));

        ok(!instance.content.find("tr:first").data("kendoEditable"));
        ok(!instance.editable);
    });
})();

package priori.bootstrap;

import priori.bootstrap.type.PriBSContextualType;
import priori.view.component.PriExtendable;
import priori.event.PriEvent;
import jQuery.Event;
import jQuery.JQuery;

class PriBSNavTab extends PriExtendable {

    @:isVar public var data(default, set):Array<Dynamic>;
    @:isVar public var labelField(default, set):String;
    @:isVar public var selected(get, set):Dynamic;
    @:isVar public var justified(default, set):Bool;

    private var _selectedData:Dynamic;
    private var _menuItens:Array<{label:String, data:Dynamic, view:JQuery}>;

    public function new() {
        super();

        this._menuItens = [];

        this.clipping = false;
        this.labelField = "label";
        this.justified = false;

        this.updateNavTabData();
    }

    override private function getComponentCode():String {
        return "<ul class=\"nav nav-tabs\" />";
    }

    override private function onAddedToApp():Void {
        this.registerClicks();
    }

    override private function onRemovedFromApp():Void {
        this.unregisterClicks();
    }

    private function registerClicks():Void {
        this.unregisterClicks();

        var i:Int = 0;
        var n:Int = this._menuItens.length;

        while (i < n) {
            this._menuItens[i].view.on("click", i, this._onItemClick);

            i++;
        }
    }

    private function unregisterClicks():Void {
        this._baseElement.find("li").off();
    }

    @:noCompletion private function set_data(value:Array<Dynamic>):Array<Dynamic> {
        this.data = value;

        if (
            (this._selectedData == null && value != null && value.length > 0) ||
            (value != null && value.length > 0 && this.data.indexOf(this._selectedData) == -1)
        ) {
            this._selectedData = data[0];
        }

        this.updateNavTabData();

        return value;
    }

    @:noCompletion private function set_justified(value:Bool):Bool {
        this.justified = value;

        if (value) {
            this._baseElement.addClass("nav-justified");
        } else {
            this._baseElement.removeClass("nav-justified");
        }

        return value;
    }

    @:noCompletion private function set_labelField(value:String) {
        this.labelField = value;

        this.updateNavTabData();

        return value;
    }

    @:noCompletion private function get_selected():Dynamic {
        return _selectedData;
    }

    @:noCompletion private function set_selected(value:Dynamic) {
        this._selectedData = value;

        this.updateNavTabView();

        return this.selected = value;
    }

    private function updateNavTabView():Void {
        if (this._selectedData != null) {
            var i:Int = 0;
            var n:Int = this._menuItens.length;

            while (i < n) {

                if (this._selectedData == this._menuItens[i].data) {
                    this._menuItens[i].view.addClass("active");
                } else {
                    this._menuItens[i].view.removeClass("active");
                }

                i++;
            }

        }
    }

    private function getLabelForData(data:Dynamic):String {
        var result:String = "";

        if (this.labelField != null && this.labelField != "") {
            var val:Dynamic = Reflect.getProperty(data, this.labelField);

            if (val == null) {
                result = Std.string(data);
            } else {
                result = Std.string(val);
            }
        } else {
            result = Std.string(data);
        }

        return result;
    }

    private function updateNavTabData():Void {
        this.clearNavTab();

        if (this.data != null) {

            var i:Int = 0;
            var n:Int = this.data.length;

            var item_label:String = null;
            var item_data:Dynamic = null;


            while (i < n) {

                item_data = this.data[i];

                if (item_data != null) {

                    item_label = this.getLabelForData(item_data);

                    this._menuItens.push({
                        label : item_label,
                        data : item_data,
                        view : new JQuery('<li role="presentation"><a href="#">$item_label</a></li>')
                    });

                    this._baseElement.append(this._menuItens[i].view);
                }

                item_data = null;
                item_label = null;

                i++;
            }
        }

        this.registerClicks();
        this.updateNavTabView();
    }

    private function _onItemClick(e:Event):Void {
        var index:Int = cast(e.data, Int);

        if (index == null) index = 0;
        if (index < 0) index = 0;
        if (index >= this._menuItens.length) this._menuItens.length;
        if (this._menuItens == null || this._menuItens.length == 0) index = -1;

        if (index > -1) {
            if (this._selectedData != this._menuItens[index].data) {
                this._selectedData = this._menuItens[index].data;

                this.updateNavTabView();

                this.dispatchEvent(new PriEvent(PriEvent.CHANGE));
            }
        }
    }

    private function clearNavTab():Void {
        this.unregisterClicks();
        this._baseElement.find("li").remove();
        this._menuItens = [];
    }

}

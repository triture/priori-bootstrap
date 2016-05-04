package priori.bootstrap;

import priori.view.component.PriExtendable;
import priori.bootstrap.type.PriBSIconType;

class PriBSIcon extends PriExtendable {

    @:isVar public var iconColor(default, set):Int;
    @:isVar public var iconSize(default, set):Int;
    @:isVar public var icon(default, set):String;

    public function new() {
        super();

        this.iconColor = 0x000000;
        this.iconSize = 20;
        this.icon = PriBSIconType.ASTERISK;
    }

    override private function getComponentCode():String {
        return "<div aria-hidden=\"true\"></div>";
    }

    @:noCompletion private function set_iconColor(value:Int) {
        this.iconColor = value;
        this._baseElement.css("color", "#" + StringTools.hex(value, 6));
        return value;
    }

    @:noCompletion private function set_iconSize(value:Int) {
        this.iconSize = value;
        this._baseElement.css("font-size", value);
        return value;
    }

    @:noCompletion private function set_icon(value:String) {
        this.icon = value;

        this._baseElement.removeClass();
        this._baseElement.addClass("glyphicon");
        this._baseElement.addClass(value);

        return value;
    }
}

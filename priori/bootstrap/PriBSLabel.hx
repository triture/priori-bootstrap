package priori.bootstrap;

import priori.view.component.PriExtendable;
import priori.bootstrap.type.PriBSContextualType;

class PriBSLabel extends PriExtendable {

    @:isVar public var text(default, set):String;
    @:isVar public var context(default, set):PriBSContextualType;

    public function new() {
        super();

        this.text = "Label";
        this.context = PriBSContextualType.DEFAULT;
    }

    override private function getComponentCode():String {
        return "<span class=\"label\" />";
    }

    @:noCompletion private function set_text(value:String) {
        this.text = value;

        this._baseElement.text(value);

        return value;
    }

    @:noCompletion private function set_context(value:PriBSContextualType) {
        this._baseElement.removeClass("label-danger label-default label-info label-link label-primary label-success label-warning");

        if (value == PriBSContextualType.DANGER) {
            this._baseElement.addClass("label-danger");
        } else if (value == PriBSContextualType.DEFAULT) {
            this._baseElement.addClass("label-default");
        } else if (value == PriBSContextualType.INFO) {
            this._baseElement.addClass("label-info");
        } else if (value == PriBSContextualType.LINK) {
            this._baseElement.addClass("label-link");
        } else if (value == PriBSContextualType.PRIMARY) {
            this._baseElement.addClass("label-primary");
        } else if (value == PriBSContextualType.SUCCESS) {
            this._baseElement.addClass("label-success");
        } else if (value == PriBSContextualType.WARNING) {
            this._baseElement.addClass("label-warning");
        }

        return this.context = value;
    }
}

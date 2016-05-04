package priori.bootstrap;

import priori.bootstrap.type.PriBSSize;
import priori.bootstrap.type.PriBSContextualType;
import priori.view.form.PriFormSelect;

class PriBSFormSelect extends PriFormSelect {

    @:isVar public var size(default, set):PriBSSize;
    @:isVar public var context(default, set):PriBSContextualType;

    public function new() {
        super();

        this.clipping = false;
        this.context = PriBSContextualType.DEFAULT;
    }

    override public function getComponentCode():String {
        return "<select class=\"form-control\" ></select>";
    }

    @:noCompletion private function set_context(value:PriBSContextualType) {

        this._baseElement.removeClass("btn-danger btn-default btn-info btn-link btn-primary btn-success btn-warning");

        if (value == PriBSContextualType.DANGER) {
            this._baseElement.addClass("btn-danger");
        } else if (value == PriBSContextualType.DEFAULT) {
            this._baseElement.addClass("btn-default");
        } else if (value == PriBSContextualType.INFO) {
            this._baseElement.addClass("btn-info");
        } else if (value == PriBSContextualType.LINK) {
            this._baseElement.addClass("btn-link");
        } else if (value == PriBSContextualType.PRIMARY) {
            this._baseElement.addClass("btn-primary");
        } else if (value == PriBSContextualType.SUCCESS) {
            this._baseElement.addClass("btn-success");
        } else if (value == PriBSContextualType.WARNING) {
            this._baseElement.addClass("btn-warning");
        }

        return this.context = value;
    }

    @:noCompletion private function set_size(value:PriBSSize) {

        this._baseElement.removeClass("input-lg input-sm input-xs");

        if (value == PriBSSize.LARGE) {
            this._baseElement.addClass("input-lg");
        } else if (value == PriBSSize.SMALL) {
            this._baseElement.addClass("input-sm");
        } else if (value == PriBSSize.EXTRA_SMALL) {
            this._baseElement.addClass("input-sm");
        }

        return this.size = value;
    }
}

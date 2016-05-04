package priori.bootstrap;

import priori.bootstrap.type.PriBSSize;
import priori.bootstrap.type.PriBSContextualType;
import priori.view.form.PriFormButton;

class PriBSFormButton extends PriFormButton {

    @:isVar public var context(default, set):PriBSContextualType;
    @:isVar public var size(default, set):PriBSSize;
    @:isVar public var badge(default, set):String;


    public function new() {
        super();

        this.size = PriBSSize.NORMAL;
        this.context = PriBSContextualType.DEFAULT;

        this.badge = "";
    }

    override private function getComponentCode():String {
        return "
           <button type=\"button\" class=\"btn\">
                <span class=\"bs_button_label\"></span>
                <span class=\"badge\">10</span>
            </button>
        ";
    }

    @:noCompletion override private function set_text(value:String) {
        this.text = value;

        this._baseElement.find(".bs_button_label").text(value);

        return value;
    }

    @:noCompletion private function set_badge(value:String) {
        this.badge = value;

        this._baseElement.find(".badge").text(value);

        return value;
    }

    @:noCompletion private function set_context(value:PriBSContextualType):PriBSContextualType {


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

    @:noCompletion private function set_size(value:PriBSSize):PriBSSize {

        this._baseElement.removeClass("btn-lg btn-sm btn-xs");

        if (value == PriBSSize.LARGE) {
            this._baseElement.addClass("btn-lg");
        } else if (value == PriBSSize.SMALL) {
            this._baseElement.addClass("btn-sm");
        } else if (value == PriBSSize.EXTRA_SMALL) {
            this._baseElement.addClass("btn-xs");
        }

        return this.size = value;
    }
}

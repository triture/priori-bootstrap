package priori.bootstrap;

import priori.view.form.PriFormInputText;

class PriBSFormInputText extends PriFormInputText {

    public function new() {
        super();

        this.clipping = false;
    }

    override public function getComponentCode():String {
        return "<input class=\"form-control\" type=\"text\">";
    }
}

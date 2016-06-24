package priori.bootstrap;

import priori.view.form.PriFormTextArea;

class PriBSFormTextArea extends PriFormTextArea {

    public function new() {
        super();

        this.clipping = false;
    }

    override public function getComponentCode():String {
        return "<textarea class=\"form-control\" style=\"overflow:auto;width:100%;height:100%;resize:none;\"></textarea>";
    }
}

package priori.bootstrap;

import priori.style.font.PriFontStyle;
import priori.view.form.PriFormLabel;

class PriBSFormLabel extends PriFormLabel {

    public function new() {
        super();

        this.fontStyle = new PriFontStyle(0x333333, "");
        this.fontSize = 14;

        this._baseElement.css("margin-bottom", "0px");
    }
}

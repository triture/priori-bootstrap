package priori.bootstrap.grid;

import priori.view.grid.cell.PriGridCellRenderer;
import priori.event.PriEvent;

class PriBSCellRendererInputText extends PriGridCellRenderer {

    private var field:PriBSFormInputText;

    public function new() {
        super();
    }

    override public function update():Void {
        if (this.canPaint()) {
            this.field.value = this.value;
        }
    }

    override public function setup():Void {
        this.field = new PriBSFormInputText();
        this.field.addEventListener(PriEvent.CHANGE, onFieldChange);
        this.field.value = this.value;

        this.addChild(this.field);
    }

    override public function paint():Void {
        var space:Float = 10;

        this.field.x = space;
        this.field.centerY = this.height/2;
        this.field.width = this.width - space*2;
    }

    private function onFieldChange(e:PriEvent):Void {
        if (Std.is(this.value, Float)) {
            Reflect.setProperty(this.data, this.dataField, Std.parseFloat(this.field.value));
        } else if (Std.is(this.value, Int)) {
            Reflect.setProperty(this.data, this.dataField, Std.parseInt(this.field.value));
        } else {
            Reflect.setProperty(this.data, this.dataField, this.field.value);
        }
    }
}

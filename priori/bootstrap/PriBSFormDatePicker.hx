package priori.bootstrap;

import js.jquery.Event;
import js.jquery.JQuery;
import priori.view.form.PriFormElementBase;
import priori.event.PriEvent;

class PriBSFormDatePicker extends PriFormElementBase {

    @:isVar public var value(get, set):Date;

    private var _dateValue:Date;
    private var _dispatchChange:Bool = true;

    private var binderElement:JQuery;

    public function new(dateFormat:String = "mm/dd/yyyy", calendarWeeks:Bool = false) {
        super();

        this._dateValue = this.removeTime(Date.now());


        this.binderElement = new JQuery("<div>", {
            style : "position:absolute;width:inherit;height:10px;z-index:3000;background-color:#ff0000"
        });
        var binderInside = new JQuery("<div>", {
            style : "position:relative;left:-80%;width:1px;height:1px;"
        });

        this.binderElement.append(binderInside);

        (cast this._baseElement).datepicker({
                weekStart: 1,
                todayBtn: "linked",
                calendarWeeks: calendarWeeks,
                autoclose: true,
                format: dateFormat,
                disableTouchKeyboard : true
            }
        );

        this.value = this._dateValue;

        this.width = 200;
        this.height = null;

        this.clipping = false;
    }

    override private function applyIdToFormElement():Void {
        this._fieldId = "field_" + this.getRandomId(4);
        this._baseElement.find("input").attr("id", this.fieldId);
    }

    override public function getComponentCode():String {
        return "
            <div class=\"input-group date\">
                <input type=\"text\" class=\"form-control\">
                <span class=\"input-group-addon\">
                    <i class=\"glyphicon glyphicon-calendar\"></i>
                </span>
            </div>";
    }

    override private function onAddedToApp():Void {
        (cast this._baseElement).datepicker().on("changeDate", _onChange);
        (cast this._baseElement).datepicker().on("clearDate", _onClear);
    }

    override private function onRemovedFromApp():Void {
        (cast this._baseElement).datepicker().off("changeDate", _onChange);
        (cast this._baseElement).datepicker().off("clearDate", _onClear);
    }

    private function removeTime(value:Date):Date {
        return new Date(value.getFullYear(), value.getMonth(), value.getDate(), 0, 0, 0);
    }

    public function hide():Void {
        (cast this._baseElement).datepicker("hide");
    }

    private function _onClear(event:Event):Void {
        if ((cast this._baseElement).datepicker("getDate") == null) {
            this.value = this._dateValue;
        }
    }

    @:noCompletion private function _onChange(event:Event):Void {
        if ((cast this._baseElement).datepicker("getDate") == null) {
            this.value = this._dateValue;
        } else {
            this._dateValue = this.value;
            if (_dispatchChange) {
                this.dispatchEvent(new PriEvent(PriEvent.CHANGE));
            }
        }
    }

    @:noCompletion private function set_value(value:Date):Date {
        this._dateValue = value;

        this._dispatchChange = false;
        (cast this._baseElement).datepicker("setDate", value);
        this._dispatchChange = true;

        return value;
    }

    @:noCompletion private function get_value():Date {
        var result:Date = this._dateValue;

        result = (cast this._baseElement).datepicker("getDate");

        return result;
    }

    public function getMysqlDate():String {
        return this.getDateFormat("%Y-%m-%d");
    }

    public function getMysqlDateTime():String {
        return this.getDateFormat("%Y-%m-%d %H:%M:%S");
    }

    private function getDateFormat(format:String):String {
        // http://www.cplusplus.com/reference/ctime/strftime/

        var result:String = "";
        var val:Dynamic = this.value;

        result = DateTools.format(val, format);

        return result;
    }

    override public function kill():Void {
        if (this._baseElement != null) {
            (cast this._baseElement).datepicker("remove");
            this._baseElement.off();
        }

        super.kill();
    }
}
package priori.bootstrap.container;

import priori.style.border.BorderStyle;
import priori.view.PriDisplay;
import priori.event.PriEvent;
import priori.view.container.PriContainer;
import priori.view.container.PriGroup;

class PriBSTabPanel extends PriGroup {

    private var tabs:PriBSNavTab;
    private var container:PriContainer;
    private var content:PriGroup;

    private var tabItens:Array<{title:String, content:Class<PriGroup>, instance:PriGroup, args:Array<Dynamic>}>;

    @:isVar public var keepInstanceState(default, set):Bool;
    @:isVar public var justified(default, set):Bool;

    public function new() {
        super();

        this.tabItens = [];
        this.keepInstanceState = false;
        this.justified = true;
    }

    private function set_justified(value:Bool) {
        this.justified = value;

        if (this.tabs != null) this.tabs.justified = value;

        return value;
    }

    private function set_keepInstanceState(value:Bool) {
        this.keepInstanceState = value;

        if (value == false) {
            var i:Int = 0;
            var n:Int = this.tabItens.length;

            while (i < n) {

                if (this.tabItens[i].instance != null && this.tabItens[i].instance != this.content) {
                    this.tabItens[i].instance.kill();
                    this.tabItens[i].instance = null;
                }

                i++;
            }
        }

        return value;
    }


    public function addTab(title:String, content:Class<PriGroup>, ?args:Array<Dynamic>):Void {
        if (args == null) args = [];

        this.tabItens.push({
            title : title,
            content : content,
            instance : null,
            args : args
        });

        if (this.tabs != null) {
            this.tabs.data = this.tabItens;

            this.invalidate();
            this.validate();
        }
    }

    override public function addChild(view:PriDisplay):Void {
        trace("Do Not use addChild. Use addTab() instead.");
    }

    override public function removeChild(view:PriDisplay):Void {

    }

    override private function setup():Void {
        this.tabs = new PriBSNavTab();
        this.tabs.data = this.tabItens;
        this.tabs.labelField = "title";
        this.tabs.justified = this.justified;
        this.tabs.addEventListener(PriEvent.CHANGE, onTabChange);
        super.addChild(this.tabs);

        this.container = new PriContainer();
        this.container.border = new BorderStyle();
        super.addChild(this.container);

        if (this.tabs.selected != null) {
            // open first item
            this.onTabChange(null);
        }
    }

    override private function paint():Void {
        this.tabs.x = 0;
        this.tabs.y = 0;
        this.tabs.width = this.width;

        this.container.x = 0;
        this.container.y = this.tabs.maxY;
        this.container.width = this.width;
        this.container.height = this.height - this.container.y;

        if (this.content != null) {
            this.content.x = 0;
            this.content.y = 0;
            this.content.width = this.container.width;
            this.content.height = this.container.height;
            this.content.validate();
        }
    }

    private function onTabChange(e:PriEvent):Void {
        var selectedItem:Dynamic = this.tabs.selected;

        if (this.content != null) {
            this.container.removeChild(this.content);

            if (!this.keepInstanceState) {
                this.content.kill();
            }

            this.content = null;
        }

        if (selectedItem != null) {
            if (this.keepInstanceState && selectedItem.instance != null) {
                this.content = selectedItem.instance;
            } else {
                var contentClass:Class<PriGroup> = selectedItem.content;
                this.content = Type.createInstance(contentClass, selectedItem.args);
                if (this.keepInstanceState) selectedItem.instance = this.content;
            }

            this.container.addChild(this.content);

            this.invalidate();
            this.validate();
        }
    }

    override public function kill():Void {
        var i:Int = 0;
        var n:Int = this.tabItens.length;

        while (i < n) {
            if (this.tabItens[i].instance != null) {
                this.tabItens[i].instance.kill();
            }

            i++;
        }

        super.kill();
    }
}

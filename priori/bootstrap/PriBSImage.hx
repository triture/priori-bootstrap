package priori.bootstrap;

import priori.view.PriImage;
import priori.bootstrap.type.PriBSImageStyle;
import priori.assets.AssetImage;

class PriBSImage extends PriImage {

    @:isVar public var imageStyle(default, set):PriBSImageStyle;
    @:isVar public var info(default, set):String;

    public function new(assetId:String = null) {
        super(assetId);

        this.imageStyle = PriBSImageStyle.NONE;
        this.info = "";
        this.clipping = true;
    }

    private function updateStyle():Void {
        if (this._imageElement != null) {
            this._imageElement.removeClass("img-rounded img-circle img-thumbnail");

            if (this.imageStyle == PriBSImageStyle.ROUNDED) {
                this._imageElement.addClass("img-rounded");
            } else if (this.imageStyle == PriBSImageStyle.CIRCLE) {
                this._imageElement.addClass("img-circle");
            } if (this.imageStyle == PriBSImageStyle.THUMBNAIL) {
                this._imageElement.addClass("img-thumbnail");
            }
        }
    }

    private function updateInfo():Void {
        if (this._imageElement != null) {
            this._imageElement.attr("alt", this.info);
        }
    }

    @:noCompletion private function set_imageStyle(value:PriBSImageStyle):PriBSImageStyle {
        this.imageStyle = value;
        this.updateStyle();
        return value;
    }

    @:noCompletion private function set_info(value:String) {
        this.info = value;
        this.updateInfo();
        return value;
    }

    override public function loadByAsset(asset:AssetImage):Void {
        super.loadByAsset(asset);

        if (this._imageElement != null) {
            this.updateInfo();
            this.updateStyle();
        }
    }

}

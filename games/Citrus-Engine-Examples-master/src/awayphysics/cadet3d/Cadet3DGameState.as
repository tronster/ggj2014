package awayphysics.cadet3d {

	import away3d.controllers.HoverController;

	import citrus.core.away3d.Away3DCitrusEngine;
	import citrus.core.away3d.Away3DState;
	import citrus.physics.awayphysics.AwayPhysics;
	import citrus.utils.objectmakers.ObjectMaker3D;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;

	/**
	 * @author Aymeric
	 */
	public class Cadet3DGameState extends Away3DState {
		
		[Embed(source="/../embed/3D/simpletest.away3d4", mimeType="application/octet-stream")]
		private const _CADET_LEVEL:Class;
		
		// navigation variables
		private var _cameraController:HoverController;

		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		private var _lookAtPosition:Vector3D = new Vector3D();

		public function Cadet3DGameState() {
			super();
		}

		override public function initialize():void {
			
			super.initialize();
			
			var awayPhysics:AwayPhysics = new AwayPhysics("awayPhysics");
			awayPhysics.visible = true;
			add(awayPhysics);
			
			ObjectMaker3D.FromCadetEditor3D(XML(new _CADET_LEVEL()));
			
			_cameraController = new HoverController((_ce as Away3DCitrusEngine).away3D.camera, null, 175, 20, 1000);
			
			_ce.stage.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			_ce.stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_ce.stage.addEventListener(Event.MOUSE_LEAVE, _onMouseUp);
			_ce.stage.addEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel);
		}
		
		override public function destroy():void {

			_ce.stage.removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			_ce.stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_ce.stage.removeEventListener(Event.MOUSE_LEAVE, _onMouseUp);
			_ce.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel);

			super.destroy();
		}
		
		override public function update(timeDelta:Number):void {

			super.update(timeDelta);

			if (_move) {
				_cameraController.panAngle = 0.3 * (_ce.stage.mouseX - _lastMouseX) + _lastPanAngle;
				_cameraController.tiltAngle = 0.3 * (_ce.stage.mouseY - _lastMouseY) + _lastTiltAngle;
			}

			_cameraController.lookAtPosition = _lookAtPosition;
		}
		
		private function _onMouseDown(mEvt:MouseEvent):void {
			_lastPanAngle = _cameraController.panAngle;
			_lastTiltAngle = _cameraController.tiltAngle;
			_lastMouseX = _ce.stage.mouseX;
			_lastMouseY = _ce.stage.mouseY;
			_move = true;
		}

		private function _onMouseUp(evt:Event):void {
			_move = false;
		}

		private function _onMouseWheel(mEvt:MouseEvent):void {

			_cameraController.distance -= mEvt.delta * 5;

			if (_cameraController.distance < 100)
				_cameraController.distance = 100;
			else if (_cameraController.distance > 2000)
				_cameraController.distance = 2000;
		}

	}
}

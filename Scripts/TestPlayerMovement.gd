extends Node


export var Velocity: Vector2 = Vector2(12,2)
#export FrameInput Input { get; private set; }
#export bool JumpingThisFrame { get; private set; }
#export bool LandingThisFrame { get; private set; }
#export Vector3 RawMovement { get; private set; }
#export bool Grounded => _colDown;

#export Vector3 _lastPosition;
#export float _currentHorizontalSpeed, _currentVerticalSpeed;

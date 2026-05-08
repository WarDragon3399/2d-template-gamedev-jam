using Godot;
using System;

public partial class Joystick : Control
{
    [Export] public float MaxRadius = 60.0f;

    private Control _base;
    private Control _knob;
    private int _touchIndex = -1;
    private Vector2 _center = Vector2.Zero;

    public Vector2 InputVector { get; private set; } = Vector2.Zero;

    public override void _Ready()
    {
        _base = GetNode<Control>("Base");
        _knob = GetNode<Control>("Base/Knob");

        _base.Visible = false;
        _center = _base.Size / 2;
        _knob.PivotOffset = _knob.Size / 2;
        ResetKnob();
    }

    public override void _Input(InputEvent @event)
    {
        if (@event is InputEventScreenTouch touchEvent)
        {
            // Left side restriction
            if (touchEvent.Position.X > GetViewportRect().Size.X * 0.5f) return;

            if (touchEvent.Pressed && _touchIndex == -1)
            {
                _touchIndex = touchEvent.Index;
                _base.GlobalPosition = touchEvent.Position - _center;
                _base.Visible = true;
                MoveKnob(touchEvent.Position);
            }
            else if (!touchEvent.Pressed && touchEvent.Index == _touchIndex)
            {
                _touchIndex = -1;
                InputVector = Vector2.Zero;
                _base.Visible = false;
                ResetKnob();
            }
        }
        else if (@event is InputEventScreenDrag dragEvent)
        {
            if (dragEvent.Index == _touchIndex)
            {
                MoveKnob(dragEvent.Position);
            }
        }
    }

    private void MoveKnob(Vector2 screenPos)
    {
        Vector2 localPos = screenPos - _base.GlobalPosition;
        Vector2 offset = localPos - _center;

        if (offset.Length() > MaxRadius)
        {
            offset = offset.Normalized() * MaxRadius;
        }

        _knob.Position = _center + offset - (_knob.Size / 2);
        InputVector = offset / MaxRadius;
    }

    private void ResetKnob()
    {
        _knob.Position = _center - (_knob.Size / 2);
    }
}

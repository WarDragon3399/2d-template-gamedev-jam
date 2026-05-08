using Godot;
using System;

public partial class Player : CharacterBody2D
{
    [Export] public float Speed = 300.0f;

    private Joystick _joystick;

    public override void _Ready()
    {
        // Using the same search logic as your GDScript
        _joystick = GetTree().Root.FindChild("Joystick", true, false) as Joystick;
    }

    public override void _PhysicsProcess(double delta)
    {
        Vector2 moveDir = Vector2.Zero;

        // 1. Check Joystick (Using C# PascalCase naming)
        if (_joystick != null && _joystick.InputVector != Vector2.Zero)
        {
            moveDir = _joystick.InputVector;
        }
        else
        {
            // 2. Keyboard Fallback
            moveDir = Input.GetVector("Move_Left", "Move_Right", "Move_Up", "Move_Down");
        }

        Velocity = moveDir * Speed;
        MoveAndSlide();
    }
}

// Terminal glass (Flint #1182): a prompt painted on a terminal's glass with
// draw_world_text's `facing`, and a billboard name tag above it.
//
// On a plane every length is in world units: `size` is the em, so 0.024 is
// 24 mm letters. Without `facing` the same argument is points. The camera
// drifts round in game time, so a --frame-step capture follows one path.

// The glass's face: x = 0.262, facing +x; its upper left corner as the
// reader at +x sees it (their left is +z).
let glass_x = 0.262;
let left_z = 0.215;
let top_y = 1.15;

fn on_update() {
    // Swing from square on to a steep angle and back, 1.7 m off
    let a = 0.15 + 0.6 * (total_time() * 0.35).sin();
    set_camera_position(0.2 + 1.7 * a.cos(), 1.12, 1.7 * a.sin());
    set_camera_target(0.2, 1.0, 0.0);
}

fn on_draw_ui() {
    let green = [0.42, 1.0, 0.62, 0.95];
    let dim = [0.2, 0.62, 0.36, 0.9];
    let glow = [0.1, 0.9, 0.4, 0.5, 0.004];
    let lines = [
        ["FLINT  terminal glass", dim],
        ["> draw_world_text(x, y, z, s, 0.024,", green],
        ["      #{ facing: [1, 0, 0] })", green],
        ["  size: the em, in metres", dim],
        ["  read from where facing points", dim],
    ];
    let em = 0.024;
    let step = em * 1.45;
    let x = glass_x + 0.002;
    let y = top_y;
    for l in lines {
        draw_world_text(x, y, left_z, l[0], em, #{
            color: l[1], glow: glow, facing: [1.0, 0.0, 0.0],
            align: "left", valign: "top",
        });
        y -= step;
    }
    // The prompt, its cursor blinking on game time
    let cursor = if (total_time() * 1.6).fraction() < 0.55 { "> _" } else { ">" };
    draw_world_text(x, y - step * 0.5, left_z, cursor, em * 1.3, #{
        color: green, glow: glow, facing: [1.0, 0.0, 0.0],
        align: "left", valign: "top",
    });

    // A name tag: no `facing`, so it faces the screen and 15 is points
    draw_world_text(0.0, 1.42, 0.0, "TERMINAL 01  (billboard, 15 pt)", 15.0, #{
        color: [1.0, 0.9, 0.75, 0.95],
        shadow: [0.0, 0.0, 0.0, 0.8, 1.0, 1.0],
    });
}

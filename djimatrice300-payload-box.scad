$fn = 96;

// ======================================================
// DJI Matrice 300 - two-level payload box
//
// Lower level:
// - lightweight mounting frame
// - four mounting points A, B, C, D
// - two parallel rear rails ending at E, F
// - two rear cross braces
//
// Upper level:
// - solid payload-box floor
// - connected by six vertical posts
// - posts near A, B, C, D are offset to keep screw holes clear
//
// AB = front/head side
// CD = rear/tail side
// ======================================================


// ------------------------------------------------------
// MAIN PARAMETERS
// ------------------------------------------------------

// Export selector:
// - "assembly": full preview with the lid lifted above the box
// - "body": main body only
// - "lid": lid only, flipped for FDM printing with the outer face on the bed
part = "assembly"; // [assembly, body, lid]

// Matrice 300 mounting-hole spacing
hole_spacing_x = 78;
hole_spacing_y = 66;

// Rear extension
tail_length = 115;

// Lower frame
frame_thickness = 2.5;
arm_width = 5;
boss_diameter = 12;

// Total outside width of the two rear rails
tail_outer_width = 71;
tail_end_spacing = tail_outer_width - arm_width;

// Mounting holes
bolt_seat_diameter = 6;
bolt_seat_depth = 3.5;
bottom_hole_diameter = 3;

// Rear cross braces
brace_distance_1 = 40;
brace_distance_2 = 90;
brace_width = arm_width;

// Lower spacers
front_spacer_height = 6;
rear_spacer_height = 2;

spacer_diameter = 9;
tip_diameter = 6;
taper_height = 2;

// Upper payload-box floor
upper_plane_top_z = 26;
upper_plane_thickness = 2.5;
upper_plane_z = upper_plane_top_z - upper_plane_thickness;
upper_plane_width = 86;
upper_plane_x_offset = 0;
upper_plane_rear_extension = arm_width / 2;
support_width = tail_outer_width;

// Box walls
box_wall_height = 25;
box_wall_thickness = 2;

// Cable pass-through on the rear wall
rear_cable_hole_width = 12.5;
rear_cable_hole_height = 7.5;
rear_cable_hole_radius = 2;

// Cable pass-throughs on the left side wall, from B toward E.
side_front_cable_hole_width = rear_cable_hole_width;
side_front_cable_hole_height = rear_cable_hole_height;
side_rear_cable_hole_width = rear_cable_hole_width;
side_rear_cable_hole_height = rear_cable_hole_height;
side_cable_hole_radius = rear_cable_hole_radius;
side_front_cable_hole_from_front = 55;
side_rear_cable_hole_from_rear = 55;

// Lid and screw mounts
lid_thickness = 1.5;
lid_overhang = 1;
lid_lip_height = 4;
lid_lip_thickness = 1.5;
lid_clearance = 0.4;
lid_preview_gap = 25;

lid_screw_diameter = 3;
lid_screw_triangle_leg = 12;
lid_screw_corner_offset = 3;
lid_boss_top_clearance = 0.5;

// Vertical posts
vertical_post_top_z = upper_plane_z + (upper_plane_thickness / 2);
vertical_post_diameter = arm_width;

// Offset between vertical posts and A, B, C, D screw holes
post_offset = 10;

// Small overlap between touching parts. This avoids tangent-only surfaces
// and produces cleaner STL output.
assembly_overlap = 0.2;

// OpenSCAD preview colors
lower_frame_color = "DimGray";
upper_plane_color = "Orange";
box_wall_color = "SteelBlue";
vertical_post_color = "ForestGreen";
spacer_color = "MediumPurple";
lid_color = "LightSlateGray";
lid_boss_color = "DarkCyan";


// ------------------------------------------------------
// MAIN POINTS
// ------------------------------------------------------

// AB = front/head side
A = [ hole_spacing_x / 2,  0];
B = [-hole_spacing_x / 2,  0];

// CD = rear/tail side
D = [ hole_spacing_x / 2, -hole_spacing_y];
C = [-hole_spacing_x / 2, -hole_spacing_y];

// Rear rails start inset from the M300 hole spacing.
tail_inset = (hole_spacing_x - tail_end_spacing) / 2;

C_tail = [C[0] + tail_inset, C[1]];
D_tail = [D[0] - tail_inset, D[1]];

// Rear endpoints
E = [C_tail[0], C_tail[1] - tail_length];
F = [D_tail[0], D_tail[1] - tail_length];

// Upper floor outline and separate lower-support width.
upper_left_x = upper_plane_x_offset - (upper_plane_width / 2);
upper_right_x = upper_plane_x_offset + (upper_plane_width / 2);
support_left_x = upper_plane_x_offset - (support_width / 2);
support_right_x = upper_plane_x_offset + (support_width / 2);

upper_front_left = [upper_left_x, A[1]];
upper_front_right = [upper_right_x, A[1]];
upper_rear_y = E[1] - upper_plane_rear_extension;
upper_rear_left = [upper_left_x, upper_rear_y];
upper_rear_right = [upper_right_x, upper_rear_y];

// Front start points for the two lower rails. They are aligned with the
// vertical posts and extend to the front edge.
left_rail_front = [support_left_x + (arm_width / 2), A[1]];
right_rail_front = [support_right_x - (arm_width / 2), A[1]];


// ------------------------------------------------------
// REAR CROSS-BRACE POINTS
// ------------------------------------------------------

brace_1_left  = [E[0], E[1] + brace_distance_1];
brace_1_right = [F[0], F[1] + brace_distance_1];

brace_2_left  = [E[0], E[1] + brace_distance_2];
brace_2_right = [F[0], F[1] + brace_distance_2];


// ------------------------------------------------------
// SIX VERTICAL-POST POSITIONS
// ------------------------------------------------------

// Near A and B, shifted toward the rear.
A_post = [support_right_x - (vertical_post_diameter / 2), A[1] - post_offset];
B_post = [support_left_x + (vertical_post_diameter / 2), B[1] - post_offset];

// Near C and D, shifted toward the front.
C_post = [support_left_x + (vertical_post_diameter / 2), C[1] + post_offset];
D_post = [support_right_x - (vertical_post_diameter / 2), D[1] + post_offset];

// E and F have no screw holes, so their posts stay aligned with the rear
// rails while remaining under the upper floor footprint.
E_post = [support_left_x + (vertical_post_diameter / 2), E[1]];
F_post = [support_right_x - (vertical_post_diameter / 2), F[1]];


// ------------------------------------------------------
// SMOOTH LINK BETWEEN TWO POINTS
// ------------------------------------------------------

module smooth_link(p1, p2, width, height) {

    hull() {

        translate([p1[0], p1[1], 0])
            cylinder(
                h = height,
                d = width
            );

        translate([p2[0], p2[1], 0])
            cylinder(
                h = height,
                d = width
            );
    }
}


// ------------------------------------------------------
// CIRCULAR BOSS
// ------------------------------------------------------

module boss_at(p, d, h) {

    translate([p[0], p[1], 0])
        cylinder(
            h = h,
            d = d
        );
}


// ------------------------------------------------------
// LOWER FRAME
// ------------------------------------------------------

module lower_frame() {

    difference() {

        union() {

            // Bosses around the four mounting holes
            boss_at(A, boss_diameter, frame_thickness);
            boss_at(B, boss_diameter, frame_thickness);
            boss_at(C, boss_diameter, frame_thickness);
            boss_at(D, boss_diameter, frame_thickness);

            // Front cross member
            smooth_link(
                A,
                B,
                arm_width,
                frame_thickness
            );

            // Side members between front and rear holes
            smooth_link(
                B,
                C,
                arm_width,
                frame_thickness
            );

            smooth_link(
                A,
                D,
                arm_width,
                frame_thickness
            );

            // Short inward transitions
            smooth_link(
                C,
                C_tail,
                arm_width,
                frame_thickness
            );

            smooth_link(
                D,
                D_tail,
                arm_width,
                frame_thickness
            );

            // Front extensions of the rear rails, aligned under the first
            // four vertical posts and carried to the front edge.
            smooth_link(
                left_rail_front,
                C_tail,
                arm_width,
                frame_thickness
            );

            smooth_link(
                right_rail_front,
                D_tail,
                arm_width,
                frame_thickness
            );

            // Parallel rear rails
            smooth_link(
                C_tail,
                E,
                arm_width,
                frame_thickness
            );

            smooth_link(
                D_tail,
                F,
                arm_width,
                frame_thickness
            );

            // First cross brace
            smooth_link(
                brace_1_left,
                brace_1_right,
                brace_width,
                frame_thickness
            );

            // Second cross brace
            smooth_link(
                brace_2_left,
                brace_2_right,
                brace_width,
                frame_thickness
            );
        }

        // Bolt seat at A, B, C, D. The upper portion is Ø6; any remaining
        // seat depth continues into the lower spacers.
        for (p = [A, B, C, D]) {

            translate([
                p[0],
                p[1],
                -0.1
            ])
                cylinder(
                    h = frame_thickness + 0.2,
                    d = bolt_seat_diameter
                );
        }
    }
}


// ------------------------------------------------------
// TAPERED LOWER SPACER
// ------------------------------------------------------

module tapered_spacer(height) {

    actual_taper_height = min(taper_height, height);
    straight_height = max(0, height - actual_taper_height);
    seat_depth_below_frame = max(0, bolt_seat_depth - frame_thickness);
    seat_start_z = max(0, height - assembly_overlap - seat_depth_below_frame);

    difference() {

        union() {

            // Straight cylindrical section
            if (straight_height > 0)
                translate([
                    0,
                    0,
                    actual_taper_height
                ])
                    cylinder(
                        h = straight_height,
                        d = spacer_diameter
                    );

            // Tapered transition
            cylinder(
                h = actual_taper_height,
                d1 = tip_diameter,
                d2 = spacer_diameter
            );
        }

        // Final Ø3 through-hole.
        translate([0, 0, -0.1])
            cylinder(
                h = height + 0.2,
                d = bottom_hole_diameter
            );

        // Continuation of the Ø6 bolt seat inside the spacer.
        if (seat_depth_below_frame > 0)
            translate([0, 0, seat_start_z])
                cylinder(
                    h = height - seat_start_z + 0.1,
                    d = bolt_seat_diameter
            );
    }
}


// ------------------------------------------------------
// SOLID UPPER FLOOR
// ------------------------------------------------------

module upper_solid_plane() {

    translate([0, 0, upper_plane_z])
        linear_extrude(
            height = upper_plane_thickness
        )
            polygon(
                points = [
                    upper_front_left,
                    upper_front_right,
                    upper_rear_right,
                    upper_rear_left
                ]
            );
}


// ------------------------------------------------------
// BOX WALLS
// ------------------------------------------------------

module rounded_rect_2d(width, height, radius) {

    hull() {

        for (x = [
            -width / 2 + radius,
             width / 2 - radius
        ])
            for (y = [
                -height / 2 + radius,
                 height / 2 - radius
            ])
                translate([x, y])
                    circle(r = radius);
    }
}


module box_walls() {

    wall_base_z = upper_plane_z + upper_plane_thickness - assembly_overlap;
    wall_body_height = box_wall_height - upper_plane_thickness + assembly_overlap;

    inner_left_x = upper_left_x + box_wall_thickness;
    inner_right_x = upper_right_x - box_wall_thickness;
    inner_front_y = A[1] - box_wall_thickness;
    inner_rear_y = upper_rear_y + box_wall_thickness;
    rear_cable_hole_y = upper_rear_y + (box_wall_thickness / 2);
    rear_cable_hole_z = upper_plane_z + (box_wall_height / 2);
    side_cable_hole_x = upper_left_x + (box_wall_thickness / 2);
    side_cable_hole_z = upper_plane_z + (box_wall_height / 2);
    side_front_cable_hole_y = A[1] - side_front_cable_hole_from_front;
    side_rear_cable_hole_y = upper_rear_y + side_rear_cable_hole_from_rear;

    difference() {

        translate([0, 0, wall_base_z])
            linear_extrude(
                height = wall_body_height
            )
                difference() {

                    polygon(
                        points = [
                            upper_front_left,
                            upper_front_right,
                            upper_rear_right,
                            upper_rear_left
                        ]
                    );

                    polygon(
                        points = [
                            [inner_left_x, inner_front_y],
                            [inner_right_x, inner_front_y],
                            [inner_right_x, inner_rear_y],
                            [inner_left_x, inner_rear_y]
                        ]
                    );
                }

        translate([0, rear_cable_hole_y, rear_cable_hole_z])
            rotate([90, 0, 0])
                linear_extrude(
                    height = box_wall_thickness + (2 * assembly_overlap),
                    center = true
                )
                    rounded_rect_2d(
                        rear_cable_hole_width,
                        rear_cable_hole_height,
                        rear_cable_hole_radius
                    );

        translate([side_cable_hole_x, side_front_cable_hole_y, side_cable_hole_z])
            rotate([0, 90, 0])
                linear_extrude(
                    height = box_wall_thickness + (2 * assembly_overlap),
                    center = true
                )
                    rounded_rect_2d(
                        side_front_cable_hole_height,
                        side_front_cable_hole_width,
                        side_cable_hole_radius
                    );

        translate([side_cable_hole_x, side_rear_cable_hole_y, side_cable_hole_z])
            rotate([0, 90, 0])
                linear_extrude(
                    height = box_wall_thickness + (2 * assembly_overlap),
                    center = true
                )
                    rounded_rect_2d(
                        side_rear_cable_hole_height,
                        side_rear_cable_hole_width,
                        side_cable_hole_radius
                    );
    }
}


// ------------------------------------------------------
// LID SCREW MOUNTS
// ------------------------------------------------------

function lid_inner_corners() = [
    [
        upper_left_x + box_wall_thickness,
        A[1] - box_wall_thickness
    ],
    [
        upper_right_x - box_wall_thickness,
        A[1] - box_wall_thickness
    ],
    [
        upper_left_x + box_wall_thickness,
        upper_rear_y + box_wall_thickness
    ],
    [
        upper_right_x - box_wall_thickness,
        upper_rear_y + box_wall_thickness
    ]
];


function lid_screw_points() = [
    [
        lid_inner_corners()[0][0] + lid_screw_corner_offset,
        lid_inner_corners()[0][1] - lid_screw_corner_offset
    ],
    [
        lid_inner_corners()[1][0] - lid_screw_corner_offset,
        lid_inner_corners()[1][1] - lid_screw_corner_offset
    ],
    [
        lid_inner_corners()[2][0] + lid_screw_corner_offset,
        lid_inner_corners()[2][1] + lid_screw_corner_offset
    ],
    [
        lid_inner_corners()[3][0] - lid_screw_corner_offset,
        lid_inner_corners()[3][1] + lid_screw_corner_offset
    ]
];


module lid_screw_triangle_at(corner, x_dir, y_dir) {

    wall_base_z = upper_plane_z + upper_plane_thickness - assembly_overlap;
    wall_body_height =
        box_wall_height -
        upper_plane_thickness -
        lid_lip_height -
        lid_boss_top_clearance +
        assembly_overlap;

    difference() {

        translate([0, 0, wall_base_z])
            linear_extrude(height = wall_body_height)
                polygon(
                    points = [
                        corner,
                        [
                            corner[0] + (x_dir * lid_screw_triangle_leg),
                            corner[1]
                        ],
                        [
                            corner[0],
                            corner[1] + (y_dir * lid_screw_triangle_leg)
                        ]
                    ]
                );

        translate([
            corner[0] + (x_dir * lid_screw_corner_offset),
            corner[1] + (y_dir * lid_screw_corner_offset),
            wall_base_z - 0.1
        ])
            cylinder(
                h = wall_body_height + 0.2,
                d = lid_screw_diameter
            );
    }
}


module lid_screw_bosses() {

    corners = lid_inner_corners();

    lid_screw_triangle_at(corners[0],  1, -1);
    lid_screw_triangle_at(corners[1], -1, -1);
    lid_screw_triangle_at(corners[2],  1,  1);
    lid_screw_triangle_at(corners[3], -1,  1);
}


// ------------------------------------------------------
// LID
// ------------------------------------------------------

module lid_plate_2d() {

    polygon(
        points = [
            [
                upper_left_x - lid_overhang,
                A[1] + lid_overhang
            ],
            [
                upper_right_x + lid_overhang,
                A[1] + lid_overhang
            ],
            [
                upper_right_x + lid_overhang,
                upper_rear_y - lid_overhang
            ],
            [
                upper_left_x - lid_overhang,
                upper_rear_y - lid_overhang
            ]
        ]
    );
}


module lid_lip_2d() {

    outer_left_x = upper_left_x + box_wall_thickness + lid_clearance;
    outer_right_x = upper_right_x - box_wall_thickness - lid_clearance;
    outer_front_y = A[1] - box_wall_thickness - lid_clearance;
    outer_rear_y = upper_rear_y + box_wall_thickness + lid_clearance;

    inner_left_x = outer_left_x + lid_lip_thickness;
    inner_right_x = outer_right_x - lid_lip_thickness;
    inner_front_y = outer_front_y - lid_lip_thickness;
    inner_rear_y = outer_rear_y + lid_lip_thickness;

    difference() {

        polygon(
            points = [
                [outer_left_x, outer_front_y],
                [outer_right_x, outer_front_y],
                [outer_right_x, outer_rear_y],
                [outer_left_x, outer_rear_y]
            ]
        );

        polygon(
            points = [
                [inner_left_x, inner_front_y],
                [inner_right_x, inner_front_y],
                [inner_right_x, inner_rear_y],
                [inner_left_x, inner_rear_y]
            ]
        );
    }
}


module lid_screw_holes() {

    for (p = lid_screw_points())
        translate([p[0], p[1], -0.1])
            cylinder(
                h = lid_thickness + 0.2,
                d = lid_screw_diameter
            );
}


module lid_geometry() {

    union() {

        difference() {

            linear_extrude(height = lid_thickness)
                lid_plate_2d();

            lid_screw_holes();
        }

        translate([0, 0, -lid_lip_height])
            linear_extrude(height = lid_lip_height + assembly_overlap)
                lid_lip_2d();
    }
}


module lid_preview() {

    lid_z = upper_plane_z + box_wall_height + lid_preview_gap;

    translate([0, 0, lid_z])
        lid_geometry();
}


module lid_for_printing() {

    // The installed lid has its lip pointing downward. For FDM printing, flip
    // it so the outer flat face sits on the build plate and the lip prints up.
    translate([0, 0, lid_thickness])
        rotate([180, 0, 0])
            lid_geometry();
}


// ------------------------------------------------------
// VERTICAL POST
// ------------------------------------------------------

module vertical_post(p) {

    post_height = vertical_post_top_z - frame_thickness + (2 * assembly_overlap);

    translate([
        p[0],
        p[1],
        frame_thickness - assembly_overlap
    ])
        cylinder(
            h = post_height,
            d = vertical_post_diameter
        );
}


// ------------------------------------------------------
// SIX VERTICAL POSTS
// ------------------------------------------------------

module vertical_posts() {

    for (p = [
        A_post,
        B_post,
        C_post,
        D_post,
        E_post,
        F_post
    ])
        vertical_post(p);
}


// ------------------------------------------------------
// MAIN BODY
// ------------------------------------------------------

module main_body() {

    union() {

        // Lower frame
        color(lower_frame_color)
            lower_frame();

        // Solid upper floor
        color(upper_plane_color)
            upper_solid_plane();

        // Box walls
        color(box_wall_color)
            box_walls();

        // Internal triangular reinforcements for lid screws
        color(lid_boss_color)
            lid_screw_bosses();

        // Six offset vertical posts
        color(vertical_post_color)
            vertical_posts();

        // Front spacers at A and B
        color(spacer_color)
            for (p = [A, B]) {

                translate([
                    p[0],
                    p[1],
                    -front_spacer_height
                ])
                    tapered_spacer(
                        front_spacer_height + assembly_overlap
                    );
            }

        // Rear spacers at C and D
        color(spacer_color)
            for (p = [C, D]) {

                translate([
                    p[0],
                    p[1],
                    -rear_spacer_height
                ])
                    tapered_spacer(
                        rear_spacer_height + assembly_overlap
                    );
            }
    }
}


// ------------------------------------------------------
// FINAL OUTPUT
// ------------------------------------------------------

if (part == "lid") {

    color(lid_color)
        lid_for_printing();

} else if (part == "body") {

    main_body();

} else {

    union() {

        main_body();

        // Lid shown raised in preview
        color(lid_color)
            lid_preview();
    }
}

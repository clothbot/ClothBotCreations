// Shapeways CustomMaker Test

// Material: Frosted Ultra Detail Plastic
function min_bbox_check(x,y,z) = (x+y+z>=12.0)? true:false;
function max_bbox_check(x,y,z) = (x<284 && y<184 && z<203)? true:false;
min_sup_wall_th=0.3;
min_unsup_wall_th=0.6;
min_sup_wire_th=0.6;
min_unsup_wire_th=0.8;

min_emb_h=0.1;
min_eng_depth=0.1;

min_esc_hole_single_d=4.0;
min_esc_hole_multi_d=2.0;

min_clearance=0.05;

interlocking=true;

sw_cm_min_eng_depth=0.1;
sw_cm_min_emb_h=0.1;


// File include tests

include <undefined.scad>;

if( undefined_var==undef) {
    echo("Variable 'undefined_var' is undefined");
}

include <variables.scad>;

if( define_variables_scad ) {
    echo("File variables.scad loaded");
} else {
    echo("File variables.scad not loaded");
}

cube();

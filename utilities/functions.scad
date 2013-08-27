// Useful functions
function quantize(val,grid) = (val-val%grid);

function distance(v1,v2) = sqrt((v2-v1)*(v2-v1));

function norm(vec) = (vec*vec)>0 ? vec*sqrt(vec*vec) : (vec-vec);

function cart2sphere(vec) = (vec*vec)>0 ? [
    sqrt(vec*vec)
    ,acos(vec[2]/sqrt(vec*vec))
    ,atan2(vec[1],vec[0])
    ] : (vec-vec);



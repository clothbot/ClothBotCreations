// Pythagorean Triples

test_module="test pythagorean_triples";

function calc_factors(N) = [ for(i=[1:N]) if(N%i==0) i ];
    
function calc_common_factors(a,b) = [ for(fa=calc_factors(a),fb=calc_factors(b)) if(fa==fb) fa ];
    
function pythagorean_triples(N=10) = [ for (i=[1:N],j=[i:N]) if(len(calc_common_factors(i,j))==1 && sqrt(pow(i,2)+pow(j,2))%1==0) [i,j] ];
    
function pythagorean_triples_angles(N=10) = [ for (pair=pythagorean_triples(N=N)) [ atan2(pair[0],pair[1]),atan2(pair[1],pair[0]) ] ];
    
if(test_module=="test pythagorean_triples") {
    for(pair=pythagorean_triples(N=100)) {
        echo(str("Factors of ",pair[0],": ",calc_factors(pair[0])));
        echo(str("  Factors of ",pair[1],": ",calc_factors(pair[1])));
        echo(str("  Common Factors: ",calc_common_factors(pair[0],pair[1])));
        echo(str("  atan2(",pair[0],",",pair[1],") = ",atan2(pair[0],pair[1])));
        echo(str("  atan2(",pair[1],",",pair[0],") = ",atan2(pair[1],pair[0])));
        echo(str("  ",pair[0],"^2 + ",pair[1],"^2 = ",sqrt(pow(pair[0],2)+pow(pair[1],2)),"^2 = ",pow(pair[0],2)+pow(pair[1],2)));
        translate([0,0,pair[0]]) intersection() {
            hull() {
                rotate([0,0,-90]) cube([1,pair[0],1]);
                translate([pair[0],0,0]) cube([1,pair[1],1]);
            }
            cube([pair[0],pair[1],1]);
        }
    }
}

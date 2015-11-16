// Mathematical operators

function submatrix_skip(A,ri,cj)=[for(i=[0:len(A)-1]) if(i!=ri) [for(j=[0:len(A[i])-1]) if(j!=cj) A[i][j] ] ];

A1=[ [1,0,0,0],[0,2,0,0],[0,0,3,0],[0,0,0,4] ];
echo(A1);
echo(A1+A1);
echo( submatrix_skip(A1,1,2) );

echo("sumv function:");
function sumv(v,i,s=0) = let(ve=v[i]) (i==s ? ve : ve + sumv(v,i-1,s));
echo(sumv([1,2,3,4,5],4,0));
echo(sumv(A1,4,0));

function det_2x2(A) = A[0][0]*A[1][1]-A[0][1]*A[1][0];
function det_nxn(A) = let(A_len=len(A)) (A_len>2)
    ?
        sumv([for(cj=[0:A_len-1]) A[0][cj] * pow(-1,cj) * det_nxn(submatrix_skip(A,0,cj)) ], A_len-1,0)
    :   
        det_2x2(A);
echo( det_nxn([[1,0],[0,1]]) );
echo( det_nxn(A1) );

function trace(A) = (len(A)>1)? A[0][0]+trace( submatrix_skip(A,0,0) ) : A[0][0];

echo( trace(A1) );

function identity(n) = [for(ri=[0:n-1]) [for(cj=[0:n-1]) (ri==cj)?1:0] ];

function powm(A,k) = (k>0)? A*powm(A,k-1) : identity(len(A));

echo(powm(A1,0));
echo(powm(A1,1));
echo(powm(A1,2));

// Characteristic Polynomial construction
function cp_Mk(M,k)=let(M_len=len(M)) (k<1)?M:( cp_Mk(M,k-1) - (1/k) * trace( cp_Mk(M,k-1) ) * identity(M_len) );

function cp_coeffs(M)=[for(k=[0:len(M)]) (k==0)?1:(-1/k)*trace(cp_Mk(M,k-1))];

function inverse_vec(M)= let(coeffs=cp_coeffs(M),M_len=len(M)) [ for(k=[0:M_len-1]) powm(M,M_len-k)*coeffs[k]/(-1)*coeffs[M_len] ];

function inverse(M) = sumv( inverse_vec(M), len(M), 0 );

echo("Characteristic Polynomial construction:");
echo( cp_Mk(A1,0) );
echo( cp_Mk(A1,1) );
echo( cp_coeffs(A1) );
echo( inverse_vec(identity(3)) );
echo( inverse(identity(3)) );

cube();

#!/usr/bin/perl 
G:  *S=sub{goto shift};*T=sub{exit shift};*U=sub{print shift}; 
H:  my $A="";my $C=0;my $D=0;my $E=0;my $F=0;my $G=0;my $H=0;my @I; 
I:  if(!defined($A=$ARGV[0])){U(qw(ARGV[0]?));U("\n");T(1)}$C=length($A);
    U("-$A-\n");$D=0; 
J:  $F=0;$I[$D]=0;if($D!=$C){S(K)}for($G=0;$G<$C;$G++){U(substr($A,$I[$G],1))
    }$H++;U("\t");$H%8||U("\n");S(M); 
K:  $F=$D;if($F!=0){S(N)}$E=$I[0];if($E==$C){U("\n---\n$H\n");T(0)} 
L:  $D++;S(J); 
M:  $D--;$I[$D]++;S(K); 
N:  $F=$I[$D];if($F==$C){S(M)}$E=$D-1; 
O:  if($F==$I[$E]){S(P)}$E--;if($E!=-1){S(O)}S(L); 
P:  $I[$D]++;S(N); 

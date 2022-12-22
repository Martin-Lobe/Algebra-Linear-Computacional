#Ambiente para testa as funcoes criadas
using Random
using BenchmarkTools
using Test
include("funcoes.jl")
n=4
m=4
p=6
A=[2 3 1; -1 0 2]
B = [1 -2; 0 5; 4 1]


MatrixA_exemplo = rand(Int8,n,m)
MatrixB_exemplo = rand(Int8,m,p)
b = productAB(MatrixA_exemplo, MatrixB_exemplo)
b11, b12, b21, b22 = block_matrix(A, 2, 1, 1, 1)

MatrixA_exemplo = UpperTriangular(MatrixA_exemplo)
is_triangular(MatrixA_exemplo)



A = rand(Int8,n,m)
a = [2;2]
b = [1;1;2]
B = block_matrix(A,a,b)
#@benchmark productAx_columns($Matrix_exemplo, $vetor_exemplo)

#conferir se A eh definida positiva ou nao singular, algum desses
function id_def_pos(A::AbstractMatrix)
    #Tentar fazer uma biblioteca para x,y,z pode ser um metodo porem parece muito dificil
    size_matrix, = size(A)

end

#Ambiente para testa as funcoes criadas
using Random
using BenchmarkTools
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
A=[2 0 0 0; -1 2 0 0; 3 1 -1 0; 4 1 -3 3.]
b=[2;3;2;8.]
solve_tsystem_eff!(A,b)
#@benchmark productAx_columns($Matrix_exemplo, $vetor_exemplo)



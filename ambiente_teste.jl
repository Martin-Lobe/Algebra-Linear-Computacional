#Ambiente para testa as funcoes criadas
using Random
using BenchmarkTools
include("funcoes.jl")
n=4
m=8
p=6
A=[2 3 1; -1 0 2]
B = [1 -2; 0 5; 4 1]


MatrixA_exemplo = rand(Int8,n,m)
MatrixB_exemplo = rand(Int8,m,p)
b = productAB(MatrixA_exemplo, MatrixB_exemplo)

MatrixA_exemplo
#@benchmark productAx_columns($Matrix_exemplo, $vetor_exemplo)



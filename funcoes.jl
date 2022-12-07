#Esse arquivo tera funcoes importantes para
using LinearAlgebra

function productAx_columns(A::AbstractMatrix, x::AbstractVector)
    numrows_A, numcols_A = size(A)
    numrows_x = length(x)
    @assert numcols_A == numrows_x "Multiplication is not allowed between matrizes and vectors of these sizes"
    b = zeros(numrows_A)
    for j ∈ 1:numcols_A
        b .+= x[j]*A[:,j]
    end
    return b
end

function productAB(A::AbstractMatrix, B::AbstractMatrix)
    numrows_A, numcols_A = size(A)
    numrows_B, numcols_B = size(B)
    @assert numcols_A == numrows_B "Multiplication is not allowed between matrizes of these sizes"
    C = zeros(numrows_A, numcols_B)
    for i ∈ 1:numrows_A
        for j ∈ 1:numcols_B
            for x ∈ 1:numcols_A
                C[i,j] += A[i,x]*B[x,j]
            end
        end
    end
    return C
end

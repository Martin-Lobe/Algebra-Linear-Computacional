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
            for k ∈ 1:numcols_A
                C[i,j] += A[i,k]*B[k,j]
            end
        end
    end
    return C
end

#Essa funcao vai dividir uma matriz em outras 4, as quais colocadas uma ao lado da outra formam a original
function block_matrix(A::AbstractMatrix, nl::Vector{Int}, nc::Vector{Int})
    numrows_A, numcols_A = size(A)
    @assert (numcols_A == sum(nc) && numrows_A == sum(nl)) "Labels given do not match matrix size"
    #Aqui eu vou criar as matrizes que vao ser retornadas  
    n_matrizes_coluna = length(nc)
    n_matrizes_linha = length(nl)
    Array_Blocks = Array{Any}(undef, n_matrizes_linha, n_matrizes_coluna)
    
    counter_l=1
    for i in 1:n_matrizes_linha
        counter_c=1
        for j in 1:n_matrizes_coluna
            Matriz_Temporaria = @view A[counter_l:counter_l+nl[i]-1, counter_c:counter_c+nc[j]-1]
            Array_Blocks[i,j]=Matriz_Temporaria
            counter_c+=nc[j]
        end
        counter_l+=nl[i]
    end

    return Array_Blocks
 
   
end
#Depois tentar refazer para duas listas de valores
    
#Funcao que verifica se uma matriz é triangular, ela vai conferir tanto para upper ou lower
function is_triangular(A::AbstractMatrix)
    numrows_A, numcols_A = size(A)
    #precisa ser quadrada
    if numrows_A != numcols_A
        return false
    end
    verificacao = [1,1]
    #confere se nao eh lower triangular
    for i ∈ 1:numrows_A
        for j ∈ 1:numcols_A
            if i < j && A[i,j] != 0
                verificacao[1] = 0
            end
        end
    end
    #confere se nao eh upper triangular
    for i ∈ 1:numrows_A
        for j ∈ 1:numcols_A
            if i > j && A[i,j] != 0
                verificacao[2] = 0
            end
        end
    end
    if verificacao==[0,0]
        return false
    else
        return true
    end
end

#funcao para resolver sistema, porem fazendo mais lento
function solve_tsystem!(A::AbstractMatrix, b::AbstractVector)
    @assert is_triangular(A) "Matriz is not triangular"
    numrows_A, = size(A) #colunas nao eh necessario saber pois eh quadrada
    print(numcols_A, length(b))
    @assert numcols_A==length(b) "matriz column amount does not match vector height"
    x = zeros(numrows_A)
    for i in numcols_A
            x[i]=b[i]
            for j in i+1:numcols_A
                x[i]-=A[i,j]*x[j] #nao entendi muito bem essa passagem
            end
    end
    return x
end

#funcao para resolver sistema, porem salvando o resultado no proprio b recebido
function solve_tsystem_eff!(A::AbstractMatrix, b::AbstractVector)
    @assert is_triangular(A) "Matriz is not triangular"
    numrows_A, = size(A)
    @assert numrows_A==length(b) "matriz column amount does not match vector height"
    for i in 1:numrows_A
        if i != 1
            for j in 1:(i-1)
                b[i] -= A[i,j]*b[j]
            end
        end
        b[i] /= A[i,i]#No caso da primeira linha so essa linha acontece
    end
end

#.29 RECURSIVO E NAO RECURSIVO
#Cholesky
#OUTER
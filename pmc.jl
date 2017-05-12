module PMC

#=
int max_clique(long long nedges, int *ei, int *ej, int index_offset, 
                int outsize, int *clique);
=#                

const libpmc = joinpath(dirname(@Base.__FILE__),"libpmc")

function pmc(A::SparseMatrixCSC)
 maxd = Int(maximum(sum(spones(A),1)))
 ei,ej = findnz(tril(A,1))
 
 ei = map(Int32,ei)
 ej = map(Int32,ej)
 
 offset = Cint(1)
 
 outsize = maxd
 output = zeros(Int32,maxd)
 
 clique_size = ccall( 
    (:max_clique, libpmc), Cint,
    (Clonglong, Ptr{Cint}, Ptr{Cint}, Cint, Cint, Ptr{Cint}),
    length(ei), ei, ej, offset, outsize, output)
    
  return map(Int64, output[1:clique_size])
end

end

#@show PMC.pmc(sprandn(10000,10000,10/10000))


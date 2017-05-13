function max_clique = pmc(A)
maxd = int32(full(max(sum(spones(A),1))));
[ei,ej] = find(tril(A,1));
ei = int32(ei);
ej = int32(ej);
loadlibrary('libpmc');
offset = 1;
outsize = maxd;
output = int32(zeros(maxd,1));
eiPtr = libpointer('int32Ptr',ei);
ejPtr = libpointer('int32Ptr',ej);
outputPtr = libpointer('int32Ptr',output);
clique_size = calllib('libpmc','max_clique',size(ei,1),eiPtr,ejPtr,offset,...
                        outsize,outputPtr);
output = get(outputPtr,'Value');
max_clique = output(1:clique_size);
unloadlibrary libpmc;
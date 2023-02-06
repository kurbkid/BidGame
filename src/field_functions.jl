function add_resource(f::Field,a::Vector{Int})
    f.wood += a[1]
    f.metal+= a[2]
    f.coal += a[3]
end

function add_resource(f::Field,i::Int)
    a = zeros(Int,3)
    a[i]=1
    add_resource(f,a)
end

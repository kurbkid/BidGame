function add_resource(f::Field,resources::Vector{String})
    while !isempty(resources)
        push!(f.objects,pop!(resources))
    end
    f
end

function add_resource(f::Field,resource::String)
    push!(f.objects,resource)
    f
end

function prompt_order(equals,modPlayer)

    N = length(equals)
    order = []
    while N>1
        if modPlayer in equals #bot chooses himself first
            choice = findfirst([e==modPlayer for e in equals]) #index of player
        else
            choice = rand(1:N) #index of chosen player
        end
        push!(order,equals[choice])
        deleteat!(equals,choice)
        N-=1
    end
    push!(order,equals[1]) #put the last remaining at the end

    return order
end

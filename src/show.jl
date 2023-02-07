function format_objects_string(objectArray::Vector{String})
    objectSet = Set(objectArray)
    out = ""
    n=1
    for obj in objectSet
        n = count(e->(e==obj),objectArray) #number of times this object appears in objectArray
        if n==1
            out *= obj*", "
        else    
            out *= string( n,"x ", obj,", " )
        end
    end
    out = out[1:end-2]
end


function print_fields()
    global state
    f = state["Fields"]
    s = state["PlayerSupply"]

    numberOfFields = length(f)
    numberOfPlayers = length(s)

    print("\n")
    println("ring 2:   \tring 1:   \tcards and fields:")
    for i=1:numberOfFields
        println("\t \t \t \t card ",i,":  ",format_objects_string(state["OpenCards"][i].effect))
        print(state["Ring2"][i],"\t",state["Ring1"][i],"\t")
        println("field ",i,": ",format_objects_string(state["Fields"][i].objects))
    end
    println()

end


function print_supply(player)
    global state
    println(" player ", player,": ",state["PlayerSupply"][player].worker,"x worker, ",format_objects_string(state["PlayerSupply"][player].objects))
end

function print_all()
    global(params)
    print_fields()
    for player=1:params["numberOfPlayers"]
        print_supply(player)
    end
end
    
function print_fields()
    global state
    f = state["Fields"]
    s = state["PlayerSupply"]

    numberOfFields = length(f)
    numberOfPlayers = length(s)

    print("\n")
    print("       ")
    for i=1:numberOfFields
        print("field ",i,"     ")
    end

    #print resources
    print("\n")
    print("wood:  ")
    for i=1:numberOfFields
        print(f[i].wood,"           ")
    end
    print("\n")
    print("metal: ")
    for i=1:numberOfFields
        print(f[i].metal,"           ")
    end
    print("\n")
    print("coal:  ")
    for i=1:numberOfFields
        print(f[i].coal,"           ")
    end
    print("\n")
    print("obj: ")
    for i=1:numberOfFields
        print(f[i].objects,"  ")
    end
    print("\n")

    #print rings
    println("ring1: ",state["Ring1"])
    println("ring2: ",state["Ring2"])


end

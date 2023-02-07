
function discard_field_cards()
    global params
    global cardDict
    global state
    params["numberOfFields"]
    for field=2:params["numberOfFields"]
        if state["OpenCards"][field] !== cardDict["noCard"]
            push!(state["Discard"],state["OpenCards"][field])
            state["OpenCards"][field] = cardDict["noCard"]
        end
    end
end

function deal_field_cards()
    global params
    global state

    for field=2:params["numberOfFields"]
        if isempty(state["Deck"])
            shuffle_discard_to_deck()
        end
        state["OpenCards"][field] = pop!(state["Deck"])
    end
    state["OpenCards"]
end

function shuffle_discard_to_deck()
    global state
    #make sure deck is emptied into discard
    while !isempty(state["Deck"])
        push!(state["Discard"],pop!(state["Deck"]))
    end
    state["Deck"] = shuffle_stack(state["Discard"])
    state["Discard"] = Stack{Card}()
end

function shuffle_stack(cardStack::Stack{Card})
    cardList = Card[]
    while !isempty(cardStack)
        push!(cardList,pop!(cardStack))
    end
    shuffle!(cardList)
    while !isempty(cardList)
        push!(cardStack,pop!(cardList))
    end
    cardStack
end


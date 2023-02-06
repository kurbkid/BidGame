"""
parses input of form:  "a,b,c,d,e,f,g," with a,b,.. Integers
into Vector [a,b,c,d,..]
"""
function parse_bets(s::String)
    return parse.(Int,split(s,',')) #let's just assume no typos for now and cry later
end

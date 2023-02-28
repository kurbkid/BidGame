function prompt_resource_choice(options,player)
    if "metal" in options
        choice = "metal"
    else
        choice = rand(options)
    end
    choice
end

local rules = professions.construction_rules

local function namespace(node_name)
    return node_name:match("^([^:]+):")
end

local function activity_for(node_name)
    local node_namespace = namespace(node_name)
    if rules.special_nodes[node_name] or rules.special_namespaces[node_namespace] then
        return rules.special_activity
    end

    if rules.basic_namespaces[node_namespace] then
        return rules.basic_activity
    end
    for group_name in pairs(rules.basic_groups) do
        if core.get_item_group(node_name, group_name) > 0 then
            return rules.basic_activity
        end
    end
end

core.register_on_placenode(function(_, newnode, placer)
    if not placer or not placer:is_player() then
        return
    end
    local activity_id = activity_for(newnode.name)
    if activity_id then
        professions.record_activity(placer, activity_id)
    end
end)

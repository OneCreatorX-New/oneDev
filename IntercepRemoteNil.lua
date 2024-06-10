local function intercept(remote)
    print(remote)
    local mt = getrawmetatable(remote)
    local oldNC = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(...)
        return nil
    end)

    setreadonly(mt, true)
end

return intercept

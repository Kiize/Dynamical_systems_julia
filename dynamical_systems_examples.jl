using DynamicalSystems
using GLMakie
using DynamicalSystemsBase

#plotlyjs()  #We define the backend for the plots 

#=
First we want to show the henon map
=#
function henon_rule(u, p, n) 
    #=
    n : time
    u : initial state
    p : parameters
    =#
    x, y = u 
    a, b = p 
    xn = 1. - a*x^2 + y
    yn = b*x    # henon rule
    return SVector(xn, yn)
end

p = [1.4, 0.3]
u0 = [.2, .3]

henon = DiscreteDynamicalSystem(henon_rule, u0, p)
henon_traj = trajectory(henon, 10000)
x, y = columns(henon_traj[1])
scatter(x, y, markersize = 2) 


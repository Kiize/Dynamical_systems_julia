using DynamicalSystems
using GLMakie
using DynamicalSystemsBase

"""
u : initial state
p : parameters
n : time
"""
function henon_rule(u, p, n) 
    x, y = u 
    a, b = p 
    xn = 1. - a*x^2 + y
    yn = b*x
    return SVector(xn, yn)
end

p = [1.4, 0.3]
u0 = [.2, .3]

henon = DiscreteDynamicalSystem(henon_rule, u0, p)
henon_traj = trajectory(henon, 10000)
x, y = columns(henon_traj[1])
scatter(x, y, markersize = 2) 


using DynamicalSystems
using CairoMakie
using DynamicalSystemsBase

#we choose CairoMakie as the backend because of the high resolution of the images

"""
u : initial state
p : parameters
n : time
"""
function Fermi_Ulam_map(x, ϵ, n) 
    u, θ = x
    temp = abs(u + ϵ*sin(θ))

    un = temp
    θn = mod(θ + (2*pi)/temp, 2*pi)

    return SVector(un, θn)
end

ϵ = 0.1
"""
In this case we want to evolve a grid (u0s) of initial condition with the Fermi Ulam map.
"""

#start and stop must be real numbers
start = 1. 
stop = pi
step = 0.1
u0s = [[x, y] for x ∈ start:step:stop for y ∈ start:step:stop]
fig = Figure()
ax = Axis(fig[1, 1])

function fx(u0)
    fu_map = DiscreteDynamicalSystem(Fermi_Ulam_map, u0, ϵ)
    fu_traj = trajectory(fu_map, 1000)
    x, y = columns(fu_traj[1])
    return scatter!(y, x, markersize = 2) #in this way we have the thetas on the x-axis and the us on the y-axis
end

fx.(u0s)

display(fig)
save("Fermi_Ulam_map.pdf", fig)
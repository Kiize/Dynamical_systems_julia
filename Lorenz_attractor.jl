using DynamicalSystems
using GLMakie
using DynamicalSystemsBase

"""
du : derivative of state
u : initial state
p : parameters
t : time
"""
function Lorenz_attractor(du, u, p, t)
    σ, ρ, β = p

    du[1] = σ*(u[2] - u[1])
    du[2] = u[1]*(ρ - u[3]) - u[2]
    du[3] = u[1]*u[2] - β*u[3]
    return nothing
end

p = [10, 28, 8/3]
u0 = [10., 10., 10.]

lorenzatt = ContinuousDynamicalSystem(Lorenz_attractor, u0, p)

traj = trajectory(lorenzatt, 1000.; Δt = 0.01)
x, y, z = columns(traj[1])
fig = lines(x, y, z, color = :deepskyblue)
fig2 = lines(x, z, color = :deepskyblue)
save("lorenzatt.png", fig2)
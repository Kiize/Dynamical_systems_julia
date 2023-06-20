using DynamicalSystems
using GLMakie
using DynamicalSystemsBase

"""
du : derivative of state
u : initial state
p : parameters
t : time
"""
function Lorenz_rule(du, u, F, t)
    N = length(u)

    du[1] = (u[2] - u[N - 1]) * u[N] - u[1] + F
    du[2] = (u[3] - u[N]) * u[1] - u[2] + F
    du[N] = (u[1] - u[N - 2])*u[N - 1] - u[N] + F

    for n in 3:(N - 1) # generic case
        du[n] = (u[n + 1] - u[n - 2]) * u[n - 1] - u[n] + F
    end

    return nothing
end

"""
To see the typical behavior of the Lorenz96 system we set the dimension of the system to 5 and plot the first 3 variables.
The force is then set to 8 because is known to cause chaotic behavior (ref. wikipedia)
"""

#Parameters
F = 8.
N = 5

#Initial state

#u0 = F*ones(N) #another possible state to observe
#u0[1] += 0.01 

u0 = rand(5)

lorenz96 = ContinuousDynamicalSystem(Lorenz_rule, u0, F)

traj = trajectory(lorenz96, 100.; Δt = 0.01)
x, y, z = columns(traj[1])
fig = lines(x, y, z, color = :deepskyblue)
save("lorenz96.png", fig)
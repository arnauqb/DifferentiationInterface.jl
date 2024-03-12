"""
    value_and_pullback!(dx, backend, f, x, dy, [extras]) -> (y, dx)

Compute the primal value `y = f(x)` and the vector-Jacobian product `dx = ∂f(x)' * dy`, overwriting `dx` if possible.

!!! info "Interface requirement"
    This is the only required implementation for a reverse mode backend.
"""
function value_and_pullback!(dx, backend::AbstractADType, f, x, dy, extras=nothing)
    return error(
        "The package for $(typeof(backend)) is not loaded, or the backend does not support this type combination: `typeof(x) = $(typeof(x))` and `typeof(y) = $(typeof(dy))`",
    )
end

"""
    value_and_pullback(backend, f, x, dy, [extras]) -> (y, dx)

Compute the primal value `y = f(x)` and the vector-Jacobian product `dx = ∂f(x)' * dy`.
"""
function value_and_pullback(backend::AbstractADType, f, x, dy, extras=nothing)
    dx = mysimilar(x)
    return value_and_pullback!(dx, backend, f, x, dy, extras)
end

"""
    pullback!(dx, backend, f, x, dy, [extras]) -> dx

Compute the vector-Jacobian product `dx = ∂f(x)' * dy`, overwriting `dx` if possible.
"""
function pullback!(dx, backend::AbstractADType, f, x, dy, extras=nothing)
    return last(value_and_pullback!(dx, backend, f, x, dy, extras))
end

"""
    pullback(backend, f, x, dy, [extras]) -> dx

Compute the vector-Jacobian product `dx = ∂f(x)' * dy`.
"""
function pullback(backend::AbstractADType, f, x, dy, extras=nothing)
    return last(value_and_pullback(backend, f, x, dy, extras))
end
"""
    value_and_derivative(backend, f, x, [extras]) -> (y, der)

Compute the primal value `y = f(x)` and the derivative `der = f'(x)` of a scalar-to-scalar function.
"""
function value_and_derivative(
    backend::AbstractADType,
    f,
    x::Number,
    extras=nothing,
    implem::AbstractImplem=CustomImplem(),
)
    return value_and_derivative(backend, f, x, extras, implem, autodiff_mode(backend))
end

function value_and_derivative(
    backend::AbstractADType, f, x::Number, extras, ::AbstractImplem, ::ForwardMode
)
    return value_and_pushforward(backend, f, x, one(x), extras)
end

function value_and_derivative(
    backend::AbstractADType, f, x::Number, extras, ::AbstractImplem, ::ReverseMode
)
    return value_and_pullback(backend, f, x, one(x), extras)
end

"""
    derivative(backend, f, x, [extras]) -> der

Compute the derivative `der = f'(x)` of a scalar-to-scalar function.
"""
function derivative(backend::AbstractADType, f, x::Number, args...)
    return last(value_and_derivative(backend, f, x, args...))
end
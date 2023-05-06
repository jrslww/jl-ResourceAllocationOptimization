# Import the required libraries
using JuMP
using GLPK

# Create the optimization model
model = Model(GLPK.Optimizer)

# Define the decision variables for the number of units of each product
# Ensure they are non-negative integers
@variable(model, productA >= 0, Int)
@variable(model, productB >= 0, Int)
@variable(model, productC >= 0, Int)

# Define the objective function as the total profit
# Assuming the profits per unit of product A, B, and C are $30, $40, and $50, respectively
@objective(model, Max, 30 * productA + 40 * productB + 50 * productC)

# Add constraints for production capacity, material availability, and labor hours
@constraint(model, productA + productB + productC <= 100) # Production capacity
@constraint(model, 2 * productA + productB + 2 * productC <= 160) # Material availability
@constraint(model, 3 * productA + 2 * productB + productC <= 180) # Labor hours

# Solve the optimization problem
@time 
optimize!(model)

# Print the results: optimal solution and total profit
println("Optimal solution:")
println("Product A: ", value(productA))
println("Product B: ", value(productB))
println("Product C: ", value(productC))
println("Total profit: \$", objective_value(model))

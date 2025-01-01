extends Node

var dynamics_solver_scene = preload("./dynamics_solver.tscn")
var dynamics_solver_vector_scene = preload("./dynamics_solver_vector.tscn")

## Create a one-dimensional [DynamicsSolver] instance that can calculate animations.[br]
## Pass in a [DynamicsResource] for f, z, and r settings for the new solver.
func create_dynamics(dynamics: DynamicsResource) -> DynamicsSolver:
	if not dynamics: return null
	var solver = dynamics_solver_scene.instantiate() as DynamicsSolver
	solver.f = dynamics.f
	solver.z = dynamics.z
	solver.r = dynamics.r
	get_tree().root.call_deferred("add_child", solver)
	return solver

## Create a 2-dimensional [DynamicsSolverVector] instance that can calculate animations.[br]
## Pass in a [DynamicsResource] for f, z, and r settings for the new solver.
func create_dynamics_vector(dynamics: DynamicsResource) -> DynamicsSolverVector:
	if not dynamics: return null
	var solver = dynamics_solver_vector_scene.instantiate() as DynamicsSolverVector
	solver.f = dynamics.f
	solver.z = dynamics.z
	solver.r = dynamics.r
	get_tree().root.call_deferred("add_child", solver)
	return solver

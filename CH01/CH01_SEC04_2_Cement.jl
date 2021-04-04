### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# ╔═╡ b5d6171d-1623-4e99-a29f-2049ae7edb42
begin
	using CSV
	using DataFrames
	using LinearAlgebra
	using Plots
end

# ╔═╡ 7fbb6510-9545-11eb-1ae0-25da9e571053
md"# Chapter 1 Section 4 Cement"

# ╔═╡ 3d86dcd2-c132-461a-b0d3-39ad2665542e
begin
	# Load dataset
	A = CSV.File("../data/hald_ingredients.csv") |> Tables.matrix
	b = CSV.File("../data/hald_heat.csv") |> Tables.matrix
	
	# # Solve Ax=b using SVD
	(U, S, V) = svd(A, full=false)
	x = V * inv(Diagonal(S)) * U' * b

	p = plot(b, label="Heat data", legend=:topleft)
	plot!(p, A * x, label="Regression")
	p
end

# ╔═╡ Cell order:
# ╟─7fbb6510-9545-11eb-1ae0-25da9e571053
# ╠═b5d6171d-1623-4e99-a29f-2049ae7edb42
# ╠═3d86dcd2-c132-461a-b0d3-39ad2665542e

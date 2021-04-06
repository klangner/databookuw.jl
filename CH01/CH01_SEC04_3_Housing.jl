### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# ╔═╡ 6f0b0ca5-560e-4a9d-9dcc-f0d35b00d3f3
begin
	using CSV
	using DataFrames
	using Plots
	using LinearAlgebra
	using Statistics
end

# ╔═╡ 56ac7670-96e2-11eb-0bdd-65d10c03571e
md"# Chaper 1 Section 4 Housing"

# ╔═╡ 6dbeb76b-088d-41c5-a263-4dfe6aa8f0c9
begin
	# Load dataset
	H = CSV.File("../data/housing.data", header=false, delim=' ', ignorerepeated=true) |> Tables.matrix
	b = H[:, end]
	A = H[:,1:end-1]

	# Pad with ones for nonzero offset
	A = [A ones(size(A)[1])]

	# Solve Ax=b using SVD
	(U, S, V) = svd(A, full=false)
	x = V * Diagonal(S)^-1 * U' * b
	
	p1 = plot(b, label="Housing Value", legend=:topright)
	plot!(p1, A * x, label="Regression")
	xlabel!("Neighborhood")
	ylabel!("Median Home Value [\$1k]'")
	p1
end

# ╔═╡ 4941796a-5ef9-4990-8f25-e7bf59c40847
begin
	
	sort_ind = sortperm(H[:,end])
	p2 = plot(b[sort_ind], label="Housing Value", legend=:topright)
	plot!(p2, A[sort_ind, :] * x, label="Regression")
	xlabel!("Neighborhood")
	ylabel!("Median Home Value [\$1k]'")
	p2
end

# ╔═╡ 9c6482fb-a6ad-470d-9129-fc5ef700c23d
begin
	A_mean = mean(A, dims=1)
	A_std = std(A, dims=1)
	A2 = (A .- A_mean) ./ A_std
	A2 = A2[:,1:end-1]

	(U2, S2, V2) = svd(A2, full=false)
	x2 = V2 * Diagonal(S2)^-1 * U2' * b
	bar(x2, xticks=1:13, legend=nothing)
end

# ╔═╡ Cell order:
# ╟─56ac7670-96e2-11eb-0bdd-65d10c03571e
# ╠═6f0b0ca5-560e-4a9d-9dcc-f0d35b00d3f3
# ╠═6dbeb76b-088d-41c5-a263-4dfe6aa8f0c9
# ╠═4941796a-5ef9-4990-8f25-e7bf59c40847
# ╠═9c6482fb-a6ad-470d-9129-fc5ef700c23d

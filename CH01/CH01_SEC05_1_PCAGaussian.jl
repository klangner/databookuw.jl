### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ 00b36dc0-a51c-42e5-83dc-399d22062ca1
begin
	using LinearAlgebra
	using Plots
	using Distributions
end

# ╔═╡ b632747e-979f-11eb-0c70-8d204f558f0e
md"# Chapter 1 Section 5 PCA Gaussian"

# ╔═╡ 4abe0ee4-9384-4630-b2e0-673d1821b75c
begin
	xC = [2, 1]
	sig = [2, 0.5]
	theta = π/3
	R = [cos(theta) -sin(theta)
         sin(theta) cos(theta)]
	
	nPoints = 10_000            # Create 10,000 points
	A = rand(Normal(0.0, 1), (2, nPoints))
	X = R * Diagonal(sig) * A + Diagonal(xC) * ones(2,nPoints)
	
	scatter(X[1,:], X[2,:], markersize=1, legend=nothing, linecolor=:blue)
	xlims!(-6, 8)
	ylims!(-6, 8)
end

# ╔═╡ c1f8878c-0f8e-40a0-9b2a-40983de3e519
begin
	Xavg = mean(X, dims=2)
	B = X .- Xavg
	(U, S, V) = svd(B ./ √nPoints, full=false)
	
	scatter(X[1, :], X[2,:], markersize=1)
	xlims!(-6, 8)
	ylims!(-6, 8)	

	theta2 = 2π .* collect(0:0.01:1)
	cos.(theta2)

	# 1-std confidence interval
	Xstd = U * Diagonal(S) * [cos.(theta2) sin.(theta2)]'
	plot!(Xstd[1,:] .+ Xavg[1], Xstd[2,:] .+ Xavg[2], linewidth=2, color=:red)
	plot!(2*Xstd[1,:] .+ Xavg[1], 2*Xstd[2,:] .+ Xavg[2], linewidth=2, color=:red)
	plot!(3*Xstd[1,:] .+ Xavg[1], 3*Xstd[2,:] .+ Xavg[2], linewidth=2, color=:red)

	# Plot principal components U[:,1]S[1] and U[:,2]S[3]
	plot!([Xavg[1], Xavg[1]+U[1,1]*S[1]],
         [Xavg[2], Xavg[2]+U[2,1]*S[1]],color=:cyan, linewidth=5)
	plot!([Xavg[1], Xavg[1]+U[1,2]*S[2]],
         [Xavg[2], Xavg[2]+U[2,2]*S[2]],color=:cyan, linewidth=5)
end

# ╔═╡ Cell order:
# ╟─b632747e-979f-11eb-0c70-8d204f558f0e
# ╠═00b36dc0-a51c-42e5-83dc-399d22062ca1
# ╠═4abe0ee4-9384-4630-b2e0-673d1821b75c
# ╠═c1f8878c-0f8e-40a0-9b2a-40983de3e519

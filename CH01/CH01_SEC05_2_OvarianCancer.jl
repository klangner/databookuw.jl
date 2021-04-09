### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ 09bcb11c-5961-4fdc-a82f-a192224735e9
begin
	using CSV
	using DataFrames
	using LinearAlgebra
	using Plots
end

# ╔═╡ 9d81fd42-9924-11eb-2858-0b186c0d3a2d
md"# Chapter 1 Section 5 Ovarian Cancer"

# ╔═╡ 18252167-57fc-4d0d-99f8-82502e23956c
begin
	obs = CSV.File("../data/ovariancancer_obs.csv") |> Tables.matrix
	grp = CSV.File("../data/ovariancancer_grp.csv") |> Tables.matrix
	
	(U, S, V) = svd(obs, full=false)
	p = plot(layout=2)
	plot!(p[1], S, yaxis=:log, legend=nothing)
	scatter!(p[1], S, yaxis=:log)

	plot!(p[2], cumsum(S) / sum(S), yaxis=:log, legend=nothing)
	scatter!(p[2], cumsum(S) / sum(S), yaxis=:log)
end

# ╔═╡ 8b6453c9-377d-4f31-8867-3ac16d12e990
begin
	plot(legend=nothing)
	Vt = V'
	for j ∈ 1:size(obs)[1]
		x = Vt[1:3,:] * obs[j:j,:]'
    
		if grp[j] == "Cancer"
			scatter!([x[1]], [x[2]], [x[3]], color=:red)
		else
			scatter!([x[1]], [x[2]], [x[3]], color=:blue)
		end
	end
	plot!(camera=(70, 30))
end

# ╔═╡ Cell order:
# ╟─9d81fd42-9924-11eb-2858-0b186c0d3a2d
# ╠═09bcb11c-5961-4fdc-a82f-a192224735e9
# ╠═18252167-57fc-4d0d-99f8-82502e23956c
# ╠═8b6453c9-377d-4f31-8867-3ac16d12e990

### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ 8b94d828-fe0c-443e-aa07-1d84134dcdf0
begin
	using Images
	using LinearAlgebra
	using MAT
	using Plots
end

# ╔═╡ 234f5952-9c49-11eb-20ad-f9c88ca1aeb6
md"# Chapter 1 Section 6.1"

# ╔═╡ 9aa5783d-1c18-4e7c-9df0-eeb3eca6a833
begin
	mat_contents = matread("../data/allFaces.mat")
	faces = mat_contents["faces"] ./ 256.0
	m = floor(Int, mat_contents["m"])
	n = floor(Int, mat_contents["n"])
	nfaces = mat_contents["nfaces"]
	
	allPersons = zeros(6n, 6m)
	
	count = 0
	for j ∈ 1:6
		for k ∈ 1:6
			idx = floor(Int, sum(nfaces[1:count])) + 1
			face = reshape(faces[:,idx], (n, m))
			allPersons[(j-1)*n+1:j*n, (k-1)*m+1:k*m] = face
			count += 1
		end
	end
	img = reshape(faces[:, 1], (n, m))
	
	plot(Gray.(allPersons))
end

# ╔═╡ Cell order:
# ╟─234f5952-9c49-11eb-20ad-f9c88ca1aeb6
# ╠═8b94d828-fe0c-443e-aa07-1d84134dcdf0
# ╠═9aa5783d-1c18-4e7c-9df0-eeb3eca6a833

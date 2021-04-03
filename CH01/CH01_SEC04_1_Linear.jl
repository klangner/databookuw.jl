### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# ╔═╡ 199a8323-e4cd-4564-b065-f275e3145db1
begin
	using Plots
	using Distributions
	using Random
	using LinearAlgebra
end

# ╔═╡ d6d16b70-949a-11eb-01e1-054a3724a2ff
md"# Chapter 1 Section 4.1 Linear"

# ╔═╡ ef124be3-4da7-4e42-8319-6bd41c8c45c9
begin
	x = 3 # True slope
	a = Array(collect(-2:0.25:2))
	a = reshape(a, length(a), 1)
	td = truncated(Normal(0.0, 1), -3, 3)
	b = x .* a + rand(td, size(a)) # Add noise
	p = plot(a, x .* a, label="True relation", legend=:topleft)
	scatter!(p, a, b, label="Noisy data")
	
	(U, S, V) = svd(a, full=false)
	Σ = Diagonal(S)
	xtilde = V * inv(Σ) * U' * b
	plot!(p, a, xtilde .* a, linestyle=:dash, color=:red, label="Regression line")

	p
end

# ╔═╡ 2bc0240a-fe83-491c-8259-879d3079ef57
begin
	xtilde2 = pinv(a) * b
	plot(a, xtilde2 .* a, label="Moore-Penrose pseudoinverse.", legend=:topleft)
end

# ╔═╡ Cell order:
# ╟─d6d16b70-949a-11eb-01e1-054a3724a2ff
# ╠═199a8323-e4cd-4564-b065-f275e3145db1
# ╠═ef124be3-4da7-4e42-8319-6bd41c8c45c9
# ╠═2bc0240a-fe83-491c-8259-879d3079ef57

@testitem "Aqua" tags=[:core] begin
    using Aqua

    Aqua.test_all(SimpleNonlinearSolve; piracies = false, ambiguities = false)
    Aqua.test_piracies(SimpleNonlinearSolve;
        treat_as_own = [
            NonlinearProblem, NonlinearLeastSquaresProblem, IntervalNonlinearProblem])
    Aqua.test_ambiguities(SimpleNonlinearSolve; recursive = false)
end

@testitem "Explicit Imports" tags=[:core] begin
    import PolyesterForwardDiff, ReverseDiff, Tracker, StaticArrays, Zygote

    using ExplicitImports

    @test check_no_implicit_imports(
        SimpleNonlinearSolve; skip = (SimpleNonlinearSolve, Base, Core, SciMLBase)) ===
          nothing

    @test check_no_stale_explicit_imports(SimpleNonlinearSolve) === nothing

    @test check_all_qualified_accesses_via_owners(SimpleNonlinearSolve) === nothing
end

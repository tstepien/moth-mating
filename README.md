# moth-mating

<a href="https://github.com/tstepien/moth-mating/"><img src="https://img.shields.io/badge/GitHub-tstepien%2Fmoth--mating-blue" /></a> <a href="https://doi.org/10.3390/app10186543"><img src="https://img.shields.io/badge/doi-10.3390%2Fapp10186543-orange" /></a> <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" /></a>

The code contained in the moth-mating project was developed to numerically simulate moth reproductive activities. It is described in:
>[Tracy L. Stepien](https://github.com/tstepien/), [Cole Zmurchok](https://github.com/zmurchok), [James B. Hengenius](https://github.com/jhengenius), [Rocio Marilyn Caja Rivera](https://www.researchgate.net/profile/Rocio_Caja_Rivera), [Maria R. D'Orsogna](https://www.csun.edu/~dorsogna/), and [Alan E. Lindsay](https://www3.nd.edu/~alindsa1/), Moth mating: Modeling female pheromone calling and male navigational strategies to optimize reproductive success, *Applied Science*, 10 (2020), 6543, DOI: [10.3390/app10186543](https://doi.org/10.3390/app10186543).

We utilized the [MothPy](https://github.com/alexliberzonlab/mothpy) package developed for the work described in:

> Liberzon, A.; Harrington, K.; Daniel, N.; Gurka, R.; Harari, A.; Zilman, G. Moth-inspired
navigation algorithm in a turbulent odor plume from a pulsating source. *PLOS ONE* 2018, 6, 1–18.
doi:[10.1371/journal.pone.0198422](https://doi.org/10.1371/journal.pone.0198422).

> Benelli, N.; Gurka, R.; Golov, Y.; Harari, A.; Zilman, G.; Liberzon, A. Open source computational simulation for a moth-inspired navigation algorithm, 2019. bioRxiv: [744912](https://www.biorxiv.org/content/10.1101/744912v1), doi:[10.1101/744912](https://doi.org/10.1101/744912).

> Benelli, N.; Liberzon, A. alexliberzonlab/mothpy: First release of mothpy - the moth-inspired navigator
flying in pompy simulator (Version 0.0.1), 2019. Zenodo, doi:[10.5281/zenodo.2672828](https://doi.org/10.5281/zenodo.2672828).

which uses the [PomPy](https://github.com/InsectRobotics/pompy) package developed for the work described in:

> Farrell, J.A.; Murlis, J.; Long, X.; Li, W.; Cardé, R.T. Filament-based atmospheric dispersion model
to achieve short time-scale structure of odor plumes. *Environ. Fluid Mech.* 2002, 2, 143–169. doi:[10.1023/A:1016283702837](https://doi.org/10.1023/A:1016283702837).

## Description of Folders

+ [ABM](ABM): Code to run simulations of our agent-based model
+ [figures_in_paper](figures_in_paper): Code to create Figures 2-10 in our paper
+ [our_mothpy](our_mothpy): Our modification of the [MothPy](https://github.com/alexliberzonlab/mothpy) package to run simulations
+ [our_mothpy/simulations_and_figures](our_mothpy/simulations_and_figures): Code to create Figures A1-A2 in our paper.
+ [our_mothpy/simulations_and_figures/simulation_data](our_mothpy/simulations_and_figures/simulation_data): Output of our MothPy simulations.

## Licensing
Copyright 2018-2020 [Alan Lindsay](https://www3.nd.edu/~alindsa1/), [James Hengenius](https://github.com/jhengenius), [Tracy Stepien](http://github.com/tstepien/), [Cole Zmurchok](https://github.com/zmurchok).  This is free software made available under the MIT License. For details see the LICENSE file.

/*
    Copyright 2017 Zheyong Fan, Ville Vierimaa, Mikko Ervasti, and Ari Harju
    This file is part of GPUMD.
    GPUMD is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    GPUMD is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with GPUMD.  If not, see <http://www.gnu.org/licenses/>.
*/




#pragma once
#include "common.cuh"




// Parameters for neighbor list updating
struct Neighbor
{
    int MN;               // upper bound of # neighbors for one particle
    int update;           // 1 means you want to update the neighbor list
    real skin;            // skin distance 
    real rc;              // cutoff used when building the neighbor list
};




class Atom
{
public:
    int *NN; int *NL;             // global neighbor list
    int *NN_local; int *NL_local; // local neighbor list
    int *type;                    // atom type (for force)
    int *type_local;              // local atom type (for force)
    int *label;                   // group label 
    int *group_size;              // # atoms in each group
    int *group_size_sum;          // # atoms in all previous groups
    int *group_contents;          // atom indices sorted based on groups
    real *x0; real *y0; real *z0; // for determing when to update neighbor list
    real *mass;                   // per-atom mass
    real *x; real *y; real *z;    // per-atom position
    real *vx; real *vy; real *vz; // per-atom velocity
    real *fx; real *fy; real *fz; // per-atom force
    real *heat_per_atom;          // per-atom heat current
    real *virial_per_atom_x;      // per-atom virial
    real *virial_per_atom_y;
    real *virial_per_atom_z;
    real *potential_per_atom;     // per-atom potential energy
    real *box_length;       // box length in each direction
    real *thermo;           // some thermodynamic quantities

    int* cpu_type;
    int* cpu_type_local;
    int* cpu_type_size;
    int* cpu_label;
    int* cpu_group_size;
    int* cpu_group_size_sum;
    int* cpu_group_contents;

    real* cpu_mass;
    real* cpu_x;
    real* cpu_y;
    real* cpu_z;
    real* cpu_box_length;

    int N;                // number of atoms
    int number_of_groups; // number of groups 
    int fixed_group;      // ID of the group in which the atoms will be fixed 
    int number_of_types;  // number of atom types 
    int pbc_x;           // pbc_x = 1 means periodic in the x-direction
    int pbc_y;           // pbc_y = 1 means periodic in the y-direction
    int pbc_z;           // pbc_z = 1 means periodic in the z-direction

    // make a structure?
    int number_of_steps; // number of steps in a specific run
    real initial_temperature; // initial temperature for velocity
    real temperature1;
    real temperature2; 
    // time step in a specific run; default value is 1 fs
    real time_step;

    // some well defined sub-structures
    Neighbor neighbor;

    Atom(char *input_dir);
    ~Atom(void);

    void initialize_position(char *input_dir);
    void allocate_memory_gpu(void);
    void copy_from_cpu_to_gpu(void);
};




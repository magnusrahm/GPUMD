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
#include "potential.cuh"
#include <stdio.h>


struct SW2_Para
{
    // 2-body part
    double A[3][3], B[3][3], a[3][3], sigma[3][3], gamma[3][3], rc[3][3];
    // 3-body part
    double lambda[3][3][3], cos0[3][3][3];
};


struct SW2_Data
{
    double *f12x;  // partial forces
    double *f12y;
    double *f12z;
};


class SW2 : public Potential
{
public:   
    SW2(FILE*, Atom*, int num_of_types);
    virtual ~SW2(void);
    virtual void compute(Atom*, int);
    void initialize_sw_1985_1(FILE*); // called by the constructor
    void initialize_sw_1985_2(FILE*); // called by the constructor
    void initialize_sw_1985_3(FILE*); // called by the constructor
protected:
    SW2_Para sw2_para;
    SW2_Data sw2_data;
};



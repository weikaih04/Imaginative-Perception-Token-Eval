#!/bin/bash
# Run the 8 spatial benchmarks (unified release names) for ThinkMorph.
# Set OPENAI_API_KEY in your environment before running (judge: gpt-5).

export OPENAI_API_KEY=

python run.py \
  --data PET_AI2Thor_SpatialImaginativeToken PET_Habitat_SpatialImaginativeToken PET_SAT_SpatialImaginativeToken MVC_AI2Thor_SpatialImaginativeToken MVC_ScanNet_SpatialImaginativeToken MVC_MessyTable_SpatialImaginativeToken MindCube_SpatialImaginativeToken AllAngles_SpatialImaginativeToken \
  --model thinkmorph \
  --judge gpt-5 \
  --work-dir ./results

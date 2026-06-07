#!/bin/bash
# Run the 8 spatial benchmarks (unified release names) for ThinkMorph.
# Set OPENAI_API_KEY in your environment before running (judge: gpt-5).

export OPENAI_API_KEY=

python run.py \
  --data PET_AI2Thor_ImaginativePerceptionToken PET_Habitat_ImaginativePerceptionToken PET_SAT_ImaginativePerceptionToken MVC_AI2Thor_ImaginativePerceptionToken MVC_ScanNet_ImaginativePerceptionToken MVC_MessyTable_ImaginativePerceptionToken MindCube_ImaginativePerceptionToken AllAngles_ImaginativePerceptionToken \
  --model thinkmorph \
  --judge gpt-5 \
  --work-dir ./results

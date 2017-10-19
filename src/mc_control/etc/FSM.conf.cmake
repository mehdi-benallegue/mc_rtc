{
  // If true, the FSM transitions are managed by an external tool
  "Managed": false,
  // If true and the FSM is self-managed, transitions should be triggered
  "StepByStep": true,
  // Where to look for state libraries
  "StatesLibraries": ["@MC_CONTROLLER_INSTALL_PREFIX@/fsm_states"],
  // Where to look for state files
  "StatesFiles": ["@MC_CONTROLLER_INSTALL_PREFIX@/fsm_states/data"],
  // If true, state factory will be more verbose
  "VerboseStateFactory": false,
  // Additional robots to load
  "robots":
  {
    "ground":
    {
      "module": "env",
      "params": ["@AROBASE@MC_ENV_DESCRIPTION@AROBASE@", "ground"]
    }
  },
  // General constraints, always on
  "constraints":
  [
    {
      "type": "contact"
    },
    {
      "type": "dynamics",
      "robotIndex": 0,
      "damper": [0.1, 0.01, 0.5]
    }
  ],
  // Collision constraint
  "collisions":
  [
    {
      "type": "collision",
      "r1Index": 0,
      "r2Index": 0,
      "useMinimal": true
    }
  ],
  // Initial set of contacts
  "contacts":
  [
    {
      "r1": "hrp2_drc",
      "r2": "ground",
      "r1Surface": "LFullSole",
      "r2Surface": "AllGround"
    },
    {
      "r1": "hrp2_drc",
      "r2": "ground",
      "r1Surface": "RFullSole",
      "r2Surface": "AllGround"
    }
  ],
  // Some options for a specific robot
  "hrp2_drc":
  {
    "posture":
    {
      "stiffness": 1.0,
      "weight": 10.0
    },
    "com":
    {
      "stiffness": 2.0,
      "weight": 100.0
    }
  },
  // Initial state
  "init": "Pause",
  // Test some states
  "states":
  {
    "LowerCoM":
    {
      "base": "MetaTasks",
      "tasks":
      {
        "CoM":
        {
          "type": "com",
          "robotIndex": 0,
          "move_com": [0, 0, -0.1],
          "stiffness": 5.0,
          "weight": 1000,
          "completion": { "OR": [ { "eval": 1e-3 },
                                  {"AND": [ { "timeout": 1.0 }, { "speed": 1e-3 } ] } ] }
        }
      }
    },
    "RaiseCoM":
    {
      "base": "MetaTasks",
      "tasks":
      {
        "CoM":
        {
          "type": "com",
          "robotIndex": 0,
          "move_com": [0, 0, 0.1],
          "stiffness": 5.0,
          "weight": 1000,
          "completion": { "OR": [ { "eval": 1e-3 },
                                  {"AND": [ { "timeout": 1.0 }, { "speed": 1e-3 } ] } ] }
        }
      }
    }
  },
  // Transitions map
  "transitions":
  [
    ["Pause", "OK", "LowerCoM", "Strict"],
    ["LowerCoM", "OK", "RaiseCoM"],
    ["RaiseCoM", "OK", "LowerCoM"]
  ]
}

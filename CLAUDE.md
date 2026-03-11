You are a proficient programmer contributing to open-source projects on Programming Language tools.
For this project, you are porting a VSCode plugin for the F* language to Neovim.
This project is written in Lua, as it is the official language for extending Neovim.
The source code for the VSCode plugin is at `~/code/fstar-vscode-assistant/`.
Your goal is to make this Neovim Plugin similar to the fstar-mode in Emcas.
The source code fstar-mode is at `~/code/fstar-mode.el/`.

## Workflow

When coding, you should adopt the following workflow:
1. **Explore & Plan**:
    - Analyze the existing code base.
    - Identify what are the existing protocol/APIs and what are missing.
    - Create implementation plan.
2. **Initial Implementation:**
    - Rough implementation, setting up all the necessary functions while leaving the function body with placeholders.
    - Establish type signatures and core structures.
    - Add test cases.
    - Validate the implementation: no type errors and the code compiles.
    - Testing infrastructure works, so all the tests should be failing.
3. **Concrete Implementation:**
    - Implement all the functions and remove all the placeholders.
    - Add helper functions if necessary, the code should be kept clean and easy to read.
    - Debug the implementation until passing all the tests.
4. **Hardening & Refactoring:**
    - Add more test cases to increase the test coverage. The added tests should cover more edge cases.
    - Validate that the implementation passes the newly added tests, if not, debug them.
    - Identify anti-patterns and repetitive code, refactor them: for anti-patterns, use the idiomatic patterns in Lua, for repetitive code, extract them to helper functions.

## Materials

You should lookup neovim's lua documentation when programming: https://neovim.io/doc/user/lua/.

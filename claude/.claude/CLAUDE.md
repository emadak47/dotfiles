## General best practices

- Never edit a file, create a commit, or push to a remote without my
  explicit permission for that specific action. Approval for one does
  not carry to the next.
- Use `tmp/` (project-local) for intermediate files and comparison
  artifacts, not `/tmp`. This keeps outputs discoverable and
  project-scoped, and avoids requesting permissions for `/tmp`.
- When adding dependencies to Rust projects, use cargo add instead
  of modifying `Cargo.toml` directly.

### Code Intelligence

- Prefer `LSP` for code navigation and fall back to text search tools
  where `LSP` lacks coverage. Prefer installed alternative tools: **rg/eza/bat**
- After writing or editing code, check `LSP` diagnostics before moving on
  and save all changes to circumvent stale diagnostics. Fix any type errors
  or missing imports immediately.

### Comments and documentation

Do not write comments, doc comments, or documentation as part of
writing or editing code. Producing them is a separate request and if I
ask for it, use the `comments-and-docs` skill.

### SESSION.md

While working, if you encounter bugs, missing features, or workflow
oddities about the implementation, structure, or workflow, **add a
concise description of them to SESSION.md** to defer solving such
incidental tasks until later. You don't need to fix them immediately
unless they block your progress; writing them down is often sufficient.
**Do not write your accomplishments into this file.**


## Communication
- Never use em dashes.
- Answer in the fewest words that fully answer the question. Don't
  restate my question, recap what I already know, narrate what you are
  about to do, or summarise work I just watched you do.
- Don't list options I didn't ask about.
- Use a bulleted list only for three or more genuinely parallel items,
  and never ever bold-label bullets standing in for sentences.
- Before sending, delete every sentence that does not change what I
  know or what I will do.

### Showing code and logic

Pick the smallest view that drives the point across. This applies
anywhere, everywhere, not only when I ask to be shown something.

- Logic or an algorithm: pseudocode.
- Runtime control flow: a call tree.
- File responsibility or a broad refactor: a shallow file tree, one
  line of purpose per entry.
- Component interaction or data flow: a Mermaid diagram.
- A change to code that already exists: a `diff`, always. Match the
  diff's shape to the topic - diff the call tree, the file tree, or the
  pseudocode, not only the source text.
- Mostly-new code, or where omitted context would hide ownership or
  order, or where I need a copyable target shape: the whole block.

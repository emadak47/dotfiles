---
name: comments-and-docs
description: Use when explicitly asked to write, review, or prune comments, doc comments, READMEs, or prose documentation. Never invoke as part of writing or editing code.
---

# Comments and docs

Two inverted jobs. A comment must justify its existence. Documentation
exists to be read, so describing behaviour is its purpose.

## The gate (comments)

Before writing a comment, name which category below it falls into. If
none fits, do not write it. If you cannot state what a reader loses by
deleting it, delete it.

Never write: a comment restating what the line does, a banner divider, a
narrative preamble before a block, a comment describing an earlier
version of the code, or anything meaningful only to whoever wrote it.

## Categories that earn a comment

1. **TODO.** Write `TODO(emad):` and say what remains and how to
   proceed, not that something remains.
   ```rust
   // TODO(emad): retry on 429. Needs a backoff budget shared with the
   // scheduler, which does not exist yet.
   ```
2. **Reference.** Link the paper, post, or algorithm the code came from,
   and say where this implementation diverges from it.
3. **Correctness argument.** Why non-obvious code is reliably correct.
   Tests show that it holds, but this says why.
4. **Hard-learned lesson.** What you found by hitting it, and what
   breaks if someone removes the fix.
5. **Constant rationale.** How a magic number was chosen and what
   changes if it moves.
6. **Load-bearing choice.** An invariant something elsewhere silently
   depends on: "must collect into BTreeSet, the digest below hashes
   iteration order".
7. **Algorithm outline.** High-level steps when the implementing code
   obscures them.
8. **Why-not.** Justify departing from the obvious alternative or from
   local convention.
9. **Intentional trade-off.** As a Y-statement: in the context of X,
   facing Y, we chose Z, achieving A, accepting B.

## Writing standards

Complete sentences. The reader does not have your context. Precision
over terseness: a comment worth writing is worth writing properly. Wrap
to the file's prose width.

## Docs: doc comments, READMEs, prose documentation

Describing what a thing does and how to use it is the job here, so the
gate does not apply. The discipline is different:

- State the contract: parameters that matter, errors, panics,
  invariants, complexity where relevant. Skip what the signature
  already says.
- Realistic names in examples, never foo/bar.
- Document intentional omissions: behaviour a reader would expect to
  find and will not.
- Delete any sentence whose removal costs the reader nothing.
- No marketing voice. No "simply", "just", "powerful", "seamless".
- README: what it is, how to run it, how to use it, where things live.
  Nothing aspirational.

## Pruning

Same gate, backwards. Walk existing comments and delete any that name no
category. Fix stale ones describing code that no longer exists. Comment
volume is not a quality signal in either direction.

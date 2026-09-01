---
name: writing-tests
description: Use when writing, reviewing, or restructuring tests and test modules. Rust only.
---

# Overview

A test is a compact statement about one behaviour. Where a rule below
and compactness disagree, compactness wins.

## One behaviour per test

Name every test `test_<behaviour>`, after what is asserted rather than
after the function under test.

A test must fail for exactly one reason and that reason is a behaviour.
Two asserts spanning two unrelated properties is two tests.

One assert per test is forbidden. God tests are forbidden.

Asserts read as facts about the behaviour and the values carry the meaning.
Default to no third argument and add one only when a loop or table makes
the failing iteration invisible, and then it names the case not the expectation.

## Compaction

- Assert immediately after the action that produced the value, then act
  again on the same subject, reusing the same fixture and buffers, if any.
- Bind only what you assert on. No intermediates, no unused de-structuring.
- `expect`, never `unwrap`, and the message states the precondition the
  test relies on.
- Bodies stay within five to fifteen lines. Past that, either the axis needs
  a loop or a table, or the type/behaviour under test needs splitting.

## Setup

If needed, only one constructor per test module is allowed, and then the
setup function builds inputs and never asserts.

Needing more is a sign that the type under test drags in collaborators
it should not own and it warrants a deeper look at the original code.
So, report the coupling and do not add helpers to hide it.

## Reach inside

Add `#[cfg(test)]` inherent accessors to the type under test rather than
widening field visibility. The same applies to trait impls that exist only
to keep tests terse.

## Abstraction

- Symmetric variants belong inside one test. Nest loops when the axes are
independent.

A loop when the axis is an enum:

```rust
for dir in [Direction::Up, Direction::Down] {
    let q = Queue::new();
    q.push(dir, 7);
    assert_eq!(q.pop(dir).expect("push completed"), 7);
    assert_eq!(q.pop(dir.opposite()), None);
}
```

A table when the axis is data, include the edge cases that motivated the
code:

```rust
let cases: &[(u32, f32)] = &[
    (0, 0.0),
    (u32::MAX, 0.0),
    (0, f32::MAX),
    (u32::MAX, f32::MAX),
];
for &(id, value) in cases {
    let (got_id, got_value) = unpack(pack(id, value));
    assert_eq!(got_id, id, "id mismatch (id={id}, value={value})");
    assert_eq!(got_value, value, "value mismatch (id={id}, value={value})");
}
```

- Use `macro_rules!` when several tests need the same non-trivial type
*defined*. For example, a mock implementing three traits is a macro.

- Use a context type when the subject is a running system rather than a value.
It owns the lifecycle and assertion methods are permissible on it:

```rust
struct Harness { /* channels, spawned tasks */ }

impl Harness {
    fn setup(workers: usize) -> Self;
    fn assert_counts(&self, expected: &[usize]);
    fn teardown(self);
}
```

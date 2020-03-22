# Indentation in Markdown

When it comes to indentation in Markdown there are (the usual) two questions:

1.  Tabs or spaces?
1.  If indenting with spaces, how many?

## Recommendation

My recommendation: **Use Spaces** with an **indent size of 4**.

For the reason, see below.

## Indentation Tip

There's one (not so obvious) tip to make things visually aligned when dealing with lists:

> Hit the **Tab Key** - instead of the "Space Key" - after a list bullet point (i.e. `1.` or `*`).

For example, ident like this:

```markdown
1.  First list item
    *   A nested list

        with a paragraph

            and some preformatted text
```

instead of:

```markdown
1. First list item
    * A nested list

        with a paragraph

            and some preformatted text
```

## Reasoning

Usually the "tabs vs. spaces" debate comes down to personal preference. There are some arguments for one or the other - but they're "balanced" enough so that no clear winner has ever been chosen.

However, with Markdown **spaces - with an indent size of 4 - are (slightly) better**. Why is that?

When indenting lists and preformatted text in Markdown, there is (usually) no difference in behavior no matter whether you're indenting with tabs or with spaces (with an indent size of 4).

When indenting with spaces, you may be tempted to choose an ident size smaller than 4 (like 2 or 3) but there are always situations where one level of indentation is not enough. The following list lists the minimum number of spaces required for the various Markdown elements to work/to be recognized (tested in Visual Studio Code and GitHub):

*   For *preformatted text*, exactly 4 spaces (additionally to the current indentation level) are required.
*   For a *nested list* or *paragraph in a list*, the number of required spaces depends on the width of the list bullet point:
    *   For `*` at least 2 spaces are required.
    *   For `1.` at least 3 spaces are required.

**Note:** These minimum requirements may not be recognized by every Markdown interpreter. Some interpreters only accept an indent size of 4. There is an article by Brett Terpstra that goes into even more detail on the matter of compatibility: <https://brettterpstra.com/2015/08/24/write-better-markdown/>

Up until now tabs may be better than spaces because they're less confusing to Markdown interpreters (since the indent size doesn't matter).

However, there is one place in Markdown where **spaces are significantly better than tabs**: [Tables](https://www.markdownguide.org/extended-syntax/#tables). Since tab width can be anything, aligning the pipe characters of a table with tabs may result in visually unaligned "columns".

**Note:** Even though we could set the indent size for tabs with `.editorconfig`, any editor/viewer that doesn't support editorconfig would still have the problem with alignment. And while (probably) most editors default to a tab width of 4, this may not be true for every editor/viewer out there.

## Indentation Reference Example: Spaces

> This example contains the various situations where indentation is used in Markdown. It's indented with spaces with an indent size of 4. You can use it as reference "test" for when you want to use a different indentation style.

Some preformatted text block:

    Some preformatted text
    with a new line goes here.

A nested list:

1.  First list item
    *   A nested list

        with a paragraph

            and some preformatted text
    *   Another bullet point
1.  The second list item

A nested unordered list:

*   Item 1
    *   Sub item 1

| Column 1          | Column 2
| ----------------- | --------
| Some longer text  | Some other text
| Some other text   | More text

## Indentation Reference Example: Tabs

> This example contains the various situations where indentation is used in Markdown. It's indented with tabs. You can use it as reference "test" for when you want to use a different indentation style.

Some preformatted text block:

	Some preformatted text
	with a new line goes here.

A nested list:

1.	First list item
	*	A nested list

		with a paragraph

			and some preformatted text
	*	Another bullet point
1.	The second list item

A nested unordered list:

*	Item 1
	*	Sub item 1

| Column 1			| Column 2
| ----------------- | --------
| Some longer text	| Some other text
| Some other text	| More text

## Example: Compact Indentation with Spaces

> This example is indented with spaces and uses the least possible spaces for indentation (while still preserving the intended layout). The point of this example is that, while you can indent like this, you can't use the "Tab Key" efficiently as there is no common indent width that works.

Some preformatted text block:

    Some preformatted text (indentation: 4 Spaces)

A nested list:

1. First list item
   * A nested list (indentation: 3 Spaces)

     with a paragraph (indentation: 5 Spaces)

         and some preformatted text (indentation: 9 Spaces)

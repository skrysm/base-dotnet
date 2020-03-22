# Indentation in Markdown

When it comes to indentation in Markdown there are (the usual) two questions:

1. Tabs or spaces?
1. If indenting with spaces, how many?

## Recommendation

My recommendation: **Use Tabs** (with a (visual) indent size of 3 or 4)

Alternative you may use spaces with an indent size of 4.

You should not use spaces with an indent size of 2 or 3 - because with this things get "complicated".

For the reason, see below.

## Indentation Tip

There's one (not so obvious) tip to make things visually aligned when dealing with lists:

> Hit the **Tab Key** - instead of Space - after a list bullet point (i.e. `1.` or `*`).

For example, ident like this (with a tab size of 4):

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

However, with Markdown **tabs are better**. Why is that?

The rules of indenting Markdown with spaces are more complicated than indenting with tabs:

*	With **tabs**, one tab means one indentation level.
*	With **spaces**, it depends (tested with Visual Studio Code and GitHub):
	*	For *preformatted text*, exactly 4 spaces (additionally to the current indentation level) are required.
	*	For a *nested list* or *paragraph in a list*, the number of required spaces depends on the width of the list bullet point:
		* For `*` at least 2 spaces are required.
		* For `1.` at least 3 spaces are required.

**Note:** While most Markdown interpreters (i.e. the software that converts your Markdown file into an HTML file or something else) seem to agree on how to interpret tabs for indentation, there seem to be different "opinions" on how to interpret spaces for indentation - especially if you use less than 4 spaces for indentation. So, if you use spaces with an indent size of 2 or 3, you may risk compatibility. There is an excellent article by Brett Terpstra that goes into even more detail on the matter of compatibility: <https://brettterpstra.com/2015/08/24/write-better-markdown/>

**Note 2:** The one place where **spaces are better than tabs** in Markdown is [tables](https://www.markdownguide.org/extended-syntax/#tables). Since tab width can be anything, aligning the pipe characters with tabs may result in visually unaligned "columns".

## Indentation Reference Example

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

## Example: Compact Indentation with Spaces

> This example is indented with spaces and uses the least possible spaces for indentation (while still preserving the intended layout). The point of this example is that, while you can indent like this, you can't use the "Tab Key" efficiently as there is no common indent width that works.

Some preformatted text block:

    Some preformatted text (indentation: 4 Spaces)

A nested list:

1. First list item
   * A nested list (indentation: 3 Spaces)

     with a paragraph (indentation: 5 Spaces)

         and some preformatted text (indentation: 9 Spaces)

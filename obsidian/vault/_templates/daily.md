<%*
const year = tp.date.now("GGGG");
const monday = window.moment().startOf('isoWeek');
const sunday = window.moment().endOf('isoWeek');
const weekHeading = "# (W" + tp.date.now("WW") + ": " + monday.format("MMM D") + " - " + sunday.format("MMM D") + ")";
const dayHeading = "## " + tp.date.now("MMM D") + " - " + tp.date.now("ddd");
const filePath = "journal/" + year + ".md";

let file = app.vault.getAbstractFileByPath(filePath);

if (!file) {
    file = await app.vault.create(filePath, weekHeading + "\n\n" + dayHeading + "\n\n");
} else {
    let content = await app.vault.read(file);

    if (!content.includes(dayHeading)) {
        if (!content.includes(weekHeading)) {
            content = weekHeading + "\n\n" + dayHeading + "\n\n" + content;
        } else {
            const insertPos = content.indexOf("\n", content.indexOf(weekHeading)) + 1;
            content = content.slice(0, insertPos) + "\n" + dayHeading + "\n\n" + content.slice(insertPos);
        }
        await app.vault.modify(file, content);
    }
}

// Open the journal file in the current (or a new) leaf
const leaf = app.workspace.getLeaf(false);
await leaf.openFile(file);

// Move cursor to the end of today's section — guarded in case no editor view is active
const view = app.workspace.getActiveViewOfType(tp.obsidian.MarkdownView);
if (view) {
    const lines = view.editor.getValue().split('\n');
    const startLine = lines.findIndex(l => l === dayHeading);
    if (startLine !== -1) {
        let lastLine = startLine;
        for (let i = startLine + 1; i < lines.length; i++) {
            // stop at the next day or week heading; ### and deeper are content
            if (/^#{1,2} /.test(lines[i])) break;
            if (lines[i].trim() !== '') lastLine = i;
        }
        view.editor.setCursor({ line: lastLine, ch: lines[lastLine].length });
        view.editor.focus();
    }
}

tR = "";
-%>

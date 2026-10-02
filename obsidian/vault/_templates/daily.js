module.exports = async (params) => {
    const { app } = params;
    const moment = window.moment;

    const now = moment();
    const year = now.format("GGGG");
    const monday = now.clone().startOf('isoWeek');
    const sunday = now.clone().endOf('isoWeek');
    const weekHeading = "# (W" + now.format("WW") + ": " + monday.format("MMM D") + " - " + sunday.format("MMM D") + ")";
    const dayHeading = "## " + now.format("MMM D") + " - " + now.format("ddd");
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

    // leaf.view is the MarkdownView after openFile — no active-editor requirement
    const view = leaf.view;
    if (view && view.editor) {
        const editor = view.editor;
        const lines = editor.getValue().split('\n');
        const startLine = lines.findIndex(l => l === dayHeading);
        if (startLine !== -1) {
            let lastLine = startLine;
            for (let i = startLine + 1; i < lines.length; i++) {
                // stop at the next day or week heading; ### and deeper are content
                if (/^#{1,2} /.test(lines[i])) break;
                if (lines[i].trim() !== '') lastLine = i;
            }
            editor.setCursor({ line: lastLine, ch: lines[lastLine].length });
            editor.focus();
        }
    }
};

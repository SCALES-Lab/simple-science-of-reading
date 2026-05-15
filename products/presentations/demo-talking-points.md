# Demo Talking Points

## Purpose of the demo

Show how a research project lives as a working folder, how modern coding tools help us inspect and change it, and how the repository is organized so that a human researcher and AI assistant can collaborate without losing track of evidence, decisions, or outputs.

---

## 1. Start in Finder: the project as a folder

**What to show**
- Open the project folder in Finder.
- Briefly point out that this is an ordinary folder on the computer, not a mysterious app-specific container.

**What to say**
- “At the most basic level, a project is just a folder containing files and subfolders.”
- “On Windows, this same idea often appears through File Explorer and the terminal; here I’m showing the Mac equivalent in Finder.”
- “The tools we use later are really different ways of looking into and working on this same folder.”

**Transition**
- “Once we have a project folder, the next question is: what tools help us work inside it efficiently?”

---

## 2. Introduce the toolchain

### Coding assistants

**What to say**
- “Coding assistants are collaborators that can inspect files, suggest changes, write code, and help reason through a project.”
- “They are most useful when the project itself is well organized and gives them clear instructions.”

### Terminal emulator

**What to say**
- “A terminal emulator is a text-based window into the computer. It lets us run commands directly instead of clicking through menus.”
- “On Windows, many people encounter this through Command Prompt, PowerShell, or Windows Terminal.”

### IDE: Positron / VS Code family

**What to say**
- “An IDE is a richer workspace for reading, editing, running, and organizing code.”
- “Positron is built for data-science work and will feel familiar to people who know VS Code.”

**Transition**
- “So Finder shows us the project from the outside; Positron lets us step inside it.”

---

## 3. Open the project in Positron

**What to show**
- Open the project folder in Positron.
- Walk through the main regions of the interface:
  - file explorer
  - editor pane
  - terminal / console area
  - any relevant side panels

**What to say**
- “The key idea is that the IDE is still showing the same project folder we just saw in Finder, but now with tools for actually working on it.”
- “The file explorer helps us navigate structure, the editor lets us work on documents and code, and the terminal lets us run commands without leaving the project.”

**Optional emphasis**
- “A good project layout reduces cognitive load. You should be able to infer a lot about the work just by looking at the folder structure.”

**Transition**
- “Now that we’re inside the project, let’s look at the assistant that can work with us here.”

---

## 4. Look at Codex

**What to show**
- Open Codex.
- Point out that Codex can inspect the repository, follow instructions, and make changes within the project.

**What to say**
- “Codex is not just answering isolated questions; it can work against the actual project context.”
- “That means the quality of the collaboration depends partly on what the repository teaches it: the README, project instructions, file organization, and source materials.”
- “This is why we treat project documentation as infrastructure, not decoration.”

**Transition**
- “The best way to see that is to walk through the files the assistant and the human both rely on.”

---

## 5. Walk through the files and folders

### Start with `README.md`

**What to show**
- Open `README.md`.

**What to say**
- “The README is the front door of the project.”
- “It explains what the project is, what question it is asking, and how the repository is organized.”
- “Because it is written in Markdown, it is plain text that is easy for both people and tools to read.”

**Points to highlight**
- Project title and central research question
- Project goals
- Repository map
- Current status

### Then open `AGENTS.md`

**What to show**
- Open `AGENTS.md`.

**What to say**
- “If the README explains the project to a human newcomer, `AGENTS.md` explains how an assistant should behave inside the project.”
- “It sets rules about evidence, provenance, and the difference between durable knowledge and temporary planning.”
- “This is one way to make AI collaboration more reliable: the assistant is given project-specific norms rather than generic instructions.”

**Points to highlight**
- Project scope
- Source policy
- Provenance requirements
- Rules for assistants
- Default workflow

### Suggested folder tour

| Folder | Talking point |
|---|---|
| `sources/` | Literature and source notes that ground the research |
| `data/` | Empirical inputs for the project |
| `scripts/` | Reusable workflows that process or analyze data |
| `knowledge/` | Durable, checked claims the project may reuse later |
| `ai/` | Instructions, decisions, and workflow support for assistant collaboration |
| `products/` | Things produced for sharing: manuscripts, notebooks, presentations |

**What to say**
- “The folder structure separates evidence, process, durable knowledge, and outputs.”
- “That separation matters because it keeps us from confusing a brainstorm, a source, and a settled claim.”

---

## Closing idea

**What to say**
- “The larger lesson is that modern research projects are not just collections of files. They are environments for thought.”
- “When the environment is legible—clear documentation, clear provenance, clear structure—both humans and assistants can do better work inside it.”

---

## Optional compact run-of-show

1. Finder: project as folder  
2. Toolchain: assistant, terminal, IDE  
3. Positron: project workspace  
4. Codex: assistant inside the repo  
5. README: human-facing orientation  
6. AGENTS.md: assistant-facing orientation  
7. Folder tour: how the project separates kinds of work  
8. Close: good structure makes better collaboration possible

import json, os, sys

EM_DASH = "—"

data = json.load(sys.stdin)
tool = data.get("tool_name")
inp = data.get("tool_input", {})

project_dir = os.environ.get("CLAUDE_PROJECT_DIR", "")
file_path = inp.get("file_path", "")

in_scope = bool(project_dir) and os.path.abspath(file_path).startswith(os.path.abspath(project_dir))

if tool == "Edit":
    text = inp.get("new_string", "")
elif tool == "Write":
    text = inp.get("content", "")
else:
    text = ""

if in_scope and EM_DASH in text:
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny",
            "permissionDecisionReason": "Blocked: the new content contains an em dash (U+2014). Rewrite using a comma, period, colon, or parentheses instead. Em dashes are not allowed anywhere in this repo."
        }
    }))

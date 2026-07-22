import re

with open('index.html', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Update nav background
content = re.sub(
    r'(nav\s*\{\s*background:\s*)rgba\(173, 216, 230, 0\.94\)(;)',
    r'\g<1>rgba(0, 86, 179, 0.98)\g<2>',
    content
)

# 2. Update nav-links colors
content = re.sub(
    r'(\.nav-links a \{ text-decoration: none; color:\s*)#[0-9a-fA-F]+(;.*?\})',
    r'\g<1>#ffffff\g<2>',
    content
)
content = re.sub(
    r'(\.nav-links a:hover \{ color:\s*)var\(--accent-green\)(; \})',
    r'\g<1>var(--accent-warm)\g<2>',
    content
)
content = re.sub(
    r'(\.nav-links a\.active \{ color:\s*)var\(--accent-green\)(; \})',
    r'\g<1>var(--accent-warm)\g<2>',
    content
)

# 3. Update phone-section colors
content = re.sub(
    r'(background:\s*)rgba\(11, 107, 60, 0\.08\)(;)',
    r'\g<1>rgba(255, 255, 255, 0.15)\g<2>',
    content
)
content = re.sub(
    r'(\.phone-section:hover \{ background:\s*)rgba\(11, 107, 60, 0\.15\)(;)',
    r'\g<1>rgba(255, 255, 255, 0.25)\g<2>',
    content
)
content = re.sub(
    r'(\.phone-label \{.*color:\s*)#[0-9a-fA-F]+(;)',
    r'\g<1>#e2e8f0\g<2>',
    content
)
content = re.sub(
    r'(\.phone-number \{.*color:\s*)var\(--accent-green\)(;)',
    r'\g<1>#ffffff\g<2>',
    content
)

# 4. Mobile header fixes (max-width: 768px block)
content = re.sub(
    r'(@media \(max-width: 768px\) \{\s*nav \{ )padding-bottom: 0\.5rem;( \})',
    r'\g<1>padding: 0.5rem 1rem; flex-wrap: wrap; justify-content: space-between;\g<2>',
    content
)
content = re.sub(
    r'(\.hamburger-menu \{ )display: flex; order: 3;( \})',
    r'\g<1>display: none !important;\g<2>',
    content
)
content = re.sub(
    r'(\.nav-links \{ display: )none;( position: )absolute;( top: 100%; left: 0; right: 0; background: rgba\(255,255,255,0\.98\); flex-direction: )column;( gap: 0\.2rem; padding: )1\.2rem 1rem;( box-shadow: )0 4px 12px rgba\(0,0,0,0\.1\);( z-index: 99; border-bottom: )1px solid var\(--border-light\);( \})',
    r'\g<1>flex !important;\g<2>static; top: auto; left: auto; right: auto; background: transparent; flex-direction: row;\g<4>0.5rem 0 0.2rem 0;\g<5>none;\g<6>none; width: 100%; overflow-x: auto; -webkit-overflow-scrolling: touch; justify-content: flex-start;\g<7>',
    content
)
content = re.sub(
    r'(\.nav-links\.active \{ display: flex; \}\s*\.nav-links a \{ padding: )0\.85rem 0\.5rem;( border-bottom: )1px solid #f0f0f0;( \})',
    r'.nav-links::-webkit-scrollbar { display: none; }\n            \g<1>0;\g<2>none; color: #ffffff; font-size: 0.85rem;\g<3>',
    content
)

# 5. Sticky header override
content = re.sub(
    r'(\/\* Sticky Header \*\/[\s\S]*?nav \{\s*position: sticky;\s*top: 0;\s*z-index: 1000;\s*background: )#fff(;\s*box-shadow: 0 2px )10px rgba\(0,0,0,0\.05\)(;\s*\})',
    r'\g<1>rgba(0, 86, 179, 0.98)\g<2>15px rgba(0,0,0,0.15)\g<3>\n        nav .logo img {\n            filter: brightness(0) invert(1);\n        }',
    content
)

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("Done updating index.html")

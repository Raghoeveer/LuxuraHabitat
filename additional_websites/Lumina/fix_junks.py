import re

with open(r'c:\websites_vs\New folder\Lumina\index.html', 'r', encoding='utf-8') as f:
    text = f.read()

replacements = {
    'ðŸ” ': '&#128269;',
    'âœ•': '&times;',
    'ðŸ“ž': '&#128222;',
    'ðŸ“±': '&#128241;',
    'ðŸ’¬': '&#128172;',
    'âœ‰ï¸ ': '&#9993;',
    'designâ€”explore': 'design&mdash;explore',
    'amenitiesâ€”built': 'amenities&mdash;built',
    'ðŸ ¢': '&#127970;',
    'ðŸŒ¿': '&#127807;',
    'ðŸ ™ï¸ ': '&#127970;',
    'ðŸ €': '&#9917;',
    'ðŸ”’': '&#129309;',
    'âš-ï¸ ': '&#9888;',
    'Â(c)': '&copy;',
    'â ®': '&#10094;',
    'â ¯': '&#10095;',
    'A(c)': '&copy;'
}

for k, v in replacements.items():
    text = text.replace(k, v)

with open(r'c:\websites_vs\New folder\Lumina\index.html', 'w', encoding='utf-8') as f:
    f.write(text)

print("Done")

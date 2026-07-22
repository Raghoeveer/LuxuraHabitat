$content = Get-Content "index.html" -Raw
$content = $content.Replace("`r`n", "`n")

$o1 = @"
        nav {
            background: rgba(173, 216, 230, 0.94);
"@.Replace("`r`n", "`n")
$n1 = @"
        nav {
            background: rgba(0, 86, 179, 0.98);
"@.Replace("`r`n", "`n")
$content = $content.Replace($o1, $n1)

$o2 = @"
        .nav-links a { text-decoration: none; color: #30362f; font-size: clamp(0.7rem, 1vw, 0.82rem); font-weight: 600; transition: color 0.3s ease; white-space: nowrap; }
        .nav-links a:hover { color: var(--accent-green); }
        .nav-links a.active { color: var(--accent-green); }
"@.Replace("`r`n", "`n")
$n2 = @"
        .nav-links a { text-decoration: none; color: #ffffff; font-size: clamp(0.7rem, 1vw, 0.82rem); font-weight: 600; transition: color 0.3s ease; white-space: nowrap; }
        .nav-links a:hover { color: var(--accent-warm); }
        .nav-links a.active { color: var(--accent-warm); }
"@.Replace("`r`n", "`n")
$content = $content.Replace($o2, $n2)

$o3 = @"
            background: rgba(11, 107, 60, 0.08);
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .phone-section:hover { background: rgba(11, 107, 60, 0.15); transform: translateY(-2px); }

        .phone-label { font-size: clamp(0.6rem, 0.8vw, 0.75rem); color: #6b7280; font-weight: 500; letter-spacing: 0.3px; text-transform: uppercase; }
        .phone-number { font-size: clamp(0.75rem, 1vw, 0.95rem); color: var(--accent-green); font-weight: 800; white-space: nowrap; }
"@.Replace("`r`n", "`n")
$n3 = @"
            background: rgba(255, 255, 255, 0.15);
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .phone-section:hover { background: rgba(255, 255, 255, 0.25); transform: translateY(-2px); }

        .phone-label { font-size: clamp(0.6rem, 0.8vw, 0.75rem); color: #e2e8f0; font-weight: 500; letter-spacing: 0.3px; text-transform: uppercase; }
        .phone-number { font-size: clamp(0.75rem, 1vw, 0.95rem); color: #ffffff; font-weight: 800; white-space: nowrap; }
"@.Replace("`r`n", "`n")
$content = $content.Replace($o3, $n3)

$o4 = @"
        @media (max-width: 768px) {
            nav { padding-bottom: 0.5rem; }


        

            .hamburger-menu { display: flex; order: 3; }
            .nav-links { display: none; position: absolute; top: 100%; left: 0; right: 0; background: rgba(255,255,255,0.98); flex-direction: column; gap: 0.2rem; padding: 1.2rem 1rem; box-shadow: 0 4px 12px rgba(0,0,0,0.1); z-index: 99; border-bottom: 1px solid var(--border-light); }
            .nav-links.active { display: flex; }
            .nav-links a { padding: 0.85rem 0.5rem; border-bottom: 1px solid #f0f0f0; }
            .nav-links a:last-child { border-bottom: none; }
"@.Replace("`r`n", "`n")
$n4 = @"
        @media (max-width: 768px) {
            nav { padding: 0.5rem 1rem; flex-wrap: wrap; justify-content: space-between; }


        

            .hamburger-menu { display: none !important; }
            .nav-links { 
                display: flex !important; 
                position: static; 
                top: auto; left: auto; right: auto; 
                background: transparent; 
                flex-direction: row; 
                gap: 1.2rem; 
                padding: 0.5rem 0 0.2rem 0; 
                box-shadow: none; 
                z-index: 99; 
                border-bottom: none; 
                width: 100%;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
                justify-content: flex-start;
            }
            .nav-links::-webkit-scrollbar { display: none; }
            .nav-links.active { display: flex; }
            .nav-links a { padding: 0; border-bottom: none; color: #ffffff; font-size: 0.85rem; }
            .nav-links a:last-child { border-bottom: none; }
"@.Replace("`r`n", "`n")
$content = $content.Replace($o4, $n4)

$o5 = @"
        /* Sticky Header */
        nav { 
            position: sticky; 
            top: 0; 
            z-index: 1000; 
            background: #fff; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.05); 
        }
"@.Replace("`r`n", "`n")
$n5 = @"
        /* Sticky Header */
        nav { 
            position: sticky; 
            top: 0; 
            z-index: 1000; 
            background: rgba(0, 86, 179, 0.98); 
            box-shadow: 0 2px 15px rgba(0,0,0,0.15); 
        }
        nav .logo img {
            filter: brightness(0) invert(1);
        }
"@.Replace("`r`n", "`n")
$content = $content.Replace($o5, $n5)

[IO.File]::WriteAllText("C:\websites_vs\New folder\La Vita\index.html", $content)

$file = 'c:\websites_vs\New folder\La Vita\index.html'
$html = Get-Content $file -Raw

$css = @'
        @media (max-width: 1024px) {
            /* Hide top nav buttons on mobile and tablet */
            .nav-buttons { display: none !important; }
            
            /* Show sticky bottom bar on mobile and tablet */
            .mobile-sticky-bar {
                display: flex !important;
                position: fixed;
                bottom: 0;
                left: 0;
                width: 100%;
                background: #fff;
                box-shadow: 0 -2px 10px rgba(0,0,0,0.15);
                z-index: 999;
            }
            .mobile-sticky-bar a {
                flex: 1;
                text-align: center;
                padding: 0.85rem 0;
                font-weight: 700;
                font-size: 0.88rem;
                text-decoration: none;
                color: #fff;
            }
            .sticky-call { background: var(--primary-dark); }
            .sticky-wa { background: #25D366; }
            .sticky-contact { background: var(--accent-warm); }

            body { padding-bottom: 55px !important; }
        }
    </style>
'@

$html = $html -replace '</style>', $css
Set-Content $file -Value $html

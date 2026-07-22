$file = 'c:\websites_vs\New folder\La Vita\index.html'
$html = Get-Content $file -Raw

$css = @'
        /* Layout & Responsive Fixes */
        html, body { overflow-x: hidden; }
        
        /* Sticky Header */
        nav { 
            position: sticky; 
            top: 0; 
            z-index: 1000; 
            background: #fff; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.05); 
        }

        /* Fix Menu Spill */
        .nav-links { box-sizing: border-box; width: 100%; }

        @media (max-width: 1024px) {
            /* Elevate sticky bar for mobile browsers */
            .mobile-sticky-bar {
                bottom: 15px !important;
                width: 92% !important;
                left: 4% !important;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0,0,0,0.2) !important;
            }
            body { padding-bottom: 80px !important; }
        }

        @media (max-width: 768px) {
            /* Make pricing table responsive as a card */
            .pricing-table, .pricing-table tbody, .pricing-table tr {
                display: block;
                width: 100%;
            }
            .pricing-table thead { display: none; }
            .pricing-table tr {
                display: flex;
                flex-direction: column;
                padding: 1rem 0;
            }
            .pricing-table td {
                display: block;
                width: 100%;
                box-sizing: border-box;
                padding: 0.5rem 1rem !important;
            }
            .pricing-table-wrap { overflow-x: hidden; }
        }
    </style>
'@

$html = $html -replace '</style>', $css
Set-Content $file -Value $html

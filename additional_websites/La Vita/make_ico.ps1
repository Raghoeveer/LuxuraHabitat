param(
    [string]$sourcePng,
    [string]$destIco
)

Add-Type -AssemblyName System.Drawing

# Load the source image
$img = [System.Drawing.Image]::FromFile($sourcePng)

# Resize to 256x256 for a nice large favicon
$size = 256
$bmp = New-Object System.Drawing.Bitmap($size, $size)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.DrawImage($img, 0, 0, $size, $size)
$g.Dispose()

# Save resized image to memory stream as PNG
$ms = New-Object System.IO.MemoryStream
$bmp.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
$pngBytes = $ms.ToArray()
$ms.Dispose()
$bmp.Dispose()
$img.Dispose()

# Create ICO file
$fs = New-Object System.IO.FileStream($destIco, [System.IO.FileMode]::Create)
$bw = New-Object System.IO.BinaryWriter($fs)

# ICO Header
$bw.Write([uint16]0) # Reserved
$bw.Write([uint16]1) # Type (Icon)
$bw.Write([uint16]1) # Count

# Image Entry
$bw.Write([byte]0)   # Width (0 means 256)
$bw.Write([byte]0)   # Height (0 means 256)
$bw.Write([byte]0)   # Color count
$bw.Write([byte]0)   # Reserved
$bw.Write([uint16]1) # Color planes
$bw.Write([uint16]32)# Bit count
$bw.Write([uint32]$pngBytes.Length) # Size
$bw.Write([uint32]22) # Offset

# PNG Bytes
$bw.Write($pngBytes)

$bw.Close()
$fs.Close()

Write-Host "Created $destIco"

# Define the path for the new files
$newFileName = "STORE"
$newFilePath = "C:\Users\Laptop 122\Desktop\Kroger AUD formatter"

# Get all .AUD files in the directory
$audFiles = Get-ChildItem -Path $newFilePath -Filter "*.AUD"

foreach ($file in $audFiles) {
    # Define the path to the current .AUD file
    $audFilePath = $file.FullName

    # Initialize a stream reader to handle the large file
    $reader = [System.IO.StreamReader]::new($audFilePath)

    # Read the first line to extract the 7th, 8th, and 9th characters
    $firstLine = $reader.ReadLine()
    $storeSuffix = $firstLine.Substring(6, 3)

    # Update the new file name with the suffix
    $newFileFullPath = Join-Path $newFilePath ($newFileName + $storeSuffix + ".txt")

    # Initialize a stream writer to create the new file
    $writer = [System.IO.StreamWriter]::new($newFileFullPath)

    # Process the file line by line
    while ($line = $reader.ReadLine()) {
        if ($line -notmatch "0049999999") {
            $writer.WriteLine($line)
        }
    }

    # Close the stream reader and writer
    $reader.Close()
    $writer.Close()

    Write-Host "New file created: $newFileFullPath"
}

# Define the path for the new files
$newFileName = "STORE"
$newFilePath = "C:\Users\Laptop 122\Desktop\Kroger AUD formatter"

# Define the exclusion codes
$exclusionCodes = @("19", "48", "57", "18", "42", "09", "46", "47", "54", "69", "15", "49", "50", "55", "56", "73", "40", "30", "29")

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
        # Extract the 96th and 97th characters
        $chars96and97 = $line.Substring(95, 2)

        # Check if the line should be excluded
        if ($line -notmatch "0049999999" -and `
            $line.Length -ge 97 -and `
            -not ($exclusionCodes -contains $chars96and97)) {
            $writer.WriteLine($line)
        }
    }

    # Close the stream reader and writer
    $reader.Close()
    $writer.Close()

    Write-Host "New file created: $newFileFullPath with depts removed."
}

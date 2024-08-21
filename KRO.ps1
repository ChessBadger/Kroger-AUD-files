# Define the path to the .aud file
$audFilePath = "C:\Users\clark\OneDrive\Desktop\2024-08-15 14.59 - RNYBIS.AUD"

# Define the path for the new file
$newFileName = "STORE"
$newFilePath = "C:\Users\clark\OneDrive\Desktop"

# Initialize a stream reader to handle the large file
$reader = [System.IO.StreamReader]::new($audFilePath)

# Read the first line to extract the 7th, 8th, and 9th characters
$firstLine = $reader.ReadLine()
$storeSuffix = $firstLine.Substring(6, 3)

# Update the new file name with the suffix
$newFilePath = Join-Path $newFilePath ($newFileName + $storeSuffix + ".txt")

# Initialize a stream writer to create the new file
$writer = [System.IO.StreamWriter]::new($newFilePath)

# Process the file line by line
while ($line = $reader.ReadLine()) {
    if ($line -notmatch "0049999999") {
        $writer.WriteLine($line)
    }
}

# Close the stream reader and writer
$reader.Close()
$writer.Close()

Write-Host "New file created: $newFilePath"

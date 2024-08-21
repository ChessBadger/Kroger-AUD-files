# Define the filter criteria
def should_remove_line(line):
    return "0049999999" in line


# Read the input file
with open('2024-08-15 14.59 - RNYBIS.AUD.txt', 'r') as file:
    input_lines = file.readlines()

# Remove the first line
input_lines = input_lines[1:]

# Filter lines based on the criteria
filtered_lines = [line for line in input_lines if not should_remove_line(line)]

# Write the filtered lines to the output file
with open('filtered_output.txt', 'w') as file:
    file.writelines(filtered_lines)

print(
    f"Filtered file saved as 'filtered_output.txt'. {len(input_lines) - len(filtered_lines)} lines were removed.")

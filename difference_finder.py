# Read input file
with open('2024-08-15 14.59 - RNYBIS.AUD', 'r') as file:
    input_lines = set(file.readlines())

# with open('C:\\Users\\clark\\OneDrive\\Desktop\\STORE365.txt', 'r') as file:
#     input_lines = set(file.readlines())

# Read output file
with open('STORE365.txt', 'r') as file:
    output_lines = set(file.readlines())

other_count = 0
count = 0

# Find removed lines
removed_lines = input_lines - output_lines

# Find added lines
added_lines = output_lines - input_lines

# Write removed lines to a new file
if removed_lines:
    with open('removed_lines.txt', 'w') as file:
        for line in removed_lines:
            file.write(line)
            count = count + 1

# Write added lines to a new file
if added_lines:
    with open('added_lines.txt', 'w') as file:
        for line in added_lines:
            file.write(line)
            other_count = other_count + 1

# Display results
if removed_lines:
    print("Content removed from the input file:")
    for line in removed_lines:
        print(line.strip())

if added_lines:
    print("\\\\nContent added to the output file:")
    for line in added_lines:
        print(line.strip())

if not removed_lines and not added_lines:
    print("No content was changed, moved, or removed.")

if count > 0:
    print(f"Lines removed:  {count}")

if other_count > 0:
    print(f"Lines added:  {other_count}")

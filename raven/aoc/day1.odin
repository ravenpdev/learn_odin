package aoc

import "core:bufio"
import "core:fmt"
import "core:io"
import "core:os"

day1 :: proc() {
	// contents, err := os.read_entire_file_from_filename("./input.txt")

	// if err {
	// 	fmt.println("cannot read the file.")
	// }

	// fmt.println(contents)


	file, err := os.open("input.txt")

	if err != nil {
		fmt.println("Error opening file:", err)
		return
	}
	defer os.close(file)


	contents, err_read := os.read_entire_file_from_filename("input.txt")
	if err_read {
		fmt.println("unable to read file")
	}

	fmt.println(string(contents))

	// size, err_size := os.file_size(file)
	// if err_size != nil {
	// 	fmt.println("Error reading file size:", err)
	// }
	// fmt.println(size / 1000, "kb")
}

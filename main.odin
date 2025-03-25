#+feature dynamic-literals

package main

import "core:fmt"
import "core:os"

import "raven/pkg"
import "raven/pkg/inner"

main :: proc() {
	fmt.println("hellope!")

	// Lexical elements and literals #

	// A comment
	my_integer_variable: int // A comment for documentation
	/*
    You can have any text or code here and have it be commented.
    /*
      NOTE: comments can be nested
    */
  */
	// Comments are parsed as tokens within the compiler. This is to allow for future work
	// on automatic documentation tools.


	// String and character literals #
	// String literals are enclosed in double quotes and character literals in single quotes. Special
	// characters are escaped with a backslash \.
	a_string := "this is a string"
	a_char := 'A'
	a_newline_char := '\n'
	directory := "~/.config/nvim"
	raw_string := `~/.config/nvim/init.lua`

	fmt.println(a_string)
	fmt.println(a_char)
	fmt.print(a_newline_char)
	fmt.println(directory)
	fmt.println(raw_string)

	// The length of a string can be found using the built-in len proc:
	// If the string passed to len is a compile-time constant, the value from len will be a compile-time constant.
	fmt.println(len(a_string))
	fmt.println(len("raven"))

	// Escape characters #
	/*
    \a - bell (BEL)
    \b - backspace (BS)
    \e - escape (ESC)
    \f - form feed (FF)
    \n - newline
    \r - carriage return
    \t - tab
    \v - vertical tab (VT)
    \\ - backslash
    \" - double quote (if needed)
    \' - single quote (if needed)
    \NNN - octal 6 bit character (3 digits)
    \xNN- hexadecimal 8 bit character (2 digits)
    \uNNNN- hexadecimal 16-bit Unicode character UTF-8 encoded (4 digits)
    \UNNNNNNNN - hexadecimal 32-bit Unicode character UTF-8 encoded (8 digits)
  */


	// Numbers #
	// A number that containsn a dot is a floating point literal: 1.0e9
	// If a number literal is suffixed with i, it is an imaginary number literal: 2i (2 multiply the square root of -1)
	// Binary literals are prefixed with 0b,
	// Octal literals with 0o
	// Hexadecimal literals with 0x. A leading nzero does not produce an octal constant (unlike C).

	// In Odin, if a number consntant can be represented by a type without precision loss, it will
	// automatically convert to that type.
	x: int = 1.0 // A float literal but it can be represented by an integer without precision loss

	// Constant literals are "untyped" which means that they can implicitly convert to a type.
	x = 1 // `1` is an untyped integer literal which can implicitly convert to `int`


	// Variable declarations #
	// A variable declaration declares a new variable for the current scope..
	a: int // declares `a` to have type `int`
	b, c: int // declares `b` and `c` to have type `int`
	// Variables are initialized to zero by default unless specified otherwise.

	// NOTE: Declarations have to be unique within scope
	d := 10
	// d := 20 // Redeclaration of `d` in this scope
	e, f := 20, 30
	// test, e := 20, 30 // not allowed since `z` exists already


	// Assignment statements #
	// The assignment statement assigns a new value to variable/location:
	aa: int = 123 // declares a new variable `aa` with type `int` and assigns a value to it.
	aa = 637 // assigns a new value to `aa`
	// = is teh assignment operator.

	// You can assign multiple variables with it:
	bb, cc := 1, "hello"
	cc, bb = "bye", 5


	// Constant declaration #
	// Constants are entities (symbols) which have an assigned value. The constant's value cannot be
	// cahngged. The constant's value must be able to evaluated at compile time:
	my_constant :: "what" // constant `my_constant` has the untyped string value "what"

	// Constants can be explicitly typed like a variable declaration:
	constant_a: int : 123
	constant_b :: constant_a + 7 // constant computations are possible


	// Packages #
	// Odin programs consists of packages. A package is a directory of Odin code files, all of which have the
	// same package declaration at the top. Execution starts in the package's main procedure.


	// import statement #
	// The following program imports the fmt and os packages from the core library collection.
	/*
    import "core:fmt"
    import "core:os"
  */
	// The core: prefix is used to state where the import is mean to look; this is called library collection.
	// if no prefix is present, the import will look relative to the current file.
	// NOTE: By convention, the package name is the same as the last element in the import path.
	// "core:fmt" package comprises of files that begin with the statement package fmt. However, this
	// is not enforced by the compiler, which means the default name for the import name will be determined
	// by the last element in the import path if possible.

	// A different import name can be used over the default package name:
	/*
    import "core:fmt"
    import foo "core:fmt" // reference a package by a different name
  */


	// Exported names #
	// All declarations in a package are public by default.

	// The private attribute can be applied to an entity to prevent it from being exported from a package.
	// check raven/pkg/ folder
	// @(private) is equivalent to @(private="package")

	fmt.println(pkg.my_exported_variable)


	// Authoring a package #
	// A package is a directory of Odin code files, all of which have the same package declaration at the
	// top, e.gg. package main. Each .odin file must have the same package name. A directory cannot contain more than 1 package.


	//  Organizing packages #
	// Packages may be thematically organized by placingg them is subdirectories of another package. For
	// example: core:imageg/pngg and core:img/tga, as subdirectories of core:image. Nesting these
	// packages is a helpful taxonomy. It does not imply a dependency: core:foo/bar does not need to
	// import core:foo and reference anything from it.
	fmt.println(inner.a_subdirectory)


	// Control flow statements #

	// for statement #
	// Odin has only one loop statement, the for loop.

	// Basic for loop #
	// A basic for loop has three components separated by semicolons:
	// - The initial statement: executed before the first iteration
	// - The condition expression: evaluated before every iteration
	// - The post statement: executed at the end of every iteration

	// the loop will stop executing when the condition is evaluated to false.
	for i := 0; i < 10; i += 1 {
		fmt.printf("%d ", i)
	}
	fmt.println()

	// NOTE: unlike other langauges like C, there are no parentheses () surrounding the three
	// components. Braces { } or a do are always required.
	for i := 0; i < 10; i += 1 {}
	for i := 0; i < 10; i += 1 do fmt.printf("%d ", i)
	fmt.println()

	// The initial post statements are optional:
	j := 0
	for j < 10 {
		j += 1
	}

	// If the condition is omitted, this produces an infinite loop:
	for {
		break // remove this to make an infinite loop
	}


	// Range-based for loop #
	for i in 0 ..< 10 {
		fmt.printf("%d ", i)
	}
	fmt.println()
	for i in 0 ..= 9 {
		fmt.printf("%d ", i)
	}
	fmt.println()
	// where a..=b denotes a clsed interval [a, b], i.e. the upper limit is inclusive, andn a..<b denotes a
	// half-open interval [a, b], i.e. the upper limit is exclusive.

	some_string := "Hello, world"
	for char in some_string {
		fmt.print(char)
	}
	fmt.println()

	some_array := [3]int{1, 2, 3}
	for value in some_array {
		fmt.println(value)
	}

	some_slice := []int{1, 4, 9}
	for value in some_slice {
		fmt.println(value)
	}

	// [dynamic] specifies that the array is a dynamic array, its size can change at runtime.
	some_dynamic_array := [dynamic]int{1, 4, 9} // must enabled with `#+feature dynamic`
	defer delete(some_dynamic_array)
	for value in some_dynamic_array {
		fmt.println(value)
	}

	some_map := map[string]int {
		"A" = 1,
		"C" = 9,
		"D" = 4,
	}
	defer delete(some_map)
	for key in some_map {
		fmt.println(key)
	}

	// Alternatively a second index value can be added:
	for char, index in some_string {
		fmt.println(index, char)
	}

	for value, index in some_array {
		fmt.println(index, value)
	}

	for value, index in some_slice {
		fmt.println(index, value)
	}

	for value, index in some_dynamic_array {
		fmt.println(index, value)
	}

	for key, value in some_map {
		fmt.println(key, value)
	}

	// The iterated values are copies and cannot be written to.

	// When iterating a string, the characterr will be runes and not bytes. for in assumes the string is
	// encoded as UTF-8
	str: string = "Some text"
	for char in str {
		assert(type_of(char) == rune)
		fmt.println(char)
	}

	// You can iterate arrays and slices by-reference with the address operator:
	some_array = {1, 2, 3}
	fmt.println(some_array)
	for &value in some_array {
		value = value + 1
	}
	fmt.println(some_array)

	some_slice = {2, 3, 4, 5, 6}
	fmt.println(some_slice)
	for &value in some_slice {
		if value % 2 == 0 {
			value = value + 1
		}
	}
	fmt.println(some_slice)

	// does not impact the index value
	some_dynamic_array = {3, 3, 4, 5}
	for &value, index in some_dynamic_array {
		value = value + 1
	}
	fmt.println(some_dynamic_array)

	// Map values can be iterated by-reference, but their keys cannot since map keys are immutable:
	some_map = {
		"A" = 1,
		"C" = 9,
		"B" = 4,
	}
	for key, &value in some_map {
		value += 1
	}
	fmt.println(some_map["A"])
	fmt.println(some_map["C"])
	fmt.println(some_map["B"])

	// NOTE: It is not possible to iterate a string in a by-reference manner as strings are immutable.


	// for reverse iteration #
	// The #reverse directive makes a range-based for loop iterate in reverse.
	array := [?]int{10, 20, 30, 40, 50}
	#reverse for x in array {
		fmt.println(x)
	}

	name := "raven"
	#reverse for c in name {
		fmt.print(c)
	}
	fmt.println()


	// if statement #
	// Odin's if statement do not need to be surrounded by parentheses ( ) but braces { } or do are required.
	x = 10
	if x >= 0 {
		fmt.println("x is positive")
	}
	if x > 5 do fmt.println("x is greater than 5")

	// Like for, the if statement can start with an initial statement to execute before the condition.
	// Variables declared by the initial statement are only in the scope of that if statement.
	// Variables declared inside an if initial statement are also available to any of the else blocks:
	if is_active := true; is_active != false {
		fmt.println("is_active:", true)
	} else {
		fmt.println("is_active:", false)
	}


	// switch statement #
	// A switch statement is another way to write a sequence of if-else statements. In Odin, the default case
	// is denoted as a case without expression.
	switch arch := ODIN_ARCH; arch {
	case .i386, .wasm32, .arm32:
		fmt.println("32 bit")
	case .amd64, .wasm64p32, .arm64, .riscv64:
		fmt.println("64 bit")
	case .Unknown:
		fmt.println("Unknown architecture")
	}
	// Odin only runs the selected case. This means that a break statement is not needed at the end of each case.
	// Another important difference is that the case values need not be integers nor constants.

	// To achieve a C-like fall through into the next case block, the keyword fallthrough can be used.

	switch s := 2; s {
	case 0: // is s == 0 it will do nothing. it will not fallthrough
	case 1:
		fallthrough
	case 2:
		fallthrough
	case 3:
		fallthrough
	case 4:
		fallthrough
	case 5:
		fmt.println("s is less than or equal to 5")
	case 6:
		fmt.println("s is greater than five")
	case:
		fmt.println("s negative")
	}

	// A switch satement without a condition is the same as switch true. This can be used to write
	// a clean and long if-else and have the ability to break if needed.
	switch_val := 5
	switch {
	case switch_val < 0:
		fmt.println("value is negative")
	case switch_val == 0:
		fmt.println("value is zero")
	case:
		fmt.println("x is positive")
	}

	// A switch statement can also use ranges like a range-based loop:
	val := 'a'
	switch val {
	case 'A' ..= 'Z', 'a' ..= 'z', '0' ..= '9':
		fmt.println("c is alphanumeric")
	}

	switch switch_val {
	case 0 ..< 10:
		fmt.println("units")
	case 10 ..< 13:
		fmt.println("pre-teens")
	case 13 ..< 20:
		fmt.println("teens")
	case 20 ..< 30:
		fmt.println("twenties")
	}


	// partial switch #
	// With enum values:

	Foo :: enum {
		A,
		B,
		C,
		D,
	}

	foo := Foo.A
	switch foo {
	case .A:
		fmt.println("A")
	case .B:
		fmt.println("B")
	case .C:
		fmt.println("C")
	case .D:
		fmt.println("D")
	case:
		fmt.println("?")
	}

	#partial switch foo {
	case .A:
		fmt.println("A")
	case .B:
		fmt.println("B")
	}


	// With union types
	Bar :: union {
		int,
		bool,
	}
	bar: Bar = 123

	switch _ in bar {
	case int:
		fmt.println("int")
	case bool:
		fmt.println("bool")
	case:
	}

	#partial switch _ in bar {
	case bool:
		fmt.println("bool")
	}


	// defer statementn #
	// A defer statement defers the execution of a statement until the end of the scope it is in:
	// The following will printn 4 then 234:
	{
		x := 123
		defer fmt.println(x)
		{
			defer x = 4
			x = 2
		}
		fmt.println(x)
		x = 234
	}

	// You can defer an entire block too:
	// Defer statements are executed in the reverse order that they were declared:
	{
		x := 1
		defer {
			fmt.println("x")
			fmt.println("y")
		}

		defer if x == 1 {
			fmt.println(x)
		}

		// output:
		// 1
		// x
		// y
	}

	// A ral word use case for defer may be something like the following:
	file, err := os.open("README.md")
	if err != os.ERROR_NONE {
		// handle error
	}
	defer os.close(file)
	// rest of the code ...
	// NOTE: defer construct in Odin differs from Go's defer, which is a function-exit and relise on a closure stack system.


	// when statement #
	// The when statement is almost identical to the if statement but with some differences:
	// - Each condition must be a constant expression as a when statement is evaluated at compile time.
	// - The statements within a brach do not create a new scope
	// - The compiler checks the semantics and code only for statements that belong to the first condition that is true.
	// - An initial statement is not allowed in a when statement
	// - when statements are allowed at file scope
	when ODIN_ARCH == .i386 {
		fmt.println("32 bit")
	} else when ODIN_ARCH == .amd64 {
		fmt.println("64 bit")
	} else {
		fmt.println("Unsupported architecture")
	}
	// The when statement is very useful for writing platform specific code. This is akin to the
	// #if construct in C's preprocessor. However, in Odin, it is type checked.


	// break statement #
	// A for loop or a switch statementn can be left prematurely with a break statement. It leaves
	// the innermost construct, unless a label of a construct is given:
	/*
    for cond {
      switch {
      case:
        if cond {
          break // break out the switch statement
        }
      }
      break // break out the for statement
    }

    loop: for cond1 {
      for cond2 {
        break loop // leaves both loops
      }
    }

    exit: {
      if true {
        break exit // works with labeled blocks too
      }
      fmt.println("This line will never print.")
    }
  */


	// continue statement #
	// As in many programming languages, a continue statement starts the next iteration of a loop
	// prematurely:
	/*
    for cond {
      if get_foo() {
        continue
      }
      fmt.println("Hellope!")
    }
  */


	// fallthrough statement #
	// fallthrough can be used to explicitly fall through into the next case block:
	switch ss := 1; ss {
	case 0:
		// foo()
		fallthrough
	case 1:
	// bar()
	case:
		fmt.println("unknown")
	}


	// Procedures #
	// In Odin, a procedurer is something that can do work, which some languagges call functions
	// or methods. A procedure literal in Odin is defined with the proc keyword:

	fibonacci :: proc(n: int) -> int {
		switch {
		case n < 1:
			return 0
		case n == 1:
			return 1
		}

		return fibonacci(n - 1) + (fibonacci(n - 2)) // (2 - 1)  = 1, (2 - 2) = 0, (3 - 2) = 1 = 0, 1 + 0 + 1 = 2
	}

	fmt.println(fibonacci(3)) // 2


	// Parameters #
	// Procedures can take zero or many parameters.
	multiply :: proc(x, y: int) -> int {
		return x * y
	}
	fmt.println(multiply(137, 432))

	// Continuing the C family tradition, everything in Odin is passed by value (rather than by reference,
	// e.g. FORTRAN, Java, etc). However, Odin differs from the C/C++ tradition in that all procedure
	// parameters in Odin are immutable values. This allows for numerous optimizations with the Odin
	// calling conventions ("odin" and "contextless") which would not be possible with the original C
	// tradition of always passing a copy of the thing that has been passed.

	// Passing a pointer value makes a copy of the pointer, not the data it points to. Slices, dynamic arrays,
	// and maps behave like pointers in this case (Internally they are structures that contain values, which
	// include pointers, and the "structure" is passed by value).

	// To mutate the procedure parameter (like in C), an explicit copy is required. This can be
	// done througgh shadowing the variable declration:

	p1 :: proc(x: int) { 	// x is immutable
		x := x // explicit mutation through shadowing
		for x > 0 {
			fmt.println(x)
			x -= 1
		}
	}
	p1(5)

	// Procedures can be variadic, taking a varying number of arguments:
	sum :: proc(nums: ..int) -> (result: int) {
		for n in nums {
			result += n
		}
		return
	}
	fmt.println(sum())
	fmt.println(sum(1, 2))
	fmt.println(sum(1, 2, 3, 4, 5))
	odds := []int{1, 3, 5}
	fmt.println(sum(..odds))


	// Multiple results #
	// A procedure in Odin can return any number of results.
	swap :: proc(x, y: int) -> (int, int) {
		return y, x
	}
	n, m := swap(1, 2)
	fmt.println(n, m)


	// Named results #
	// Return values in Odin may be named.
	do_math_with_naked_rreturn :: proc(input: int) -> (x, y: int) {
		x = 2 * input + 1
		y = 3 * input / 5

		return x, y
	}


	// Named arguments #
	// When calling a procedure, it is not clear in which order parameters might appear.
	// Therefore, the argument can be named, like a struct literal, to make it clear which
	// argument a paramter is for:

	// create_window :: proc(tilte: string, x, y: int, width, height: int, monitor: ^Monitor) -> (^Window, Window_Error) {...}
	// window, err := create_window(title="Hellope Title", monitor=nil, width=854, height: 480, x=0, y=0)

	// Positional arguments are not allowed after named arguments.
	foobar :: proc(value: int, name: string, x: bool, y: f32, z := 0) {}
	foobar(123, "hellope", x = true, y = 4.5)


	// Default values #
	// create_winndow :: proc(title: string, x := 0, y := 0, width := 854, height := 480, ^Monitor = nil) -> (^Window, Window_Err) {}
	// window1, err := create_winndow("title")
	// window2, err := create_winndow(title = "title1", width=640, height=360)
	// NOTE: these default values must be compile time known values, such as constant value or nil (if the type support it).


	// Explicit procedure overloading #
	// Unlike other languages, Odin provides the ability to explicitly overload procedures:
	bool_to_string :: proc(b: bool) -> string {
		if b {
			return "true"
		}

		return "false"
	}

	int_to_string :: proc(i: int) -> string {
		switch i {
		case 0:
			return "zero"
		case 1:
			return "one"
		case 2:
			return "two"
		case 3:
			return "three"
		case 4:
			return "four"
		case 5:
			return "five"
		case:
			return "unknown"
		}
	}

	to_string :: proc {
		bool_to_string,
		int_to_string,
	}

	fmt.println(to_string(true))
	fmt.println(to_string(5))


	// Rationale behind explicit overloading #
	// The design goals of Odin were explicitness and simplicity, Implicit procedure overloading
	// complicates the scoping system. In C++, you cannot nest procedures within procedures, so all
	// procedures look-ups are done at the global scope. In Odin, procedures can be nested within
	// procedures and, as a result, determining which procedure should be used, in the case of
	// implicit overloading, is complex.

	/*
    Explicit overloading has many advantages:

    - Explicitness of what is overloaded
    - Able to refer to the specific procedure if needed
    - Clear which scope the entity name belongs to
    - Ability to specialize parametric polymorphic procedures if necessary, which have the same
    paramter but different bounds.
  */


	// Basic types #
	// Odin's basic types are:

	/*
    // boleans
    bool b8 b16 b32 b64 

    // integers
    int i8 i16 i32 i64 i128
    uint u8 u16 u32 u64 u128 uintptr

    // endian specific integers
    i16le i32le i64le i128le u16le u32le u64le u128le // little endian
    i16be i32be i64be i128be u16be u32be u64be u128be // big endian

    // floating point numbers
    f16 f32 f64

    // endian specific floating pointer numbers
    f16le f32le f64le // little endian
    f16be f32be f64be // big endian

    // complex numbers
    complex32 complex64 complex128

    // quaternion numbers
    quaternion64 quaternion128 quaternion256

    rune // signed 32 bit integer, represent a Unicode code point, is a distinct type to `i32`

    // strings
    string cstring

    // raw pointer type
    rawptr

    // runtime type information specific type
    typeid
    any
  */

	// The uintptr type is pointer sized, and the int, uint types are the "natrual" register size,
	// which is guaranteed to greater than or equal to the size of a pointer (i.e. size_of(uint) >= size_of(uintptr)).
	// When you need an integer value, you should default to using int unless you have a specific reason
	// to use a sized or unsigned integer type.

	// NOTE: The Odin string type stores the pointer to the data and the length of the string.
	// cstring is used to interface with foreign libraries written in/for C that use zero-terminated strings.


	// Zero values #
	// Variables declared without an explicit initial value are given their zero value.
	/*
    The zero value is:

    - 0 for numeric and rune types
    - false for boolean types
    - "" (the empty string) for strings
    - nil for pointer, typeid, and any types.
  */


	// Type conversion #
	// The expression T(v) converts the value v to the type T.
	// age: int = 32
	// float_age: f64 = f64(age)
	// u32_age: u32 = u32(float_age)
	// fmt.println(age, float_age, u32_age)

	age := 32 // or with type inference
	f_age := f64(age)
	u_age := u32(f_age)
	fmt.println(age, f_age, u_age)
	// Unline C, assignments between values of a different type require an explicit conversion.

	// Cast operator #
	// The cast operator can also be used to do the same thing:
	// This is useful in some contexts but has the same semantic meaning.
	{
		i := 123
		f := cast(f64)i
		u := cast(u32)i
	}


	// Transmute operator #
	// The transmute operator is a bit cast conversion between two types of the same size:
	{
		f := f32(123)
		u := transmute(u32)f
		fmt.println("f32", f)
		fmt.println("u32", u)
		fmt.printf("u32: 0x%x\n", u)
	}
}

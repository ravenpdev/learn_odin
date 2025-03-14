package pkg

@(private)
my_variable: int // cannot be accessed outside this package

my_exported_variable: int


@(private = "file")
private_in_file: int // cannot be accessed outside this file

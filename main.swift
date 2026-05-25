// this one is extra OOP-ified because I was trying to make the binary larger.
// it hardly grew it at all.

class Greeter {
	let message: String

	init(printing message: String) {
		self.message = message
	}

	func greet() {
		print("\(self.message)")
	}
}

Greeter(printing: "Hello from Swift!").greet()

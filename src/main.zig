const print = @import("std").debug.print;
const day1 = @import("./days/day1.zig");

pub fn main() !void {
    print("Day 1:\n", .{});
    try day1.print();
}

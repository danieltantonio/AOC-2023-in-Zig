const std = @import("std");
const fs = std.fs;
const io = std.io;
const fmt = std.fmt;

const LineError = error{NumberNonExist};

pub fn print() !void {
    const file = try fs.cwd().openFile("src/days/data/day1_input.txt", .{});
    var buf_reader = io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    defer file.close();

    var buf: [1024]u8 = undefined;
    var sum: u32 = 0;

    var i: usize = 0;

    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| : (i += 1) {
        const first_num_char = try findFirstNum(line);
        const last_num_char = try findLastNum(line);
        const two_digit_char = [2]u8{ first_num_char, last_num_char };
        const num = try fmt.parseInt(u8, &two_digit_char, 10);

        sum += num;
    }

    std.debug.print("Total = {}", .{sum});
}

fn findFirstNum(line: []u8) LineError!u8 {
    for (line) |char| {
        if (char >= '0' and char <= '9') {
            return char;
        }
    }

    return LineError.NumberNonExist;
}

fn findLastNum(line: []u8) LineError!u8 {
    var i: usize = line.len - 1;

    while (i > -1) : (i -= 1) {
        if (line[i] >= '0' and line[i] <= '9') {
            return line[i];
        }
    }

    return LineError.NumberNonExist;
}

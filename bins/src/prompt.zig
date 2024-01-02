/// Extremely dumb prompt
const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var gpa_allocator = std.heap.GeneralPurposeAllocator(.{}){};

    defer switch (gpa_allocator.deinit()) {
        .ok => {},
        .leak => @panic("Memory leak"),
    };

    const gpa = gpa_allocator.allocator();

    var args_it = try std.process.argsWithAllocator(gpa);
    defer args_it.deinit();

    var args = std.ArrayList([]const u8).init(gpa);
    defer args.deinit();

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    std.debug.assert(args_it.skip());

    while (args_it.next()) |arg| {
        try args.append(arg);
    }

    if (args.items.len != 1) return;

    if (std.mem.eql(u8, args.items[0], "0")) {
        try stdout.print("\x1B[1m;\x1B[0m ", .{});
    } else {
        try stdout.print("\x1B[1;31m;\x1B[0m ", .{});
    }

    try bw.flush();
}

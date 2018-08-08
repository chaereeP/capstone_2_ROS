#include "implementation.cpp"

int main() {
    GridWithWeights grid = init_map();

    SquareGrid::Location start{99, 99};
    SquareGrid::Location goal{9, 9};
    add_barriers(grid);

  unordered_map<SquareGrid::Location, SquareGrid::Location> came_from;
  unordered_map<SquareGrid::Location, double> cost_so_far;
  a_star_search(grid, start, goal, came_from, cost_so_far);

  vector<SquareGrid::Location> path = reconstruct_path(start, goal, came_from);
 draw_grid(grid, 3, nullptr, nullptr, &path);
}

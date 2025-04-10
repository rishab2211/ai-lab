% Representation of a graph using directed edges
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(c, g).

% BFS traversal entry point
bfs(Start, Traversal) :-
    bfs_helper([Start], [], Traversal).

% If the queue is empty, return the visited list as the result
bfs_helper([], Visited, Visited).

% Skip the node if it is already visited
bfs_helper([Current | Rest], Visited, Result) :-
    member(Current, Visited),
    bfs_helper(Rest, Visited, Result).

% Visit the current node and enqueue its unvisited neighbors
bfs_helper([Current | Rest], Visited, Result) :-
    \+ member(Current, Visited),
    findall(Neighbor, (edge(Current, Neighbor), \+ member(Neighbor, Visited), \+ member(Neighbor, Rest)), Neighbors),
    append(Rest, Neighbors, NewQueue),
    bfs_helper(NewQueue, [Current | Visited], Result).

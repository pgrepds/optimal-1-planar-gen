import timeit
import functools

def generateSkeletons(n):
    gen = graphs.quadrangulations(n, minimum_connectivity=3)
    return gen

def addCrossingEdgesToFaces(q):
    for f in q.faces():
        temp = None
        v_1 = None
        v_2 = None
        count = 0
        for e in f:
            if temp == None:
                temp = e
                v_1 = e[0]
                v_2 = e[1]
                continue
            v_x = e[0]
            v_y = e[1]
            
            if addEdge(v_1,v_2,v_x,v_y,q):
                count+=1
            if count == 2:
                break
    return q          

def addEdge(v_1,v_2,v_x,v_y,q):
    if v_1 != v_x and not q.has_edge(v_1,v_x):
        q.add_edge(v_1,v_x)
        return True      
    elif v_2 != v_x and not q.has_edge(v_2,v_x):
        q.add_edge(v_2,v_x)
        return True
    elif v_1 != v_y and not q.has_edge(v_1,v_y):
        q.add_edge(v_1,v_y)
        return True
    elif v_2 != v_y and not q.has_edge(v_2,v_y):
        q.add_edge(v_2,v_y)
        return True
    return False

def generateOptimal1PlanarGraphs(n):
    skeletons = generateSkeletons(n)
    optimal1PlanarGraphs = []
    for skeleton in skeletons:
        o1p = addCrossingEdgesToFaces(skeleton)
        optimal1PlanarGraphs.append(o1p)    
    return optimal1PlanarGraphs

#example of the time measurement process
for n in range(8,14):
    elapsed_time = timeit.timeit(functools.partial(generateOptimal1PlanarGraphs, n), number=1)
    print("vertex count ",n, "time ", elapsed_time)
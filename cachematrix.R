# Function to create a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x) {
  # Initialize the cache
  cache <- NULL
  
  # Function to set the matrix
  set <- function(y) {
    x <<- y  # Use <<- to assign the value to the parent environment
    cache <<- NULL  # Reset the cache when the matrix is changed
  }
  
  # Function to get the matrix
  get <- function() {
    x
  }
  
  # Function to compute and cache the inverse of the matrix
  cacheInverse <- function() {
    if (!is.null(cache)) {
      # Return the cached inverse if available
      message("Getting cached inverse")
      return(cache)
    } else {
      # Compute the inverse of the matrix
      message("Calculating inverse")
      inv <- solve(x)
      
      # Cache the inverse
      cache <<- inv
      
      # Return the inverse
      inv
    }
  }
  
  # Return a list of functions
  list(set = set, get = get, cacheInverse = cacheInverse)
}

# Function to compute the inverse of the matrix (with caching)
cacheSolve <- function(x) {
  # Call the cacheInverse function from the makeCacheMatrix object
  x$cacheInverse()
}

# Example usage
# Create a matrix
A <- matrix(c(1, 2, 3, 4), nrow = 2)

# Create a special matrix object with caching
cacheMatrix <- makeCacheMatrix(A)

# Compute the inverse (will calculate and cache it)
cacheSolve(cacheMatrix)

# Compute the inverse again (will retrieve it from cache)
cacheSolve(cacheMatrix)

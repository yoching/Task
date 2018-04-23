# Task
Simple task handler.
You can write asynchronous tasks in a declarative way.


## Usage

```swift
import Task
import Result

func someAsyncTask1() -> Task<Int, AnyError> {
    return .init { completion in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            completion(.success(1))
        }
    }
}

func someAsyncTask2(int: Int) -> Task<String, AnyError> {
    return .init { completion in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            completion(.success("\(int)"))
        }
    }
}

someAsyncTask1()
    .then { someAsyncTask2(int: $0) } // able to chain tasks with "then"
    .start { result in
        print(result)
}
```

## References

- https://github.com/ReactKit/SwiftTask

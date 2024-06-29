# SwiftUI 学习日志（4）：动画与手势

在本篇文章中，咱们将探讨 SwiftUI 中的**动画**和**手势**。动画和手势是构建现代用户界面的重要组成部分，通过这些特性，我们可以为应用添加丰富的交互体验。

## 1. SwiftUI 动画

SwiftUI 提供了简单而强大的动画工具，帮助我们轻松地为视图添加动画效果。动画可以分为隐式动画和显式动画。

### 1.1 隐式动画

**隐式动画**是指通过修改视图属性，并使用 `.animation` 修饰符自动添加动画效果。

```swift
@State private var isExpanded = false  // 定义一个状态变量

var body: some View {
    VStack {
        Rectangle()
            .fill(Color.blue)
            .frame(width: isExpanded ? 200 : 100, height: 100)
            .animation(.easeInOut(duration: 1.0), value: isExpanded)  // 添加隐式动画
        Button(action: {
            isExpanded.toggle()  // 切换状态
        }) {
            Text("切换大小")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
```

### 1.2 显式动画

**显式动画**是指使用 `withAnimation` 函数来包装状态改变，从而控制动画的时机和方式。

```swift
@State private var rotationAngle: Double = 0  // 定义一个旋转角度状态变量

var body: some View {
    VStack {
        Image(systemName: "arrow.right.circle")
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(rotationAngle))  // 应用旋转效果
        Button(action: {
            withAnimation(.spring()) {
                rotationAngle += 45  // 使用显式动画
            }
        }) {
            Text("旋转")
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
```

### 1.3 组合动画

我们可以将多种动画效果组合在一起，实现复杂的动画效果。

```swift
@State private var scale: CGFloat = 1.0  // 定义一个缩放比例状态变量
@State private var opacity: Double = 1.0  // 定义一个透明度状态变量

var body: some View {
    VStack {
        Circle()
            .fill(Color.red)
            .frame(width: 100, height: 100)
            .scaleEffect(scale)  // 应用缩放效果
            .opacity(opacity)  // 应用透明度效果
        Button(action: {
            withAnimation(.easeInOut(duration: 1.0)) {
                scale = scale == 1.0 ? 1.5 : 1.0  // 切换缩放比例
                opacity = opacity == 1.0 ? 0.5 : 1.0  // 切换透明度
            }
        }) {
            Text("组合动画")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
```

## 2. SwiftUI 手势

SwiftUI 提供了多种手势识别器，帮助我们轻松地为视图添加手势交互。常见的手势包括点击手势、拖动手势、长按手势和缩放手势。

### 2.1 点击手势

**点击手势**用于识别用户的点击操作。

```swift
@State private var isTapped = false  // 定义一个点击状态变量

var body: some View {
    Circle()
        .fill(isTapped ? Color.green : Color.blue)  // 根据点击状态切换颜色
        .frame(width: 100, height: 100)
        .animation(.bouncy, value: isTapped)
        .onTapGesture {
            isTapped.toggle()  // 切换点击状态
        }
}
```

### 2.2 拖动手势

**拖动手势**用于识别用户的拖动操作。

```swift
@State private var offset: CGSize = .zero  // 定义一个偏移量状态变量

var body: some View {
    Circle()
        .fill(Color.orange)
        .frame(width: 100, height: 100)
        .offset(offset)  // 应用偏移量
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation  // 更新偏移量
                }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero  // 重置偏移量
                    }
                }
        )
}
```

### 2.3 长按手势

**长按手势**用于识别用户的长按操作。

```swift
@State private var isLongPressed = false  // 定义一个长按状态变量

var body: some View {
    Circle()
        .fill(isLongPressed ? Color.red : Color.yellow)  // 根据长按状态切换颜色
        .frame(width: 100, height: 100)
        .scaleEffect(isLongPressed ? 1.2 : 1.0)  // 根据长按状态切换缩放比例
        .gesture(
            LongPressGesture(minimumDuration: 1.0)
                .onChanged { _ in
                    isLongPressed = true  // 更新长按状态
                }
                .onEnded { _ in
                    isLongPressed = false  // 重置长按状态
                }
        )
}
```

### 2.4 缩放手势

**缩放手势**用于识别用户的捏合缩放操作。

```swift
@State private var scale: CGFloat = 1.0  // 定义一个缩放比例状态变量

var body: some View {
    Image(systemName: "magnifyingglass")
        .resizable()
        .frame(width: 100, height: 100)
        .scaleEffect(scale)  // 应用缩放效果
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    scale = value  // 更新缩放比例
                }
                .onEnded { _ in
                    withAnimation {
                        scale = 1.0  // 重置缩放比例
                    }
                }
        )
}
```

> 提示：在**预览模式**或者**模拟器**中，按住 **option** 键，**向上**或**向下**拖动拖动触控板可以模拟缩放手势。

## 3. 综合案例：动画与手势的结合

### 3.1 案例简介

咱们将创建一个简单的互动视图，结合动画和手势，展示如何使用 SwiftUI 提供的工具来实现丰富的用户交互体验。

### 3.2 实现步骤

1. **创建主视图**：创建一个包含可拖动和缩放的圆形视图，并在点击时改变颜色。
2. **添加动画效果**：在拖动和缩放过程中添加平滑的动画效果。

### 3.3 代码示例

```swift
import SwiftUI

struct InteractiveCircleView: View {
    @State private var offset: CGSize = .zero  // 定义一个偏移量状态变量
    @State private var scale: CGFloat = 1.0  // 定义一个缩放比例状态变量
    @State private var color: Color = .blue  // 定义一个颜色状态变量

    var body: some View {
        Circle()
            .fill(color)  // 应用颜色
            .frame(width: 100 * scale, height: 100 * scale)  // 根据缩放比例调整大小
            .offset(offset)  // 应用偏移量
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        withAnimation {
                            offset = gesture.translation  // 更新偏移量
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero  // 重置偏移量
                        }
                    }
                    .simultaneously(
                        with: MagnificationGesture()
                            .onChanged { value in
                                withAnimation {
                                    scale = value  // 更新缩放比例
                                }
                            }
                            .onEnded { _ in
                                withAnimation {
                                    scale = 1.0  // 重置缩放比例
                                }
                            }
                    )
            )
            .onTapGesture {
                withAnimation {
                    color = color == .blue ? .green : .blue  // 切换颜色
                }
            }
    }
}

#Preview {
    InteractiveCircleView()
}
```

在这个综合案例中，我们创建了一个可拖动、缩放并且点击时会改变颜色的圆形视图。通过使用动画和手势，我们可以为用户提供丰富的交互体验。

## 4. 结语

在这篇文章中，我们深入探讨了 SwiftUI 的**动画**和**手势**，并通过一个简单的互动视图案例将所学知识应用到实践中。希望你对 SwiftUI 的动画和手势有了更深入的理解。下一篇文章将进一步探讨 SwiftUI 的自定义视图和修饰符，敬请期待。

> 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。

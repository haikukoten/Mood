# wrap改造充满整行的流式布局

## 效果展示

<a href="https://imgchr.com/i/ZhKq4H"><img src="https://s2.ax1x.com/2019/07/13/ZhKq4H.md.png" alt="ZhKq4H.png" border="0" width="249"/></a>

## 关键代码

```dart
@override
void performLayout() {
  assert(_debugHasNecessaryDirections);
  _hasVisualOverflow = false;
  RenderBox child = firstChild;
  if (child == null) {
    size = constraints.smallest;
    return;
  }
  BoxConstraints childConstraints;
  double mainAxisLimit = 0.0;
  bool flipMainAxis = false;
  bool flipCrossAxis = false;
  switch (direction) {
    case Axis.horizontal:
      childConstraints = BoxConstraints(maxWidth: constraints.maxWidth);
      mainAxisLimit = constraints.maxWidth;
      if (textDirection == TextDirection.rtl) flipMainAxis = true;
      if (verticalDirection == VerticalDirection.up) flipCrossAxis = true;
      break;
    case Axis.vertical:
      childConstraints = BoxConstraints(maxHeight: constraints.maxHeight);
      mainAxisLimit = constraints.maxHeight;
      if (verticalDirection == VerticalDirection.up) flipMainAxis = true;
      if (textDirection == TextDirection.rtl) flipCrossAxis = true;
      break;
  }
  assert(childConstraints != null);
  assert(mainAxisLimit != null);
  final double spacing = this.spacing;
  final double runSpacing = this.runSpacing;
  final List<_RunMetrics> runMetrics = <_RunMetrics>[];
  double mainAxisExtent = 0.0;
  double crossAxisExtent = 0.0;
  double runMainAxisExtent = 0.0;
  double runCrossAxisExtent = 0.0;
  int childCount = 0;
  //主轴宽度永远为mainAxisLimit
  mainAxisExtent = mainAxisLimit;
  while (child != null) {
    child.layout(childConstraints, parentUsesSize: true);
    double childMainAxisExtent = _getMainAxisExtent(child);
    double childCrossAxisExtent = _getCrossAxisExtent(child);
    if (childCount > 0 && runMainAxisExtent + spacing + childMainAxisExtent > mainAxisLimit) {
      // 计算空余空间
      final mainAxisFreeSpace = mainAxisLimit - (runMainAxisExtent + spacing);
      // mainAxisExtent = math.max(mainAxisExtent, runMainAxisExtent);
      crossAxisExtent += runCrossAxisExtent;
      if (runMetrics.isNotEmpty) crossAxisExtent += runSpacing;
      final needFillSpace = mainAxisFreeSpace > 0.0;
      // debugPrint("index=$childCount,freeSize=$mainAxisFreeSpace,"
      //     "needFillLast=$needFillSpace,");
      // 如果剩余空间为0，那么不必处理剩余空间
      if (!needFillSpace) {
        runMetrics.add(_RunMetrics(runMainAxisExtent, runCrossAxisExtent, childCount));
      }
      // 否则
      else {
        // 重新调整runCrossAxisExtent
        runCrossAxisExtent = math.max(runCrossAxisExtent, childCrossAxisExtent);
        // 重新调整childCount
        childCount += 1;
        // 每一行矩形右下角坐标(x,y,widget index)=>(mainAxisExtent,runCrossAxisExtent,childCount)
        // x==mainAxisExtent意味着充满这一行
        runMetrics.add(_RunMetrics(mainAxisExtent, runCrossAxisExtent, childCount));
        // 修复最后一个Widget的尺寸
        BoxConstraints spaceConstraints;
        switch (direction) {
          case Axis.horizontal:
            spaceConstraints = BoxConstraints(maxWidth: mainAxisFreeSpace);
            break;
          case Axis.vertical:
            spaceConstraints = BoxConstraints(maxHeight: mainAxisFreeSpace);
            break;
        }
        child.layout(spaceConstraints, parentUsesSize: true);
        // 跳过下一个child，我们会将它安排在本行末,并修正它所在的行数
        final FilledWrapParentData childParentData = child.parentData;
        childParentData._runIndex = runMetrics.length - 1;
        child = childParentData.nextSibling;
        if (child == null) break;
        // 重新测量新的child
        child.layout(childConstraints, parentUsesSize: true);
        childMainAxisExtent = _getMainAxisExtent(child);
        childCrossAxisExtent = _getCrossAxisExtent(child);
      }
      runMainAxisExtent = 0.0;
      runCrossAxisExtent = 0.0;
      childCount = 0;
    }
    runMainAxisExtent += childMainAxisExtent;
    if (childCount > 0) runMainAxisExtent += spacing;
    runCrossAxisExtent = math.max(runCrossAxisExtent, childCrossAxisExtent);
    childCount += 1;
    final FilledWrapParentData childParentData = child.parentData;
    childParentData._runIndex = runMetrics.length;
    child = childParentData.nextSibling;

    ···
}
```

### 下一个计划

- [ ] 补完这份文档
- [ ] 优化FilledWrap填充逻辑
